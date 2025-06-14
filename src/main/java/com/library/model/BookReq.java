package com.library.model;

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
public class BookReq {
	
	private int bookReqId; // 도서 신청 ID
	private int membersId; // 회원 ID (조회용)
	private int articlesId; // 원본글 ID
	private int status; // 상태 : 0-접수됨, 1-처리중, 2-처리완료

}
