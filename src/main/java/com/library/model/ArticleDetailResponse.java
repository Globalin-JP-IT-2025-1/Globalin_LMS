package com.library.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 게시글 상세 (작성자 포함) + 댓글 목록 (작성자 포함) Service Response 객체 (Service --> Controller)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ArticleDetailResponse {
	
	private ArticleWithAuthor articleWithAuthor; // 게시글 상세 (작성자 포함)
	private ReplyListResponse replyList; // 댓글 목록 (작성자 포함) + 페이징
	
}