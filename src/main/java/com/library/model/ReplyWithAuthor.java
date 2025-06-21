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
public class ReplyWithAuthor {
	
	private int repliesId; // 댓글 ID
	private int originArticleId; // 원본 게시글 ID (조회)
	private int authorId; // 작성자 ID (NAME, USERNAME) - 0:관리자
	private String authorUsername; // 작성자 아이디
	private String authorFullname; // 작성자 이름
	private String content; // 내용
	private Timestamp createDate; // 등록 날짜
	private Timestamp updateDate; // 수정 날짜
	private int status; // 상태: 0-공개댓글, 1-비공개댓글(삭제됨), 2-비밀댓글

}
