package com.library.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// DB 객체
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	
	private int articlesId; // 게시글ID
	private int authorId; // 작성자: 0-관리자, 1~-회원
	private String category; // 카테고리: not-공지사항, qna-Q&A, req-희망도서신청
	private String title; // 제목
	private String content; // 내용
	private Timestamp createDate; // 최초등록날짜
	private Timestamp updateDate; // 마지막수정날짜
	private int replyCount; // 댓글수
	private int viewCount; // 조회수
	private int status; // 상태: 0-정상, 1-비밀글, 2-비공개글
	
}