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
public class BookLike {
	
	private int bookLikeId; // 관심 도서 ID
	private int membersId; // 회원 ID (조회용)
	private int booksId; // 대상 도서 ID (도서 이미지, 도서명, 저자, 출판사)
	private Timestamp likeDate; // 관심 도서로 저장한 날짜

}
