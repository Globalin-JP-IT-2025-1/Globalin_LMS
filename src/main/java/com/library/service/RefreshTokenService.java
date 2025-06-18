package com.library.service;

import java.util.List;

import com.library.model.RefreshToken;

public interface RefreshTokenService {
	
	// 리프레시 토큰 목록 조회 (관리자)
	public List<RefreshToken> getAllRefreshTokens();
	
	// 리프레시 토큰 정보 조회 (회원 탈퇴 시)
	public List<RefreshToken> getRefreshTokenByMembersId(int membersId);
	
	// 리프레시 토큰 추가 (회원 로그인 시)
	public int insertRefreshToken(int membersId, String rToken);
	
	// 만료된 리프레시 토큰 삭제 (회원 탈퇴 시 + 관리자)
	public int deleteRefreshToken(int refreshTokenId);

}
