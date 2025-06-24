package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Book;

@Mapper
public interface BookMapper {
	
	// 도서 전체 조회
	public List<Book> getAllBooks();
	
	// 도서 상세 조회 - 상세조회, 수정 폼
	public Book getBookById(int booksId);
	
	// 도서 추가
	public int insertBook(Book book);
	
	// 도서 정보 수정 : 정보
	public int updateBookInfo(Book book);
	
	// 도서 정보 수정 : 비활성화
	public int updateBookDisable(int booksId);
	
	// 도서 정보 수정 : 활성화
	public int updateBookEnable(int booksId);

	// 도서 삭제
	public int deleteBook(int booksId);

}