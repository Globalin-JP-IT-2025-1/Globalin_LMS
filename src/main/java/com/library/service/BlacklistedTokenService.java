package com.library.service;

import java.util.List;

import com.library.model.BlacklistedToken;

public interface BlacklistedTokenService {

	// 블랙리스트 전체 조회
	public List<BlacklistedToken> getAllBlacklistedTokens();
	
	// 블랙리스트 토큰 인지 확인
	public boolean isBlacklistedToken(String token);
	
	// 탈퇴 & 로그아웃 회원 토큰 추가
	public int insertBlacklistedToken(String token, int type);
	
	// 블랙리스트에서 특정 토큰 수동 삭제
	public int deleteBlacklistedToken(int blacklistedTokenId);

}
