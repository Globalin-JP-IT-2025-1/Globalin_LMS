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
	
	public List<Book> getAllBooks() {
		return bookMapper.getAllBooks();
	}

}