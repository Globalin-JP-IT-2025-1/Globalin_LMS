package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.RefreshToken;

@Mapper
public interface RefreshTokenMapper {
	
	// 리프레시 토큰 목록 조회 (관리자)
	List<RefreshToken> getAllRefreshTokens();
	
	// 리프레시 토큰 정보 조회 (membersId 기반)
	List<RefreshToken> getRefreshTokensByMembersId(int membersId);
	
	// 리프레시 토큰 추가 (회원 로그인 시)
	int insertRefreshToken(RefreshToken refreshToken);
	
	// 만료된 리프레시 토큰 수동 삭제 (회원 탈퇴 시)
	int deleteRefreshToken(int refreshTokenId);

}
