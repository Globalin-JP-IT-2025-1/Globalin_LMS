package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.SearchRequest;
import com.library.model.book.Book;
import com.library.model.book.BookListRequest;

@Mapper
public interface BookMapper {
    
	// 목록 조회
	List<Book> getBookList(BookListRequest bookListRequest); // 1) 전체 목록 조회
	List<Book> getBookListByCategory(BookListRequest bookListRequest); // 2) 주제별 목록 조회
	List<Book> getBookListByLoanCount(BookListRequest bookListRequest); // 대출 횟수 순 TOP 100
	List<Book> getBookListByLikeCount(BookListRequest bookListRequest); // 찜(좋아요) 순 TOP 100
	List<Book> getBookListByKeyword(BookListRequest bookListRequest); // 검색에 따른 목록 조회
	
	// 목록 개수 (페이징)
	int getBookListCount(); // 전체 목록 개수
	int getBookListCountByCategory(String category); // 주제별 목록 개수
	int getBookListCountByKeyword(SearchRequest searchRequest); // 검색에 따른 목록 개수
    
    // 상세 조회
	Book getBookById(int booksId); // 상세 조회 (booksId 기반)
	Book getBookByISBN(String isbn); // 상세 조회 (ISBN 기반)
    
    // 수정
	int updateBookInfo(Book book); // 1) 도서 정보 수정
	int updateBookDisable(int booksId); // 2) 도서 상태 - 비공개로 변경 (soft del)
	int updateBookLoaned(int booksId); // 3) 도서 상태 '대여중'으로 변경
	int updateBookLoanable(int booksId); // 4) 도서 상태 '대여가능'으로 변경
	int updateBookLoanReserved(int booksId); // 5) 도서 상태 - '대출 예약 중'으로 변경 
    
	int updateBookViewCountUp(int booksId); // 6) 책 조회수 증가
	int updateBookReviewCountUp(int booksId); // 7) 책 리뷰 개수 증가
	int updateBookReviewCountDown(int booksId); // 8) 책 리뷰 개수 감소
	int updateBookLoanCountUp(int booksId);  // 9) 대출 누적수 증가
	int updateBookLikeCountUp(int booksId);  // 10) 찜 누적수 증가
	
	// 추가
	int insertBook(Book book);
	
	// 삭제
	int deleteBook(int booksId); // hard del

}
