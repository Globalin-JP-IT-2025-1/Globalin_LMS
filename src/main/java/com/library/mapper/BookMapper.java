package com.library.mapper;

import java.util.List;

import com.library.vo.Book;

public interface BookMapper {
	
	List<Book> findAllBooks(); // 도서 전체 조회
	
}