package com.library.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class recBook {
	
	private int recBooksId; // 댓글 ID
	private int booksId; // 대상 도서 ID (조회)
	private Timestamp recoDate; // 추천 날짜

}
