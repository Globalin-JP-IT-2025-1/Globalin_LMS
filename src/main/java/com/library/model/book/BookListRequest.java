package com.library.model.book;

import com.library.model.SearchRequest;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 카테고리별 책 목록 DB Request 객체 (Service --> MyBatis)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BookListRequest {
	
	private String category; // 카테고리 - 000, 100, ..
	private SearchRequest searchRequest; // 검색 요청 객체
	private int membersId; // 회원ID - book-history, book-req, book-like
	private int startRow; // DB에서 가져올 게시글의 시작 행
	private int endRow; // DB에서 가져올 게시글의 마지막 행
	
}