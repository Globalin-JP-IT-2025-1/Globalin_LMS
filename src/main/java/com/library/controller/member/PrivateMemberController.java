package com.library.controller.member;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.Article;
import com.library.model.BookHistory;
import com.library.model.BookLike;
import com.library.model.Member;
import com.library.model.PageInfo;
import com.library.service.ArticleService;
import com.library.service.AuthService;
import com.library.service.MemberBookHistoryService;
import com.library.service.MemberBookLikeService;
import com.library.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/private/members")
@RequiredArgsConstructor
@PropertySource("classpath:application.properties")
public class PrivateMemberController {
    private final MemberService memberService;
    private final MemberBookHistoryService memberBookHistoryService;
    private final MemberBookLikeService memberBookLikeService;
    private final ArticleService articleService;
    private final AuthService authService;
    
    @Value("${google.maps.api.key}")
    private String apiKey;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
 
    // 회원 정보 조회 --> OK
	// @PreAuthorize("hasRole('ADMIN') or #membersId == authentication.principal.id")
    @GetMapping("/{membersId}")
    public String getMemberById(@RequestParam(value = "status", defaultValue = "1") Integer status, 
    							@PathVariable("membersId") int membersId, HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	Member member = memberService.getMemberById(membersId);
    	//Map<String, Integer> bookOverdueInfo = memberBookHistoryService.getTotalOverdue(membersId);
        
    	model.addAttribute("member", member);
    	//model.addAttribute("bookOverdueInfo", bookOverdueInfo);

    	pageInfo = PageInfo.builder()
			.pageTitleCode("31")
			.pagePath("page/1-member/memberDetail.jsp")
			.build();
    	
    	if (status == 1) {
	    	model.addAttribute("alertType", "success");
	    	model.addAttribute("alertMessage", member.getName() + " 님의 정보 조회를 완료하였습니다.");
    	} else if (status == 2) {
    		model.addAttribute("alertType", "success");
    		model.addAttribute("alertMessage", member.getName() + " 님의 정보 수정을 완료하였습니다.");
    	}
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 회원 정보 수정 폼으로 이동 --> ok
    // @PreAuthorize("hasRole('ADMIN') or #membersId == authentication.principal.id")
    @GetMapping("/{membersId}/edit")
    public String showEditMemberInfo(@RequestParam(value = "status", defaultValue = "1") Integer status, 
    								@PathVariable("membersId") int membersId, HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	Member member = memberService.getMemberById(membersId);
    	
    	model.addAttribute("member", member);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("31")
    			.pagePath("page/1-member/editForm_member.jsp")
    			.build();
    	
		model.addAttribute("apiKey", apiKey);
    	
    	if (status == -1) {
    		model.addAttribute("alertType", "fail");
    		model.addAttribute("alertMessage", "회원 정보 수정을 실패 하였습니다. 다시 시도 해주세요.");
    	}
    	
    	setPageInfo(model);
    	
    	return "layout";
    }

    // 회원 정보 수정 --> OK
    // @PreAuthorize("hasRole('ADMIN') or #membersId == authentication.principal.id")
    @PutMapping("/{membersId}")
    public String updateMemberInfo(@PathVariable("membersId") int membersId, 
    		@ModelAttribute Member member, HttpServletRequest request) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	member.setMembersId(membersId);
    	
    	try {
    		memberService.updateMemberInfo(member);
    	} catch (Exception e) {
    		return "redirect:/private/members/" + membersId + "/edit?status=-1"; // 실패(-1): 회원 정보 수정 폼으로
    	}
    	
    	return "redirect:/private/members/" + membersId + "?status=2"; // 성공(2): 회원 정보 조회로
    }
 
    // 회원 탈퇴 처리
    // 리프레시 토큰 처리 -> 로그아웃 처리(액세스 토큰, 세션) -> 회원 정보 수정
    // @PreAuthorize("hasRole('ADMIN') or #membersId == authentication.principal.id")
    @PutMapping("/{membersId}/leave")
    @Transactional
    public String leaveMember(@PathVariable("membersId") int membersId, 
    		HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), // 클래스
				request.getRequestURI(), // URI
				request.getMethod()); // HTTP 메서드
    	
		// 1) 액세스 토큰 & 리프레시 토큰 : 쿠키에서 가져오기 -> 블랙리스트 올리기 -> 쿠키에서 삭제
    	// 2) 회원 정보 : 쿠키에서 가져오기 -> 삭제
    	Cookie[] cookies = request.getCookies();
    	if (cookies != null) {
    		String aToken = "";
    		String rToken = "";
    		
    		for (Cookie c : cookies) {
    			if (c.getName().equals("aToken") ||
    				c.getName().equals("rToken") ||
    				c.getName().equals("un") ||  
    				c.getName().equals("fn") ||  
    				c.getName().equals("id")) {
    				
    				if (c.getName().equals("aToken")) {
    					aToken = c.getValue(); // 토큰 저장
    				}
    				if (c.getName().equals("rToken")) {
    					rToken = c.getValue(); // 토큰 저장
    				}
    					
    				c.setMaxAge(0); // 쿠키 만료시간 0 설정
        			c.setPath("/"); // 같은 path로 설정
        			
        			response.addCookie(c); // 덮어쓰기
    			}
    		}
    		
    		// 비교용 rToken 삭제
    		authService.deleteRefreshTokens(membersId);
    		
    		// 블랙리스트에 저장
    		authService.insertBlacklistedToken(aToken, 0);
    		authService.insertBlacklistedToken(rToken, 1);
    	}
    	
    	return "redirect:/?status=4"; // 회원 탈퇴 성공(4) : 홈으로 이동
    }
    
    // 회원별 도서 이용 정보 목록 조회
    // @PreAuthorize("hasRole('ADMIN') or #membersId == authentication.principal.id")
    @GetMapping("/{membersId}/book-history")
    public String showMemberBookHistory(@PathVariable("membersId") int membersId, HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	List<BookHistory> bookHistoryList = memberBookHistoryService.getAllBookHistory(membersId);
    	
    	model.addAttribute("bookHistoryList", bookHistoryList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("32")
    			.pagePath("page/1-member/memberBookHistoryList.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // 회원별 관심 도서 목록 조회
    // @PreAuthorize("hasRole('ADMIN') or #membersId == authentication.principal.id")
    @GetMapping("/{membersId}/book-like")
    public String showMemberBookLike(@PathVariable("membersId") int membersId, HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	List<BookLike> bookLikeList = memberBookLikeService.getAllBookLikes(membersId);
    	
    	model.addAttribute("bookLikeList", bookLikeList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("33")
    			.pagePath("page/1-member/memberBookLikeList.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // 회원별 희망 도서 신청 조회
    // @PreAuthorize("hasRole('ADMIN') or #membersId == authentication.principal.id")
    @GetMapping("/{membersId}/book-req")
    public String showMemberBookReq(@PathVariable("membersId") int membersId, HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	List<Article> bookReqList = articleService.getArticlesReqByMembersId(membersId);
    	
    	model.addAttribute("bookReqList", bookReqList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("34")
    			.pagePath("page/1-member/memberBookReqList.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    
    //아이디 중복확인
    
    //이메일 중복확인
    
   
    
}