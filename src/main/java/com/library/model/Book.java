package com.library.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Book {

	private int booksId;        // 도서ID
    private String title;        // 제목
    private String author;       // 저자
    private String publisher;    // 출판사
    private Timestamp publishDate;    // 출판날짜
    private String isbn;         // ISBN
    private String category;     // 카테고리: 총류, ...
    private String imageLink;    // 썸네일
    private String description;  // 설명
    private Timestamp createDate;     // 등록날짜
    private int loanCount;      // 대출횟수
    private int likeCount;      // 북마크개수
    private int status;         // 도서 상태: 0-기본, 1-대여중, 2-대여예약중

}