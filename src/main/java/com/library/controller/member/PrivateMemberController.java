package com.library.controller.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;
import com.library.model.article.ArticleListResponse;
import com.library.model.book.BookHistory;
import com.library.model.book.BookLike;
import com.library.model.member.Member;
import com.library.security.CustomUserDetails;
import com.library.service.ArticleService;
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
    
    @Value("${google.maps.api.key}")
    private String apiKey;
    
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
 
    // 회원 정보 조회
    @GetMapping("/{membersId}")
    public String getMemberById(@PathVariable("membersId") int membersId, 
    							Authentication authentication,
    							Model model) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증된 사용자 정보의 회원 ID와 권한을 확인
    	CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
    	if (user.getMembersId() != membersId && !authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
    		// 권한이 없는 경우 : 홈으로
    	    return "redirect:/?status=-1";
    	}
    	
    	// membersId가 -1로 넘어온 경우 : 현재 로그인한 사용자의 회원ID의 마이페이지로 리다이렉트
    	if (membersId == -1) {
    		String username2 = authentication.getName();
    		Member member2 = memberService.getMemberByUsername(username2);
    		
    		return "redirect:/private/members/" + member2.getMembersId() + "/book-history";
    	}
    	
    	// 회원ID에 해당하는 회원별 도서 이용 정보 목록 가져오기
    	Member member = memberService.getMemberById(membersId);
    	Map<String, Integer> bookOverdueInfo = memberBookHistoryService.getTotalOverdue(membersId);
        
    	model.addAttribute("member", member);
    	model.addAttribute("bookOverdueInfo", bookOverdueInfo);

    	pageInfo = PageInfo.builder()
			.pageTitleCode("31")
			.pagePath("page/1-member/memberDetail.jsp")
			.build();

    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 회원 정보 수정 폼으로 이동
    @GetMapping("/{membersId}/edit")
    public String showEditMemberInfo(@PathVariable("membersId") int membersId, 
    								 Authentication authentication,
    								 Model model) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증된 사용자 정보의 회원 ID와 권한을 확인
    	CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
    	if (user.getMembersId() != membersId && !authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
    		// 권한이 없는 경우 : 홈으로
    	    return "redirect:/?status=-1";
    	}
    	
    	// membersId가 -1로 넘어온 경우 : 현재 로그인한 사용자의 회원ID의 마이페이지로 리다이렉트
    	if (membersId == -1) {
    		String username2 = authentication.getName();
    		Member member2 = memberService.getMemberByUsername(username2);
    		
    		return "redirect:/private/members/" + member2.getMembersId() + "/edit";
    	}
    	
    	// 회원 정보 가져오기
    	Member member = memberService.getMemberById(membersId);
    	model.addAttribute("member", member);
    	model.addAttribute("apiKey", apiKey);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("31")
    			.pagePath("page/1-member/editForm_member.jsp")
    			.build();

    	setPageInfo(model);
    	
    	return "layout";
    }

    // 회원 정보 수정
    @PutMapping("/{membersId}")
    public String updateMemberInfo(@PathVariable("membersId") int membersId, 
								   Authentication authentication,
    							   @ModelAttribute Member member, 
    							   RedirectAttributes redirectAttributes) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증된 사용자 정보의 회원 ID와 권한을 확인
    	CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
    	if (user.getMembersId() != membersId && !authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
    		// 권한이 없는 경우 : 홈으로
    	    return "redirect:/?status=-1";
    	}
    	
    	// 회원 정보 수정 처리
    	try {
    		member.setMembersId(membersId);
    		memberService.updateMemberInfo(member);
    		
    	} catch (Exception e) {
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", "회원 정보 수정 실패");
    		
    		return "redirect:/private/members/" + membersId + "/edit"; // 실패: 회원 정보 수정 폼으로
    	}
    	redirectAttributes.addFlashAttribute("alertType", "success");
    	redirectAttributes.addFlashAttribute("alertMessage", "회원 정보 수정 성공");
    	
    	return "redirect:/private/members/" + membersId; // 성공: 회원 정보 조회로
    }
 
    // 회원 탈퇴 처리
    // 리프레시 토큰 처리 -> 로그아웃 처리(액세스 토큰, 세션) -> 회원 정보 수정
    @PutMapping("/{membersId}/leave")
    public String leaveMember(@PathVariable("membersId") int membersId, 
    						  Authentication authentication,
    						  HttpServletRequest request, 
    						  HttpServletResponse response, 
    						  HttpSession session,
    						  RedirectAttributes redirectAttributes) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증된 사용자 정보의 회원 ID와 권한을 확인
    	CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
    	if (user.getMembersId() != membersId && !authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
    		// 권한이 없는 경우 : 홈으로
    	    return "redirect:/?status=-1";
    	}
    	
    	// 탈퇴 처리
    	try {
    		memberService.updateMemberLeave(membersId);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addFlashAttribute("alertType", "fail");
        	redirectAttributes.addFlashAttribute("alertMessage", "회원 탈퇴 실패");
        	
        	return "redirect:/private/members/" + membersId; // 실패: 회원 정보 조회로
    		
    	}
    	
    	// 로그아웃
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	if (auth != null) {
    	    new SecurityContextLogoutHandler().logout(request, response, auth);
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
    	redirectAttributes.addFlashAttribute("alertMessage", "회원 탈퇴 성공");
    	
    	return "redirect:/"; // 성공: 홈으로
    }
    
    // 회원별 도서 이용 정보 목록 조회
    @GetMapping("/{membersId}/book-history")
    public String showMemberBookHistory(@PathVariable("membersId") int membersId, 
    									Authentication authentication,
    									Model model) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증된 사용자 정보의 회원 ID와 권한을 확인
    	CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
    	if (user.getMembersId() != membersId && !authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
    		// 권한이 없는 경우 : 홈으로
    	    return "redirect:/?status=-1";
    	}
    	
    	// membersId가 -1로 넘어온 경우 : 현재 로그인한 사용자의 회원ID의 마이페이지로 리다이렉트
    	if (membersId == -1) {
    		String username2 = authentication.getName();
    		Member member2 = memberService.getMemberByUsername(username2);
    		
    		return "redirect:/private/members/" + member2.getMembersId() + "/book-history";
    	}
    	
    	// 회원ID에 해당하는 회원별 도서 이용 정보 목록 가져오기
    	List<BookHistory> bookHistoryList = memberBookHistoryService.getBookHistoryList(membersId);
    	model.addAttribute("bookHistoryList", bookHistoryList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("32")
    			.pagePath("page/1-member/memberBookHistoryList.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // 회원별 관심 도서 목록 조회
    @GetMapping("/{membersId}/book-like")
    public String showMemberBookLike(@PathVariable("membersId") int membersId, 
									 Authentication authentication,
    								 Model model) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증된 사용자 정보의 회원 ID와 권한을 확인
    	CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
    	if (user.getMembersId() != membersId && !authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
    		// 권한이 없는 경우 : 홈으로
    	    return "redirect:/?status=-1";
    	}
    	
    	// membersId가 -1로 넘어온 경우 : 현재 로그인한 사용자의 회원ID의 마이페이지로 리다이렉트
    	if (membersId == -1) {
    		String username2 = authentication.getName();
    		Member member2 = memberService.getMemberByUsername(username2);
    		
    		return "redirect:/private/members/" + member2.getMembersId() + "/book-like";
    	}
    	
    	// 회원ID에 해당하는 관심 도서 목록 가져오기
    	List<BookLike> bookLikeList = memberBookLikeService.getBookLikeList(membersId);
    	model.addAttribute("bookLikeList", bookLikeList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("33")
    			.pagePath("page/1-member/memberBookLikeList.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // 회원별 희망 도서 신청 조회
    @GetMapping("/{membersId}/book-req")
    public String showMemberBookReq(@PathVariable("membersId") int membersId,
    		 						@RequestParam(defaultValue = "1") int page,
    		 						Authentication authentication,
    								Model model) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증된 사용자 정보의 회원 ID와 권한을 확인
    	CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
    	if (user.getMembersId() != membersId && !authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
    		// 권한이 없는 경우 : 홈으로
    	    return "redirect:/?status=-1";
    	}
    	
    	// membersId가 -1로 넘어온 경우 : 현재 로그인한 사용자의 회원ID의 마이페이지로 리다이렉트
    	if (membersId == -1) {
    		String username2 = authentication.getName();
    		Member member2 = memberService.getMemberByUsername(username2);
    		
    		return "redirect:/private/members/" + member2.getMembersId() + "/book-req";
    	}
    	
    	// 회원ID에 해당하는 희망 도서 신청 목록 가져오기
    	ArticleListResponse bookReqList = articleService.getArticleListByReqByMembersId(membersId, page);
    	
    	model.addAttribute("articleListWithAuthor", bookReqList.getArticleWithAuthorList());
		model.addAttribute("totalCount", bookReqList.getTotalCount());
    	model.addAttribute("totalPages", bookReqList.getTotalPages());
    	model.addAttribute("currentPage", page);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("34")
    			.pagePath("page/1-member/memberBookReqList.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
}