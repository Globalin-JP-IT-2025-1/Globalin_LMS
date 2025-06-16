package com.library.controller.book;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Book;
import com.library.model.PageInfo;
import com.library.service.BookService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
    public String getAllBooksTotal(HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	//List<Book> bookList = bookService.getAllBooks();
    	//model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("11")
    			.pagePath("page/2-book/bookList_total.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    @GetMapping("/class")
    public String getAllBooksClass(HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	//List<Book> bookList = bookService.getAllBooks();
    	//model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("12")
    			.pagePath("page/2-book/bookList_class.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    @GetMapping("/loan")
    public String getAllBooksLoan(HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	//List<Book> bookList = bookService.getAllBooks();
    	//model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("13")
    			.pagePath("page/2-book/bookList_loan.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    
    @GetMapping("/like")
    public String getAllBooksLike(HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	//List<Book> bookList = bookService.getAllBooks();
    	//model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("14")
    			.pagePath("page/2-book/bookList_like.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
}