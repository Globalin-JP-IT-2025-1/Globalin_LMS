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
import com.library.model.book.BookHistory;
import com.library.model.book.BookHistoryRequest;
import com.library.model.book.BookHistoryResponse;
import com.library.model.book.BookHistoryWithBookInfo;
import com.library.model.status.BookHistoryStatus;
import com.library.service.MemberBookHistoryService;

import lombok.AllArgsConstructor;

@Service("memberBookHistoryService")
@AllArgsConstructor
public class MemberBookHistoryServiceImpl implements MemberBookHistoryService {
	private final MemberBookHistoryMapper memberBookHistoryMapper;
	
	private static final int BOOK_HISTORY_PER_PAGE = 7; // 한 페이지당 게시글 수
	
	// 회원별 도서 이용 정보 목록 전체 조회
	@Override
	public BookHistoryResponse getBookHistoryList(int membersId, int currentPage) {
		
		int totalCount = getBookHistoryListCount(membersId); // 전체 개수
		int totalPages = (int)Math.ceil((double)totalCount / BOOK_HISTORY_PER_PAGE);
    	int startRow = (currentPage - 1) * BOOK_HISTORY_PER_PAGE;
    	int endRow = currentPage * BOOK_HISTORY_PER_PAGE;
    	
    	BookHistoryRequest bookHistoryListRequest = BookHistoryRequest.builder()
    			.searchRequest(null)
    			.membersId(membersId)
    			.startRow(startRow)
				.endRow(endRow)
    			.build();
    	
    	List<BookHistoryWithBookInfo> bookHistoryList = memberBookHistoryMapper.getBookHistoryList(bookHistoryListRequest);
    	
        return BookHistoryResponse.builder()
        		.bookHistoryList(bookHistoryList)
        		.totalCount(totalCount)
        		.totalPages(totalPages)
        		.build();
	}
	
	// 개수
	@Override
	public int getBookHistoryListCount(int membersId) {
		return memberBookHistoryMapper.getBookHistoryListCount(membersId);
	}
	
	// 회원별 도서별 미납 도서 1건 이용 이력 조회
	@Override
	public BookHistory getBookHistoryNonReturn(int membersId, int booksId) {
		
		BookHistoryRequest bookHistoryRequest = BookHistoryRequest.builder()
				.booksId(booksId)
				.membersId(membersId)
				.build();
		
		return memberBookHistoryMapper.getBookHistoryNonReturn(bookHistoryRequest);
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

	    int totalOverdueDay = 0;
	    LocalDate today = LocalDate.now();

	    for (BookHistory bh : bookHistory) {
	    	// 마감일(DUE_DATE)을 LocalDate로 변환
	        LocalDate dueDate = bh.getDueDate().toLocalDateTime().toLocalDate();
	        // 마감일과 오늘 사이의 일수 차이를 계산 (음수 방지)
	        int overdueDay = Math.max(0, (int) ChronoUnit.DAYS.between(dueDate, today));
	        // 누적 연체일수에 더함
	        totalOverdueDay += overdueDay;
	    }

	    Map<String, Integer> result = new HashMap<>();
	    result.put("day", totalOverdueDay);
	    result.put("count", bookHistory.size());

	    return result;
	}

	
	// 회원별 도서 이용 정보 수정
	// 1) 도서 반납 처리 : returnedDate
	@Override
	public int updateBookHistoryReturned(int membersId, int booksId) {
		
		// 회원별 도서별 이용내역 찾기 (해당 회원의 아직 미납 상태인 해당 도서)
		BookHistory bookHistory = getBookHistoryNonReturn(membersId, booksId);
		
		// 오늘 날짜 설정
		LocalDateTime currentDate = LocalDateTime.now();
		Timestamp currentDateTS = Timestamp.valueOf(currentDate);
		
		bookHistory.setReturnedDate(currentDateTS);
		
		return memberBookHistoryMapper.updateBookHistoryReturned(bookHistory);
	}
	
	// 2) 도서 연체 처리 : status
	@Override
	public int updateBookHistoryOverdue(int membersId, int booksId) {
		
		BookHistory bookHistory = BookHistory.builder()
        		.booksId(booksId)
        		.membersId(membersId)
        		.status(BookHistoryStatus.OVERDUE.getCode()) // 1-연체
        		.build();
		
		return memberBookHistoryMapper.updateBookHistoryOverdue(bookHistory);
	}
	
	// 3) 도서 반납예정일 연장 : dueDate
	@Override
	public int updateBookHistoryDueDate(int membersId, int booksId) {
		
		// 회원별 도서별 이용내역 찾기 (해당 회원의 아직 미납 상태인 해당 도서)
		BookHistory bookHistory = getBookHistoryNonReturn(membersId, booksId);
		
		// 7일 연장
		LocalDateTime dueDate = bookHistory.getDueDate().toLocalDateTime();
		LocalDateTime extendDueDate = dueDate.plusDays(7);
		Timestamp extendDueDateTS = Timestamp.valueOf(extendDueDate);
		
		bookHistory.setDueDate(extendDueDateTS);
		
		return memberBookHistoryMapper.updateBookHistoryDueDate(bookHistory);
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
				.status(0) // 0-정상
				.build();
		
		return memberBookHistoryMapper.insertBookHistory(bookHistory);
	}
	
	// 회원별 도서 정보 이력 삭제 - 시스템
//	@Override
//	public int deleteBookHistory(int bookHistoryId) {
//		return memberBookHistoryMapper.deleteBookHistory(bookHistoryId);
//	}
	

}
