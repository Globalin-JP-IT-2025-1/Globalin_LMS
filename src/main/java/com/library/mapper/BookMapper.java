package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Book;

@Mapper
public interface BookMapper {
	
	List<Book> getAllBooks(); // 도서 전체 조회
	
}