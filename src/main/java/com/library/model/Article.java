package com.library.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	
	private int articlesId; // 게시글ID
	private int authorId; // 작성자
	private String category; // 카테고리
	private String title; // 제목
	private String content; // 내용
	private Date createDate; // 최초등록날짜
	private Date updateDate; // 마지막수정날짜
	private int replyCount; // 댓글수
	private int viewCount; // 조회수
	private boolean isSecret; // 비밀글여부

}
