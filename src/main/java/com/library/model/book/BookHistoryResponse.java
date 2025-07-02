package com.library.model.book;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 책 목록 Service Response 객체 (Service --> Controller)
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BookHistoryResponse {
	
	private List<BookHistoryWithBookInfo> bookHistoryList; // 도서 이용 정보 목록
    private int totalCount; // 전체 개수
    private int totalPages; // 전체 페이지
	
}