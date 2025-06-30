package com.library.model.book;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 책 리뷰 목록 DB Request 객체 (Service --> MyBatis)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReviewListRequest {
	
	private int booksId; // 대상 도서 ID
	private int startRow; // DB에서 가져올 댓글의 시작 행
	private int endRow; // DB에서 가져올 댓글의 마지막 행
	
}