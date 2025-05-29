package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.BookMapper;
import com.library.model.Book;

@Service
public class BookService {
	private final BookMapper bookMapper;
	
	public BookService(BookMapper bookMapper) {
		this.bookMapper = bookMapper;
	}
	
	public List<Book> findAllBooks() {
		return bookMapper.findAllBooks();
	}

}
