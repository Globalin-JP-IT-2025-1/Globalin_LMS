package com.library.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 댓글 목록 (작성자 포함) DB Response 객체 (Service --> Contoller)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReplyListResponse {
	
	private List<ReplyWithAuthor> replyList; // 댓글 목록 (작성자 포함)
	private int totalCount; // 댓글 전체 개수
	private int totalPages; // 댓글 전체 페이지
	
}