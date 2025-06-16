package com.library.util;

import java.util.UUID;

import org.springframework.stereotype.Component;

@Component
public class CommonUtil {
	
	// 랜덤 비밀번호 생성 (6자리) - 비밀번호 재발급, 이메일 인증
	public String getRandomNumber() {
		return UUID.randomUUID().toString().substring(0, 6); 
	}
	
}
