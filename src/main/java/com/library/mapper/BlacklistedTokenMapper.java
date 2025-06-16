package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.BlacklistedToken;

@Mapper
public interface BlacklistedTokenMapper {
	
	List<BlacklistedToken> getAllBlacklistedTokens(); // 차단된 토큰 목록 조회 (관리자)
	int insertBlacklistedToken(BlacklistedToken blacklistedToken); // 차단된 토큰 추가 (회원 탈퇴&로그아웃 시)
	int deleteBlacklistedToken(int blacklistedTokenId); // 만료된 토큰 수동 삭제 (관리자)
	
}
