package com.library.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {
	
	// 로그인 실패 시 처리
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), // 클래스
				request.getRequestURI(), // URI
				request.getMethod()); // HTTP 메서드
		
		log.error("### 로그인 실패 : " + exception.getMessage());
		
		request.getSession().setAttribute("LOGIN_ERROR_MSG", exception.getMessage()); // 에러 메시지
		response.sendRedirect("/public/auth/login/fail"); // 로그인 페이지
	}

}

