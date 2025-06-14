package com.library.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.library.util.JwtUtil;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class AuthService {
	private final JwtUtil jwtUtil;
    
    // 액세스 토큰 검증 (무결성, 유효시간, 회원 존재 여부, 블랙리스트)
    public boolean isValidAccessToken(String aToken) {
    	return jwtUtil.isValidToken(aToken);
    }
    
    // 리프레시 토큰 검증 (무결성, 유효시간, 회원 존재 여부, 블랙리스트)
    public boolean isValidRefreshToken(String rtoken) {
    	return jwtUtil.isValidToken(rtoken);
    }
	
    // 액세스 토큰 발급 & 리프레시 토큰 발급
    public Map<String, String> generateTokens(String username, String name, int membersId) {
    	return jwtUtil.generateTokens(username, name, String.valueOf(membersId));
    }
    
    
    // DB 로그인 검증 --> Spring Security 로 이전

}
