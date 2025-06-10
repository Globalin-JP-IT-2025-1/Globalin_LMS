package com.library.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.library.mapper.RefreshTokenMapper;
import com.library.model.RefreshToken;
import com.library.security.JwtUtil;

import lombok.AllArgsConstructor;

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
	public RefreshToken getRefreshTokenByMembersIdAndIpAddress(int membersId, String ipAddress) {
		Map<String, Object> param = new HashMap<>();
		param.put("membersId", membersId);
		param.put("ipAddress", ipAddress);
		
	    RefreshToken refreshToken = refreshTokenMapper.getRefreshTokenByMembersIdAndIpAddress(param);
	    if (refreshToken == null) {
	        throw new RuntimeException("해당 회원의 리프레시 토큰이 존재하지 않습니다.");
	    }
	    return refreshToken;
	}
	
	// 리프레시 토큰 추가 (회원 로그인 시)
	public int insertRefreshToken(int membersId, String ipAddress, String rToken) {
		if (membersId <= 0 || rToken == null || rToken.trim().isEmpty()) {
		    throw new IllegalArgumentException("유효하지 않은 입력값입니다.");
		}
		
		Timestamp expiresDate = jwtUtil.extractExpiresDate(rToken);
		
		RefreshToken refreshToken = RefreshToken.builder()
				.membersId(membersId)
				.refreshToken(rToken)
				.expiresDate(expiresDate)
				.ipAddress(ipAddress)
				.build();
		
		System.out.println(refreshToken.getRefreshTokenId() + ",\n" +
				refreshToken.getMembersId() + ",\n" +
				refreshToken.getRefreshToken() + ",\n" +
				refreshToken.getExpiresDate()
		);
		
		return refreshTokenMapper.insertRefreshToken(refreshToken);
	} 
	
	// 만료된 리프레시 토큰 삭제 (회원 탈퇴&로그아웃 시)
	public int deleteRefreshToken(int refreshTokenId) {
		return refreshTokenMapper.deleteRefreshToken(refreshTokenId);
	}

}
