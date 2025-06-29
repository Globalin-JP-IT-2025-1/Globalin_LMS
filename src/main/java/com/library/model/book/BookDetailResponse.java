package com.library.model.book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 도서 상세 + 리뷰 목록 (작성자 포함) Service Response 객체 (Service --> Controller)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BookDetailResponse {
	
	private Book book; // 도서 상세
	private ReviewListResponse reviewListResponse; // 책 리뷰 목록 (작성자 포함) + 페이징
	
}