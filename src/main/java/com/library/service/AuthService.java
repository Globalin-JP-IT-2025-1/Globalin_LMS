package com.library.service;

import java.util.Map;

public interface AuthService {
    
    // 액세스 토큰 검증 (무결성, 유효시간, 회원 존재 여부, 블랙리스트)
    public boolean isValidToken(String token);
    
    // 액세스 토큰 발급 & 리프레시 토큰 발급
    public Map<String, String> generateTokens(String username, String name, String membersId);
    
    // 액세스 토큰 유효성 검사 후 유효한 경우 블랙리스트에 올리기 (로그아웃 성공 시 or 탈퇴 시)
    public void insertBlacklistedToken(String token, int type);
    
    // DB 리프레시 토큰 삭제 요청 (
	public void deleteRefreshTokens(int membersId);
    
    // DB 로그인 검증 --> Spring Security 로 이전
	

}
