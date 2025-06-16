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
public class BookHistory {
	
	private int bookHistoryId; // 도서 이용 이력 ID
	private int membersId; // 회원 ID
	private int booksId; // 대상 도서 ID (도서 이미지, 도서명, 저자, 출판사)
	private Timestamp loanDate; // 대출 날짜
	private Timestamp dueDate; // 반납 예정 날짜
	private Timestamp returnedDate; // 반납 완료 날짜
	private boolean isOverdue; // 연체 여부

}
