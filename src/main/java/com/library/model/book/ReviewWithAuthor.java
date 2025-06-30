package com.library.model.book;


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
public class ReviewWithAuthor {
	
	private int bookReviewsId; // 북 리뷰 ID
	private int booksId; // 대상 도서 ID (조회)
	private int authorId; // 작성자 ID (NAME, USERNAME) - 0:관리자
	private String authorUsername; // 작성자 아이디
	private String authorFullname; // 작성자 이름
	private String content; // 내용
	private Timestamp createDate; // 등록 날짜
	private Timestamp updateDate; // 수정 날짜
	private int status; // 상태: 0-공개, 1-비공개(삭제됨), 2-비밀

}
