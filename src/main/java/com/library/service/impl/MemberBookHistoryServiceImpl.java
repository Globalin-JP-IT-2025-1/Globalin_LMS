package com.library.service.impl;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.library.mapper.MemberBookHistoryMapper;
import com.library.model.BookHistory;
import com.library.service.MemberBookHistoryService;

import lombok.AllArgsConstructor;

@Service("memberBookHistoryService")
@AllArgsConstructor
public class MemberBookHistoryServiceImpl implements MemberBookHistoryService {
	private final MemberBookHistoryMapper memberBookHistoryMapper;
	
	// 회원별 도서 이용 정보 목록 전체 조회
	@Override
	public List<BookHistory> getAllBookHistory(int membersId) {
		return memberBookHistoryMapper.getAllBookHistory(membersId);
	}
	
	// 회원별 도서 이용 정보 목록 중 연체 목록 조회
	@Override
	public List<BookHistory> getOverdueBookHistory(int membersId) {
		return memberBookHistoryMapper.getOverdueBookHistory(membersId);
	}
	
	// 회원별 연체 누적 일수 및 연체된 도서 권수 구하기
	@Override
	public Map<String, Integer> getTotalOverdue(int membersId) {
		List<BookHistory> bookHistory = getOverdueBookHistory(membersId);
		
		Map<String, Integer> totalOverdue = new HashMap<>();
		
		int totalOverdueDay = 0;
		
		// 오늘 날짜 설정
		LocalDateTime currentDate = LocalDateTime.now();
		
		for (BookHistory bh : bookHistory) {
			LocalDate dueDate = bh.getDueDate().toLocalDateTime().toLocalDate();
			int overdueDay = Math.toIntExact(ChronoUnit.DAYS.between(dueDate, currentDate));
			
			totalOverdueDay += overdueDay;
		}
		
		totalOverdue.put("day", totalOverdueDay);
		totalOverdue.put("count", bookHistory.size());
		
		return totalOverdue;
	}
	
	// 회원별 도서 이용 정보 수정
	// 1) 도서 반납 처리 : returnedDate
	@Override
	public int updateBookHistoryReturned(BookHistory bookHistory) {
		// 오늘 날짜 설정
		LocalDateTime currentDate = LocalDateTime.now();
		Timestamp currentDateTS = Timestamp.valueOf(currentDate);
		
		bookHistory.setReturnedDate(currentDateTS);
		
		return memberBookHistoryMapper.updateBookHistoryReturned(bookHistory);
	}
	
	// 2) 도서 연체 처리 : isOverdue
	@Override
	public int updateBookHistoryOverdue(BookHistory bookHistory) {
		
		bookHistory.setOverdue(true);
		
		return memberBookHistoryMapper.updateBookHistoryOverdue(bookHistory);
	}
	
	// 3) 도서 반납예정일 연장 : dueDate
	@Override
	public int updateBookHistoryDueDate(BookHistory bookHistory) {
		
		LocalDateTime dueDate = bookHistory.getDueDate().toLocalDateTime();
		LocalDateTime extendDueDate = dueDate.plusDays(7);
		Timestamp extendDueDateTS = Timestamp.valueOf(extendDueDate);
		
		bookHistory.setDueDate(extendDueDateTS);
		
		return memberBookHistoryMapper.updateBookHistoryOverdue(bookHistory);
	}
	
	// 회원별 도서 정보 이력 등록 - 시스템
	@Override
	public int insertBookHistory(int membersId, int booksId) {
		
		LocalDateTime currentDate = LocalDateTime.now();
		LocalDateTime dueDate = currentDate.plusDays(7);
		Timestamp dueDateTS = Timestamp.valueOf(dueDate);
		
		BookHistory bookHistory = BookHistory.builder()
				.booksId(booksId)
				.membersId(membersId)
				.loanDate(Timestamp.valueOf(currentDate)) // 대출 날짜: 오늘
				.dueDate(dueDateTS) // 반납 예정 날짜: 대출 날짜 + 7
				.returnedDate(null) // 반납 완료 날짜: 기본값
				.isOverdue(false) // 연체 여부: false
				.build();
		
		return memberBookHistoryMapper.insertBookHistory(bookHistory);
	}
	
	// 회원별 도서 정보 이력 삭제 - 시스템
//	@Override
//	public int deleteBookHistory(int bookHistoryId) {
//		return memberBookHistoryMapper.deleteBookHistory(bookHistoryId);
//	}
	

}
