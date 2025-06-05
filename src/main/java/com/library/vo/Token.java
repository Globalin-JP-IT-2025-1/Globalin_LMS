package com.library.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Token {
	
	private int jwtBlacklistId; // id
	private int membersId; // 회원 id (fk)
	private String type; // 토큰 타입: 액세스 토큰, 리프레시 토큰
	private String token; // 토큰
	private Date expiresDate; // 만료시간

}
