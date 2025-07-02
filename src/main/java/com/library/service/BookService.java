package com.library.service;

import java.util.List;

import com.library.model.SearchRequest;
import com.library.model.book.Book;
import com.library.model.book.BookListResponse;

public interface BookService {

	// 목록 조회
	public BookListResponse getBookList(int currentPage); // 1) 목록 조회
	public BookListResponse getBookListByCategory(String category, int currentPage); // 2) 주제별 목록 조회
	public BookListResponse getBookListByLoanCount(int currentPage); // 대출 횟수 순 TOP 100
	public BookListResponse getBookListByLikeCount(int currentPage); // 찜(좋아요) 순 TOP 100
	public BookListResponse getBookListByKeywordByDB(String type, String keyword, int page); // DB 통합검색
	public BookListResponse getBookListByKeywordByExtAPI(String type, String keyword, int page); // 외부 API 통합검색
	public List<Book> getRecBookListForHome(); // 추천 도서 3건
	public List<Book> getPopBookListForHome(); // 인기 도서 3건
	public List<Book> getNewBookListForHome(); // 신착 도서 3건
	
	// 목록 개수 (페이징용)
	public int getBookListCount(); // 전체 목록 개수
	public int getBookListCountByCategory(String category); // 주제별 목록 개수
	public int getBookListCountByKeyword(SearchRequest searchRequest); // 검색에 따른 목록 개수
	
    // 상세 조회
	public Book getBookById(int booksId); // 상세 조회
    
	// 수정
	public int updateBookInfo(Book book); // 1) 도서 정보 수정
	public int updateBookDisable(int booksId); // 2) 도서 상태 - '비공개'로 변경 (soft del)
	public int updateBookLoanable(int booksId); // 3) 도서 상태 - '정상 (대출 가능)'으로 변경
	public int updateBookLoaned(int booksId); // 4) 도서 상태 - '대출 중'으로 변경
	public int updateBookLoanReserved(int booksId); // 5) 도서 상태 - '대출 예약 중'으로 변경 
    
	public int updateBookViewCountUp(int booksId); // 6) 책 조회수 증가
	public int updateBookLoanCountUp(int booksId);  // 9) 대출 누적수 증가
	public int updateBookLikeCountUp(int booksId);  // 10) 찜 누적수 증가
	
	// 추가
	public int insertBook(Book book);
	
	// 삭제
	public int deleteBook(int booksId); // hard del
	
	// 기타 처리
	public void loanBook(int booksId, String cardNum); // 대출 처리
	public void returnBook(int booksId, String cardNum); // 반납 처리
    
}
