package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.vo.Book;

@Mapper
public interface BookMapper {
	
	List<Book> findAllBooks(); // 도서 전체 조회
	
}