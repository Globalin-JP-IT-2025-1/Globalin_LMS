package com.library.service;

import java.util.List;
import java.util.Map;

import com.library.model.BookHistory;

public interface MemberBookHistoryService {
	
	// 회원별 도서 이용 정보 목록 전체 조회
	public List<BookHistory> getAllBookHistory(int membersId);
	
	// 회원별 도서 이용 정보 목록 중 연체 목록 조회
	public List<BookHistory> getOverdueBookHistory(int membersId);
	
	// 회원별 연체 누적 일수 및 연체된 도서 권수 구하기
	public Map<String, Integer> getTotalOverdue(int membersId);
	
	// 회원별 도서 이용 정보 수정
	// 1) 도서 반납 처리 : returnedDate
	public int updateBookHistoryReturned(BookHistory bookHistory);
	
	// 2) 도서 연체 처리 : isOverdue
	public int updateBookHistoryOverdue(BookHistory bookHistory);
	
	// 3) 도서 반납예정일 연장 : dueDate
	public int updateBookHistoryDueDate(BookHistory bookHistory);
	
	// 회원별 도서 정보 이력 등록 - 시스템
	public int insertBookHistory(int membersId, int booksId);
	
	// 회원별 도서 정보 이력 삭제 - 시스템
//	public int deleteBookHistory(int bookHistoryId);
	

}
