package com.library.security;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	private final HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
	
	// 로그인 처리
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, 
										HttpServletResponse response,
										Authentication authentication) throws IOException {
		
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
	    String username = userDetails.getUsername();

	    log.info("### {} - {} 로그인 성공!", 
	    		getClass().getSimpleName(), 
	    		username);

	    // 원래 요청으로 리다이렉트
	    SavedRequest savedRequest = requestCache.getRequest(request, response);
	    response.sendRedirect(savedRequest != null ? savedRequest.getRedirectUrl() : "/");

	}

}
