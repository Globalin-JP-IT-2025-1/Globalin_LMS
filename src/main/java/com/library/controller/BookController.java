package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Book;
import com.library.service.BookService;

@Controller
@RequestMapping("/books")
public class BookController {

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public String getAllBooks(Model model) {
    	List<Book> bookList = bookService.findAllBooks();
        
    	model.addAttribute("bookList", bookList);
    	model.addAttribute("pageTitle", "도서 목록 조회");
    	model.addAttribute("pagePath", "page/bookList.jsp");
    	
        return "layout";
    }

}