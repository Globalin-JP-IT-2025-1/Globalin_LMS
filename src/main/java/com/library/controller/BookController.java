package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.dto.Book;
import com.library.dto.PageInfo;
import com.library.service.BookService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/books")
@AllArgsConstructor
public class BookController {
    private final BookService bookService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    @GetMapping
    public String getAllBooks(Model model) {
    	List<Book> bookList = bookService.getAllBooks();
        
    	model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("11")
    			.pagePath("page/bookList.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }

}