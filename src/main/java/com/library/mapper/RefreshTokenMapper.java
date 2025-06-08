package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.dto.RefreshToken;

@Mapper
public interface RefreshTokenMapper {

	List<RefreshToken> getAllRefreshTokens(); // 리프레시 토큰 목록 조회 (관리자)
	RefreshToken getRefreshTokenByMembersId(int membersId); // 리프레시 토큰 정보 조회 (회원 탈퇴 시)
	int insertRefreshToken(RefreshToken refreshToken); // 리프레시 토큰 추가 (회원 로그인 시)
	int deleteRefreshToken(int refreshTokenId); // 만료된 리프레시 토큰 수동 삭제 (회원 탈퇴&로그아웃 시) 

}
