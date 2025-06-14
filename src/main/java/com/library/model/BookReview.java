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
public class BookReview {
	
	private int bookReviewsId; // 댓글 ID
	private int booksId; // 대상 도서 ID (조회)
	private int authorId; // 작성자 ID (NAME, USERNAME) - 0:관리자
	private String content; // 내용
	private Timestamp createDate; // 등록 날짜
	private Timestamp updateDate; // 수정 날짜

}
