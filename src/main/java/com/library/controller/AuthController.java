package com.library.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.library.dto.Member;
import com.library.dto.PageInfo;
import com.library.service.AuthService;
import com.library.service.BlacklistedTokenService;
import com.library.service.MemberService;
import com.library.service.RefreshTokenService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@CrossOrigin(origins = "*")
public class AuthController {
	private PageInfo pageInfo;
	private final AuthService authService;
	private final RefreshTokenService refreshTokenService;
	private final BlacklistedTokenService blacklistedTokenService;
	private final MemberService memberService;
    
	public void setPageInfo(Model model) {
		model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}
	
	// 로그인 폼 --> ok!!
    @GetMapping("/public/auth/login")
    public String showLoginForm(Model model) {
    	System.out.println("✅ AuthController - /login - GET 요청 정상 처리!");
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("61")
    			.pagePath("page/loginForm.jsp")
    			.build();
    	
    	setPageInfo(model);
        
        return "layout";
    }
	
    // 로그인 처리 --> ok!!
    @PostMapping("/public/auth/login")
    @Transactional
    public ResponseEntity<Void> loginProc(@RequestBody Map<String, String> requestData, 
    		HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	System.out.println("✅ AuthController - /login - POST 요청 정상 처리!");
    	
    	// DB 로그인 검증
    	int membersId = authService.verifyMemberDB(requestData.get("username"), requestData.get("password"));
    	
    	System.out.println("membersId : " + membersId); // DB 로그인 성공은 했는지
    	
    	if (membersId <= 0) {
    		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build(); // 401
    	}
    	
    	// 토큰 관리 처리
    	try {
    		// 액세스 토큰 & 리프레시 토큰 발급
    		Map<String, String> tokens = authService.generateTokens(String.valueOf(membersId));
    		
    		System.out.println(tokens.get("aToken")); // access token 발급은 됐는지
    		System.out.println(tokens.get("rToken")); // refresh token 발급은 됐는지
    		
    		// 액세스 토큰: 쿠키에 저장
    		Cookie cookie = new Cookie("aToken", tokens.get("aToken"));
            cookie.setHttpOnly(true); // JavaScript 접근 불가 (XSS 방지)
            cookie.setSecure(true); // HTTPS에서만 쿠키 전송 (보안 강화)
            cookie.setPath("/"); // 전체 도메인에서 쿠키 사용 가능
            cookie.setMaxAge(600); // 쿠키 유효기간: 10분 (초 단위)
            response.addCookie(cookie);
    		
            int result = refreshTokenService.insertRefreshToken(membersId, tokens.get("rToken"));
            
	        // 리프레시 토큰: DB에 저장
	        if (result <= 0) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build(); // 500
	        }
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build(); // 401
    	}
    	
    	Member member = memberService.getMemberById(membersId);
    	session.setAttribute("currentMember", member);
    	
    	return ResponseEntity.ok().build(); // 200
    }
    
    // 로그아웃 처리 (액세스 토큰 처리 -> 세션 처리) --> 진행중
    @PostMapping("/private/auth/logout/{membersId}")
    public ResponseEntity<Void> logoutProc(@PathVariable("membersId") String membersId, 
    		HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	
    	System.out.println("✅ AuthController - /private/auth/logout/" + membersId + " - POST 요청 정상 처리!");
    	
    	String baToken = "";
    	
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
        	
        	// 블랙리스트에 저장
        	blacklistedTokenService.insertBlacklistedToken(baToken, 0);
        	
        	// 세션에서 회원 정보 제거
        	session.removeAttribute("currentMember");
        	
    	} catch (Exception e) {
    		e.printStackTrace();
    		return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 400
    	}
    	
    	return ResponseEntity.ok().build(); // 200
    }

}
