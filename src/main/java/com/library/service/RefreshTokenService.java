package com.library.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.RefreshTokenMapper;
import com.library.model.RefreshToken;
import com.library.util.JwtUtil;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class RefreshTokenService {
	private RefreshTokenMapper refreshTokenMapper;
	private JwtUtil jwtUtil;
	
	// 리프레시 토큰 목록 조회 (관리자)
	public List<RefreshToken> getAllRefreshTokens() {
		return refreshTokenMapper.getAllRefreshTokens();
	}
	
	// 리프레시 토큰 정보 조회 (회원 탈퇴 시)
	public List<RefreshToken> getRefreshTokenByMembersId(int membersId) {
	    return refreshTokenMapper.getRefreshTokensByMembersId(membersId);
	}
	
	// 리프레시 토큰 추가 (회원 로그인 시)
	public int insertRefreshToken(int membersId, String rToken) {
		
		Timestamp expiresDate = jwtUtil.extractExpiresDate(rToken);

		RefreshToken refreshToken = RefreshToken.builder()
				.membersId(membersId)
				.refreshToken(rToken)
				.expiresDate(expiresDate)
				.build();
		
		System.out.println("리프레시 토큰 DB 저장 - "
				+ "refreshTokenId: " + refreshToken.getRefreshTokenId() + ", "
				+ "membersId: " + refreshToken.getMembersId() + ", "
				+ "refreshToken: " + refreshToken.getRefreshToken() + ", "
				+ "expiresDate: " + refreshToken.getExpiresDate()
		);
		
		return refreshTokenMapper.insertRefreshToken(refreshToken);
	} 
	
	// 만료된 리프레시 토큰 삭제 (회원 탈퇴 시 + 관리자)
	public int deleteRefreshToken(int refreshTokenId) {
		return refreshTokenMapper.deleteRefreshToken(refreshTokenId);
	}

}
