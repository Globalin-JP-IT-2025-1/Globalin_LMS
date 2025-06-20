package com.library.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.BlacklistedTokenMapper;
import com.library.model.BlacklistedToken;
import com.library.service.BlacklistedTokenService;
import com.library.util.JwtUtil;

import lombok.AllArgsConstructor;

@Service("blacklistedTokenService")
@AllArgsConstructor
public class BlacklistedTokenServiceImpl implements BlacklistedTokenService {
	private BlacklistedTokenMapper blacklistedTokenMapper;
	private JwtUtil jwtUtil;

	// 블랙리스트 전체 조회
	@Override
	public List<BlacklistedToken> getAllBlacklistedTokens() {
		return blacklistedTokenMapper.getAllBlacklistedTokens();
	}
	
	// 블랙리스트 토큰 인지 확인
	@Override
	public boolean isBlacklistedToken(String token) {
		List<BlacklistedToken> list = getAllBlacklistedTokens();
		for (BlacklistedToken bt : list) {
			if (token.equals(bt.getToken())) {
				return true;
			}
		}
		return false;
	}
	
	// 탈퇴 & 로그아웃 회원 토큰 추가
	@Override
	public int insertBlacklistedToken(String token, int type) {
		Timestamp expriresDate = jwtUtil.extractExpiresDate(token);
		
		BlacklistedToken blacklistedToken = BlacklistedToken.builder()
				.type(type)
				.token(token)
				.expiresDate(expriresDate)
				.build();
		
		return blacklistedTokenMapper.insertBlacklistedToken(blacklistedToken);
	}
	
	// 블랙리스트에서 특정 토큰 수동 삭제
	@Override
	public int deleteBlacklistedToken(int blacklistedTokenId) {
		return blacklistedTokenMapper.deleteBlacklistedToken(blacklistedTokenId);
	}

}
