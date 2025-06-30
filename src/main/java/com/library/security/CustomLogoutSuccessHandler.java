package com.library.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@AllArgsConstructor
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {
	
	// 로그아웃 처리
	@Override
	public void onLogoutSuccess(HttpServletRequest request, 
								HttpServletResponse response, 
								Authentication authentication) throws IOException, ServletException {
		
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), // 클래스
				request.getRequestURI(), // URI
				request.getMethod()); // HTTP 메서드
		
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		log.info("### {} - {} 로그아웃 성공!", 
				this.getClass().getSimpleName(), // 클래스 
				userDetails.getUsername()); // 인증된 사용자의 username
		
		response.sendRedirect("/"); // 메인 페이지로 이동
		
	}

}
