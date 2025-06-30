package com.library.model.book;

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
public class BookLikeDeleteRequest {
	
	private int membersId; // 회원 ID (조회용)
	private int booksId; // 대상 도서 ID (도서 이미지, 도서명, 저자, 출판사)

}
