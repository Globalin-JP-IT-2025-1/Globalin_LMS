package com.library.service;

import org.springframework.stereotype.Service;

import com.library.mapper.TokenMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class TokenService {
	private final TokenMapper tokenMapper;

	public int addToBlacklist(int membersId) {
		return tokenMapper.addToken(membersId);
	}
	
	public int invalidateTokens(int membersId) {
		
		// 브라우저 세션에서 액세스 토큰 제거
		// 쿠키에서 리프레시 토큰 제거
		
		return 0;
		
	}

}
