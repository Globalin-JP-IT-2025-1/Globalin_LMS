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
public class BlacklistedToken {
	
	private int BlacklistedTokenId; // id
	private int type; // 종류 : 0-액세스 토큰, 1-리프레시 토큰
	private String token; // 토큰
	private Timestamp expiresDate; // 만료시간

}
