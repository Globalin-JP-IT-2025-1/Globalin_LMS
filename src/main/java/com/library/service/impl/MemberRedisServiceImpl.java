package com.library.service.impl;

import java.util.concurrent.TimeUnit;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.library.service.MemberRedisService;

import lombok.AllArgsConstructor;

// Redis - 회원 관리 (비밀번호 오류 횟수)
@Service("memberRedisService")
@AllArgsConstructor
public class MemberRedisServiceImpl implements MemberRedisService {
	private RedisTemplate<String, String> redisTemplate;
	
	// 비밀번호 오류 횟수 조회
	@Override
	public int getLoginFailCount(int membersId) {
        String key = "loginFail:" + membersId;
        String count = (String) redisTemplate.opsForHash().get(key, "wrongPw");
        return count != null ? Integer.parseInt(count) : 0;
    }
	
	// 비밀번호 오류 횟수 갱신
	@Override
	public void updateLoginFailCount(int membersId) {
	    String key = "loginFail:" + membersId;
	    redisTemplate.opsForHash().increment(key, "wrongPw", 1); // 값 증가 (없으면 추가)
	    redisTemplate.expire(key, 30, TimeUnit.MINUTES); // 30분 후 자동 초기화
	}
    
    // 로그인이 가능한 지 확인 (실패 횟수 5회 이상인 경우 차단)
	@Override
    public boolean isLoginAllowed(int memberId) {
        String cacheKey = "loginFail:" + memberId;
        String failCountStr = (String) redisTemplate.opsForHash().get(cacheKey, "wrongPw");

        int failCount = (failCountStr == null) ? 0 : Integer.parseInt(failCountStr);

        return failCount < 5;
    }

}
