package com.library.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import com.library.service.AuthService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@AllArgsConstructor
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {
	private final AuthService authService;
	
	// 로그아웃 처리
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), // 클래스
				request.getRequestURI(), // URI
				request.getMethod()); // HTTP 메서드
		
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		log.info("### {} - {} 로그아웃 성공!", 
				this.getClass().getSimpleName(), // 클래스 
				userDetails.getUsername()); // 인증된 사용자의 username
		
		// 1) 쿠키에서 회원 정보 제거 --> 시큐리티에서 알아서 해줌.
		
		// 2) 쿠키에서 액세스 토큰 제거
		// 관리자의 경우 토큰 제외
		if (!userDetails.getUsername().equals("admin")) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				String aToken = "";
				for (Cookie c : cookies) {
					if (c.getName().equals("aToken")) {
						aToken = c.getValue();
						
						c.setMaxAge(0);
						c.setPath("/");
						response.addCookie(c);
					} 
				}
				
				if (aToken != null) {
					// 유효성 검사 후 유효하면 블랙리스트에 올리기
					authService.insertBlacklistedToken(aToken, 0);
				}
			}
		}
		
		response.sendRedirect("/?status=3"); // 로그아웃 성공(3) : 메인 페이지로 이동
		
	}

}
