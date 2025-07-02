package com.library.model.book;

import com.library.model.SearchRequest;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 회원별 도서별 도서 대출 이력 요청
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookHistoryRequest {
	
	private int membersId; // 회원 ID
	private int booksId; // 대상 도서 ID
	
	private SearchRequest searchRequest; // 검색 요청 객체
	
	private int startRow; // DB에서 가져올 게시글의 시작 행
	private int endRow; // DB에서 가져올 게시글의 마지막 행
	
}
