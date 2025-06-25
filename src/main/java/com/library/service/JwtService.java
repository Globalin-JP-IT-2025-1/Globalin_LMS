package com.library.service;

import java.util.Map;

import org.springframework.security.core.Authentication;

public interface JwtService {
    
    // 토큰 검증 (무결성, 유효시간, 회원 존재 여부, 블랙리스트)
    public boolean isValidToken(String token);
    
    // 토큰 세트 발급
    public Map<String, String> generateTokens(String username);
    
    // 토큰 유효성 검사 후 블랙리스트 추가
    public void insertBlacklistedToken(String token, int type);
    
    // DB 리프레시 토큰 삭제 요청
	public void deleteRefreshTokens(int membersId);
	
	// 토큰에서 권한 정보 얻기
	public Authentication getAuthentication(String token);
	
	// 토큰에서 username 얻기
	public String getUsername(String token);
    
    // DB 로그인 검증 --> Spring Security 로 이전
	

}
