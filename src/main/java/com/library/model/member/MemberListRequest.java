package com.library.model.member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 회원 목록 DB Request 객체 (Service --> MyBatis)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MemberListRequest {
	
	private int startRow; // DB에서 가져올 게시글의 시작 행
	private int endRow; // DB에서 가져올 게시글의 마지막 행
	
}