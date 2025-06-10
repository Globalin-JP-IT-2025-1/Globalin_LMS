package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Book;
import com.library.model.PageInfo;
import com.library.service.BookService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/books")
@AllArgsConstructor
public class AdminBookController {
    private final BookService bookService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 도서 관리 목록 조회
    @GetMapping
    public String getAllBooksTotal(Model model) {
		/*
		 * List<Book> bookList = bookService.getAllBooks();
		 * 
		 * model.addAttribute("bookList", bookList);
		 */
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("92")
    			.pagePath("page/bookList_admin.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 도서 추가 폼
    @GetMapping("/add")
    public String showAddBook(Model model) {
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("95")
    			.pagePath("page/addForm_book.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 도서 수정 폼
    @GetMapping("/edit")
    public String showEditBook(Model model) {
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("96")
    			.pagePath("page/editForm_book.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
	/*
	 * // 도서 추가 요청
	 * 
	 * @PostMapping public ResponseEntity<Void> addBook() {
	 * 
	 * 
	 * return ResponseEntity.ok().build(); // 200 }
	 * 
	 * // 도서 수정 요청
	 * 
	 * @PutMapping("/{booksId}") public ResponseEntity<Void> editBook() {
	 * 
	 * 
	 * return ResponseEntity.ok().build(); // 200 }
	 * 
	 * // 도서 삭제 요청
	 * 
	 * @PutMapping("/{booksId}") public ResponseEntity<Void> deleteBook() {
	 * 
	 * 
	 * return ResponseEntity.ok().build(); // 200 }
	 */
    
    
    
    
    
}