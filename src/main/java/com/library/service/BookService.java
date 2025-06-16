package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.BookMapper;
import com.library.model.Book;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookService {
	private final BookMapper bookMapper;
	
	// 도서 목록 전체 조회 - 관리자
	public List<Book> getAllBooks() {
		return bookMapper.getAllBooks();
	}
	
	// 도서 상세 조회 - 상세조회, 수정 폼
	public Book getBookById(int booksId) {
		return bookMapper.getBookById(booksId);
	}
	
	// 도서 추가 - 관리자
	public int insertBook(Book book) {
		return bookMapper.insertBook(book);
	}
	
	// 도서 수정 : info - 관리자
	public int updateBookInfo(Book book) {
		return bookMapper.updateBookInfo(book);
	}
	
	// 도서 수정 : disable - 관리자
	public int updateBookDisable(int booksId) {
		return bookMapper.updateBookDisable(booksId);
	}

	// 도서 수정 : enable - 관리자
	public int updateBookEnable(int booksId) {
		return bookMapper.updateBookEnable(booksId);
	}
	
	// 도서 수정 : enable - 관리자
	public int deleteBook(int booksId) {
		return bookMapper.deleteBook(booksId);
	}

}