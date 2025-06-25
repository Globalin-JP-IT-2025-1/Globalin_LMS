package com.library.security;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.library.service.JwtService;
import com.library.service.RefreshTokenService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	private final HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
	private final JwtService jwtService;
	private final RefreshTokenService refreshTokenService;
	
	// 로그인 처리
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), // 클래스
				request.getRequestURI(), // URI
				request.getMethod()); // HTTP 메서드

		// 1) 인증 가져온 후 쿠키에 저장
		// 인증 정보에서 username, name, membersId 가져오기
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		String username = userDetails.getUsername(); // 아이디
		int membersId = userDetails.getMembersId(); // membersId
		
		log.info("### {} - {} 로그인 성공!", 
				this.getClass().getSimpleName(), // 클래스
				username); // 인증된 사용자의 username
		
		// 2) 액세스 토큰 & 리프레시 토큰 생성 후 쿠키에 저장
		Map<String, String> tokens = jwtService.generateTokens(username);
		
        String aToken = tokens.get("aToken");
        String rToken = tokens.get("rToken");
        
        // 토큰 세트가 쿠키에 이미 있는 경우 : 블랙리스트에 추가
        
        
        // 쿠키 생성 및 response에 추가
 		Cookie aTokenCookie = new Cookie("aToken", aToken);
		
 		aTokenCookie.setMaxAge((int) (SecurityConstants.ACCESS_EXPIRATION_TIME/1000)); // 30분 유지
 		aTokenCookie.setHttpOnly(true);
 		aTokenCookie.setSecure(true);
 		aTokenCookie.setPath("/");
 		
 		Cookie rTokenCookie = new Cookie("rToken", rToken);
 		
 		rTokenCookie.setMaxAge((int) (SecurityConstants.REFRESH_EXPIRATION_TIME/1000)); // 15일 유지
 		rTokenCookie.setHttpOnly(true);
 		rTokenCookie.setSecure(true);
 		rTokenCookie.setPath("/");

		response.addCookie(aTokenCookie);
		response.addCookie(rTokenCookie);
		
		// refreshToken DB 저장
		refreshTokenService.insertRefreshToken(membersId, rToken);
		
		// 3) 이전 요청 정보 가져온 후 redirect
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		if (savedRequest != null) {
			String targetUrl = savedRequest.getRedirectUrl(); // 원래 요청한 페이지 URL
			response.sendRedirect(targetUrl); // 로그인 후 원래 페이지로 이동
		} else {
			response.sendRedirect("/"); // 로그인 성공 : 메인 페이지로 이동
		}

	}

}
