package com.library.service;

import java.util.List;
import java.util.Map;

import com.library.model.book.BookHistory;
import com.library.model.book.BookHistoryResponse;

public interface MemberBookHistoryService {
	
	// 회원별 도서 이용 정보 목록 전체 조회
	public BookHistoryResponse getBookHistoryList(int membersId, int page);
	
	// 개수
	public int getBookHistoryListCount(int membersId);
	
	// 회원별 도서별 미납 도서 1건 이용 이력 조회
	public BookHistory getBookHistoryNonReturn(int membersId, int booksId);
	
	// 회원별 도서 이용 정보 목록 중 연체 목록 조회
	public List<BookHistory> getOverdueBookHistory(int membersId);
	
	// 회원별 연체 누적 일수 및 연체된 도서 권수 구하기
	public Map<String, Integer> getTotalOverdue(int membersId);
	
	// 회원별 도서 이용 정보 수정
	// 1) 도서 반납 처리 : returnedDate
	public int updateBookHistoryReturned(int membersId, int booksId);
	
	// 2) 도서 연체 처리 : 
	public int updateBookHistoryOverdue(int membersId, int booksId);
	
	// 3) 도서 반납예정일 연장 : dueDate
	public int updateBookHistoryDueDate(int membersId, int booksId);
	
	// 회원별 도서 이용 정보 등록 - 도서 시스템
	public int insertBookHistory(int membersId, int booksId);
	
	// 회원별 도서 이용 정보 삭제 - 시스템
//	public int deleteBookHistory(int bookHistoryId);
	

}
