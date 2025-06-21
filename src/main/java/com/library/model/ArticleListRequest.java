package com.library.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 카테고리별 게시글 목록 (작성자 포함) DB Request 객체 (Service --> MyBatis)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ArticleListRequest {
	
	private String category; // 카테고리 - not, faq, qna, req
	private int membersId; // 회원ID - book-history, book-req, book-like
	private int startRow; // DB에서 가져올 게시글의 시작 행
	private int endRow; // DB에서 가져올 게시글의 마지막 행
	
}