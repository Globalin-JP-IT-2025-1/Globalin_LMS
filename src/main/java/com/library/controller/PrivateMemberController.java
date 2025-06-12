package com.library.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Member;
import com.library.model.PageInfo;
import com.library.model.RefreshToken;
import com.library.service.BlacklistedTokenService;
import com.library.service.MemberService;
import com.library.service.RefreshTokenService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/private/members")
@AllArgsConstructor
public class PrivateMemberController {
    private final MemberService memberService;
    private final RefreshTokenService refreshTokenService;
    private final BlacklistedTokenService blacklistedTokenService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
 
    // 회원 정보 조회 --> OK
	/* @PreAuthorize("hasRole('ADMIN') or @memberService.canAccess(#membersId)") */
    @GetMapping("/{membersId}")
    public String getMemberById(@PathVariable("membersId") int membersId, Model model) {
    	System.out.println("✅ PrivateMemberController - /private/members/" + membersId + " - GET 요청 정상 처리!");
    	
    	Member member = memberService.getMemberById(membersId);
        
    	model.addAttribute("member", member);

    	pageInfo = PageInfo.builder()
			.pageTitleCode("31")
			.pagePath("page/memberDetail.jsp")
			.build();
    	
    	model.addAttribute("alertType", "success");
    	model.addAttribute("alertMessage", "" + member.getName() + " 님의 상세 정보 조회를 완료하였습니다.");
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 회원 정보 수정 폼으로 이동 --> OK
    @GetMapping("/{membersId}/edit")
    public String showEditMemberInfo(@PathVariable("membersId") int membersId, Model model) {
    	System.out.println("✅ PrivateMemberController - /private/members/" + membersId + "/edit - GET 요청 정상 처리!");
    	
    	Member member = memberService.getMemberById(membersId);
    	
    	model.addAttribute("member", member);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("31")
    			.pagePath("page/editForm_member.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }

    // 회원 정보 수정 --> OK
    @PutMapping("/{membersId}")
    public ResponseEntity<Void> updateMemberInfo(@PathVariable("membersId") int membersId, 
    		@RequestBody Map<String, String> requestData) {
    	System.out.println("✅ PrivateMemberController - /private/members/" + membersId + " - PUT 요청 정상 처리!");
    	
    	Member member = memberService.getMemberById(membersId);
    	
    	if (member == null) {
    		return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // 404 (회원 없음)
    	}
    	
    	member.setPassword(requestData.get("password"));
    	member.setMobile(requestData.get("mobile"));
    	member.setZipcode(requestData.get("zipcode"));
    	member.setAddress(requestData.get("address"));
    	
    	int result = memberService.updateMemberInfo(member);
    	
    	if (result == -1) {
        	return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 400
    	}
    	
    	return ResponseEntity.ok().build(); // 200
    }
 
    // 회원 탈퇴 처리 (리프레시 토큰 처리 -> 로그아웃 처리(액세스 토큰 처리 -> 세션 처리) -> 회원 정보 수정)
    @PutMapping("/{membersId}/leave")
    public ResponseEntity<Void> leaveMember(@PathVariable("membersId") int membersId, 
    		HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	
    	System.out.println("✅ PrivateMemberController - /private/members/" + membersId + "/leave - PUT 요청 정상 처리!");
    	
    	String baToken = "";
    	String brToken = "";
    	
    	// ip 주소 얻기
    	String ipAddress = request.getRemoteAddr();
    	
    	try {
    		// 액세스 토큰: 쿠키에서 가져온 후 저장 후 삭제
        	Cookie[] cookies = request.getCookies();
        	for (Cookie cookie : cookies) {
    			if (cookie.getName().equals("aToken")) {
    				baToken = cookie.getValue(); // 토큰 저장
    			}
    			cookie.setMaxAge(0); // 쿠키 만료시간 0 설정
    			cookie.setPath("/"); // 같은 path로 설정
    			response.addCookie(cookie); // 덮어쓰기
    		}
        	
        	// 리프레시 토큰: DB에서 가져온 후 저장 후 삭제
        	RefreshToken rToken = refreshTokenService.getRefreshTokenByMembersIdAndIpAddress(membersId, ipAddress);
        	brToken = rToken.getRefreshToken();
        	refreshTokenService.deleteRefreshToken(rToken.getRefreshTokenId());
        	
        	// 블랙리스트에 저장
        	blacklistedTokenService.insertBlacklistedToken(baToken, 0);
        	blacklistedTokenService.insertBlacklistedToken(brToken, 1);
        	
        	// 세션에서 회원 정보 제거
        	session.removeAttribute("currentMember");
        	
    	} catch (Exception e) {
    		e.printStackTrace();
    		return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 400
    	}
    	
    	return ResponseEntity.ok().build(); // 200
    }
    
    // 회원별 관심 도서 목록
    @PreAuthorize("#membersId == authentication.principal.id")
    @GetMapping("/{membersId}/book-like")
    public String getMemberBookLikes(@PathVariable("membersId") int membersId, Model model) {
    	System.out.println("✅ PrivateMemberController - /private/members/" + membersId + "/book-like - GET 요청 정상 처리!");
    	
    	if (membersId == 0) {
    		return "redirect:/pulbic/auth/login?status=0";
    	}
    	
    	Member member = memberService.getMemberById(membersId);
    	
    	model.addAttribute("member", member);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("31")
    			.pagePath("page/editForm_member.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
}