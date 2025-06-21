package com.library.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 게시글 목록 (작성자 포함) DB Response 객체 (DB --> Service)
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ArticleWithAuthor {
	
	private int articlesId; // 게시글ID
	private int authorId; // 작성자: 0-관리자, 1~-회원
	private String authorUsername; // 작성자 아이디
	private String authorFullname; // 작성자 이름
	private String category; // 카테고리
	private String title; // 제목
	private String content; // 내용
	private Timestamp createDate; // 최초 작성 날짜
	private Timestamp updateDate; // 마지막 수정 날짜
	private int replyCount; // 댓글수
	private int viewCount; // 조회수
	private int status; // 상태: 0-정상, 1-비밀글, 2-비공개글
	
}