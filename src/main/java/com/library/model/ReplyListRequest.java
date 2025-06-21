package com.library.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 댓글 목록 (작성자 포함) DB Request 객체 (Service --> MyBatis)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReplyListRequest {
	
	private int originArticleId; // 원본 게시글 ID
	private int startRow; // DB에서 가져올 댓글의 시작 행
	private int endRow; // DB에서 가져올 댓글의 마지막 행
	
}