package com.library.service;

import java.util.List;

import com.library.model.Book;

public interface BookService {
	
	// 도서 목록 전체 조회 - 관리자
	public List<Book> getAllBooks();
	
	// 도서 상세 조회 - 상세조회, 수정 폼
	public Book getBookById(int booksId);
	
	// 도서 추가 - 관리자
	public int insertBook(Book book);
	
	// 도서 수정 : info - 관리자
	public int updateBookInfo(Book book);
	
	// 도서 수정 : disable - 관리자
	public int updateBookDisable(int booksId);

	// 도서 수정 : enable - 관리자
	public int updateBookEnable(int booksId);
	
	// 도서 수정 : enable - 관리자
	public int deleteBook(int booksId);

}