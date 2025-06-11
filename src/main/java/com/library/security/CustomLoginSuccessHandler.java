package com.library.security;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.library.model.Member;
import com.library.service.AuthService;
import com.library.service.MemberService;
import com.library.service.RefreshTokenService;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	private AuthService authService;
	private RefreshTokenService refreshTokenService;
	private MemberService memberService;
	
	// 로그인 처리
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
    	System.out.println("✅ CustomLoginSuccessHandler - /public/auth/login - POST 요청 정상 처리!");
    	
    	// 인증 정보에서 username 가져오기
    	String username = authentication.getName();
    	
    	System.out.println("✅ CustomLoginSuccessHandler - 로그인 성공! 사용자: " + username);
    	
    	// ip 주소 가져오기
    	String ipAddress = request.getRemoteAddr();
    	
    	// 회원 정보 가져오기
    	Member member = memberService.getMemberByUsername(username);
    	
    	// 토큰 관리 처리
		// 액세스 토큰 & 리프레시 토큰 발급
		Map<String, String> tokens = authService.generateTokens(username, member.getName(), member.getMembersId());
		
		System.out.println(tokens.get("aToken")); // access token 발급은 됐는지
		System.out.println(tokens.get("rToken")); // refresh token 발급은 됐는지
		
		// 액세스 토큰: 쿠키에 저장
		Cookie cookie = new Cookie("aToken", tokens.get("aToken"));
	    cookie.setHttpOnly(true); // JavaScript 접근 불가 (XSS 방지)
	    cookie.setSecure(true); // HTTPS에서만 쿠키 전송 (보안 강화)
	    cookie.setPath("/"); // 전체 도메인에서 쿠키 사용 가능
	    cookie.setMaxAge(600); // 쿠키 유효기간: 10분 (초 단위)
	    response.addCookie(cookie);
	    
	    refreshTokenService.insertRefreshToken(member.getMembersId(), ipAddress, tokens.get("rToken"));
    	
    }

}

