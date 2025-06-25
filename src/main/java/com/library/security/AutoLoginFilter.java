package com.library.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AutoLoginFilter extends OncePerRequestFilter {
    @Autowired
    private AutoLoginProcessor autoLoginProcessor;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		boolean loggedIn = autoLoginProcessor.tryAutoLogin(request, response);
		log.info("인증 객체 생성 여부: " + loggedIn);
	}

}

