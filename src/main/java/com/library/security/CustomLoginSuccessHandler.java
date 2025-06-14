package com.library.security;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
//	private AuthService authService;
//	private RefreshTokenService refreshTokenService;
	private final HttpSessionRequestCache requestCache = new HttpSessionRequestCache();

	// 로그인 처리
	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
    	System.out.println("✅ CustomLoginSuccessHandler - /public/auth/login - POST 요청 정상 처리!");
    	
    	// 1) 인증 가져온 후 쿠키에 저장
		// 인증 정보에서 username, name, membersId 가져오기 
    	CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		System.out.println("✅ CustomLoginSuccessHandler - 로그인 성공! 사용자: " + userDetails.getUsername());
		
		// 쿠키 생성
		Cookie[] cookies = new Cookie[] {
			new Cookie("un", userDetails.getUsername()),
			new Cookie("fn", userDetails.getFullname()),
			new Cookie("id", String.valueOf(userDetails.getMembersId()))
		};
        
		for (Cookie c : cookies) {
			// 쿠키 속성 설정
	        c.setMaxAge(60 * 60 * 24); // 1일 유지
	        c.setHttpOnly(true); // JavaScript 접근 불가 (XSS 방지) 
	        c.setSecure(true);  // HTTPS에서만 쿠키 전송 (보안 강화) 
	        c.setPath("/"); // 전체 도메인에서 쿠키 사용 가능
	        
	        // response에 추가
	        response.addCookie(c);
		}
		
        // 2) 토큰 생성 및 쿠키에 저장
		// ip 주소 가져오기
//		String ipAddress = request.getRemoteAddr();
		// 토큰 관리 처리
		// 액세스 토큰 & 리프레시 토큰 발급 
//		Map<String, String> tokens = authService.generateTokens(username, member.getName(), member.getMembersId());

//		System.out.println(tokens.get("aToken")); // access token 발급은 됐는지
//		System.out.println(tokens.get("rToken")); // refresh token 발급은 됐는지
		
		// 액세스 토큰: 쿠키에 저장 
//		Cookie cookie = new Cookie("aToken", tokens.get("aToken"));
//		cookie.setHttpOnly(true); // JavaScript 접근 불가 (XSS 방지)
//		cookie.setSecure(true); // HTTPS에서만 쿠키 전송 (보안 강화)
//		cookie.setPath("/"); // 전체 도메인에서 쿠키 사용 가능 
//		cookie.setMaxAge(600); // 쿠키 유효기간: 10분 (초 단위)
//		response.addCookie(cookie);
		 
		 // 리프레시 토큰: 쿠키에 저장 
//		Cookie cookie2 = new Cookie("rToken", tokens.get("rToken"));
//		cookie2.setHttpOnly(true); // JavaScript 접근 불가 (XSS 방지) 
//		cookie2.setSecure(true);  // HTTPS에서만 쿠키 전송 (보안 강화) 
//		cookie2.setPath("/"); // 전체 도메인에서 쿠키 사용 가능 
//		cookie2.setMaxAge(604800); // 쿠키 유효기간: 7일 (초 단위)
//		response.addCookie(cookie2);

    	
    	// 3) 이전 요청 정보 가져온 후 redirect
        SavedRequest savedRequest = requestCache.getRequest(request, response);

        if (savedRequest != null) {
            String targetUrl = savedRequest.getRedirectUrl();  // 원래 요청한 페이지 URL
            response.sendRedirect(targetUrl);  // 로그인 후 원래 페이지로 이동
        } else {
            response.sendRedirect("/?login=true");  // 기본 페이지로 이동
        }
    	
    	
    }

}
