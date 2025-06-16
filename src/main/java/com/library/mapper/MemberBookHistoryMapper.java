package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.BookHistory;

@Mapper
public interface MemberBookHistoryMapper {
	
	// 회원별 도서 이용 목록 전체 조회 - 회원
	public List<BookHistory> getAllBookHistory(int membersId);
	
	// 회원별 도서 이용 목록 중 연체 중인 도서만 조회 (연체일수, 연체도서권수 계산용) - 시스템
	public List<BookHistory> getOverdueBookHistory(int membersId);
	
	
	// 회원별 도서 이용 정보 수정 - 시스템
	public int updateBookHistoryReturned(BookHistory bookHistory); // 1) 도서 반납 처리 (returnedDate)
	public int updateBookHistoryOverdue(BookHistory bookHistory); // 2) 도서 연체 처리 (isOverdue)
	public int updateBookHistoryDueDate(BookHistory bookHistory); // 3) 도서 반납예정일 연장 (dueDate)
	
	// 회원별 도서 이용 정보 추가 - 시스템
	public int insertBookHistory(BookHistory bookHistory);
	
	// 회원별 도서 이용 정보 삭제 - 시스템
	public int deleteBookHistory(int bookHistoryId);

}
