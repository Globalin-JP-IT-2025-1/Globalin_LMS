package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.dto.BlacklistedToken;
import com.library.mapper.BlacklistedTokenMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BlacklistedTokenService {
	private BlacklistedTokenMapper blacklistedTokenMapper;

	// 블랙리스트 전체 조회
	public List<BlacklistedToken> getAllBlacklistedTokens() {
		return blacklistedTokenMapper.getAllBlacklistedTokens();
	}
	
	// 블랙리스트 토큰 조회
	public int getBlacklistedTokenByToken(String token) {
		return blacklistedTokenMapper.getBlacklistedTokenByToken(token);
	}
	
	// 탈퇴 & 로그아웃 회원 토큰 추가
	public int insertBlacklistedToken(BlacklistedToken blacklistedToken) {
		return blacklistedTokenMapper.insertBlacklistedToken(blacklistedToken);
	}
	
	// 블랙리스트에서 특정 토큰 수동 삭제
	public int deleteBlacklistedToken(int blacklistedTokenId) {
		return blacklistedTokenMapper.deleteBlacklistedToken(blacklistedTokenId);
	}

}
