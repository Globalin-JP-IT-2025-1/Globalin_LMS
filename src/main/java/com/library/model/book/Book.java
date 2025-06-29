package com.library.model.book;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Book {

	private int booksId;        // 도서ID
	
    private String title;        // 제목
    private String author;       // 저자
    private String publisher;    // 출판사
    private Timestamp publishDate;    // 출판날짜
    private String isbn;         // ISBN
    private String category;     // 카테고리: 00,
    private String imageLink;    // 썸네일
    private String description;  // 설명 --> 디테일 link
    
    private Timestamp createDate;     // 등록날짜
    private int viewCount;      // 조회 수
    private int reviewCount;      // 북 리뷰 개수
    private int loanCount;      // 대출 누적 수
    private int likeCount;      // 찜 누적 수
    private int status;         // 도서 상태: 0-기본(대여가능), 1-대여중, 2-대여예약중, 3-비공개(관리자만 보임)

}