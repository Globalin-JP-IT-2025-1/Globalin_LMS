package com.library.dto;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Component
public class RefreshToken {
	
	private int refreshTokenId; // id
	private int membersId; // 회원 id
	private String refreshToken; // 토큰
	private Timestamp expiresDate; // 만료시간
	/*
	 * private String ipAddress; // ip주소
	 */
}
