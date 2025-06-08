package com.library.service;

import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class TokenBlacklistService {
	private RedisTemplate<String, String> redisTemplate;
	
	// 탈퇴&로그아웃 회원 리프레시 토큰 추가 (자동삭제 30일 후)
	public void addRefreshTokenToBlacklist(String rToken) {
	    redisTemplate.opsForValue().set(rToken, "blacklisted", 30, TimeUnit.DAYS);
	}
	
	// 탈퇴&로그아웃 회원 액세스 토큰 추가 (자동삭제 5분 후)
	public void addAccessTokenToBlacklist(String atoken) {
	    redisTemplate.opsForValue().set(atoken, "blacklisted", 5, TimeUnit.MINUTES);
	}

	// 블랙리스트 토큰 조회
	public boolean isTokenBlacklisted(String token) {
	    return redisTemplate.hasKey(token); // O(1) 연산
	}
	
	// 블랙리스트 전체 조회
	public Set<String> getBlacklistedTokens() {
	    return redisTemplate.keys("*");
	}
	
	// 블랙리스트에서 자동 삭제까지 남은 시간 조회 (초 단위)
	public long getBlacklistTokenTTL(String token) {
	    return redisTemplate.getExpire(token, TimeUnit.SECONDS);
	}
	
	// 블랙리스트에서 특정 토큰 수동 삭제
	public void deleteToken(String token) {
	    redisTemplate.delete(token);
	}

}
