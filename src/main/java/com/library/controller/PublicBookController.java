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
@RequestMapping("/public/books")
@AllArgsConstructor
public class PublicBookController {
    private final BookService bookService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    @GetMapping("/total")
    public String getAllBooksTotal(Model model) {
    	List<Book> bookList = bookService.getAllBooks();
        
    	model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("11")
    			.pagePath("page/bookList_total.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    @GetMapping("/class")
    public String getAllBooksClass(Model model) {
    	List<Book> bookList = bookService.getAllBooks();
        
    	model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("12")
    			.pagePath("page/bookList_class.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    @GetMapping("/loan")
    public String getAllBooksLoan(Model model) {
    	List<Book> bookList = bookService.getAllBooks();
        
    	model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("13")
    			.pagePath("page/bookList_loan.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    
    @GetMapping("/like")
    public String getAllBooksLike(Model model) {
    	List<Book> bookList = bookService.getAllBooks();
        
    	model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("14")
    			.pagePath("page/bookList_like.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
}