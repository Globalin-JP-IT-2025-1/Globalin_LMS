package com.library.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.Book;
import com.library.model.PageInfo;
import com.library.service.BookService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
    public String getAllBooksTotal(HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
	
//		List<Book> bookList = bookService.getAllBooks();
//		model.addAttribute("bookList", bookList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("93")
    			.pagePath("page/9-admin/bookList_admin.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 도서 추가 폼
    @GetMapping("/add")
    public String showAddBook(HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("92")
    			.pagePath("page/2-book/addForm_book.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 도서 추가 요청
    @PostMapping
    public String addBookProc(@ModelAttribute Book book, HttpServletRequest request, 
    		RedirectAttributes redirectAttributes, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	int result = bookService.insertBook(book);
    	
    	if (result < 0) {
    		redirectAttributes.addAttribute("alertType", "fail");
    		redirectAttributes.addAttribute("alertMessage", "도서 추가 실패하였습니다");
    		
    		return "redirect:/admin/books";
    	}
    	
		redirectAttributes.addAttribute("alertType", "success");
		redirectAttributes.addAttribute("alertMessage", "도서 추가 성공하였습니다");
    	
    	return "redirect:/admin/books";
    	
    }
    
    
    // 도서 수정 폼
    @GetMapping("/{booksId}/edit")
    public String showEditBook(@PathVariable("booksId") int booksId, HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
//    	Book book = bookService.getBookById(booksId);
//    	model.addAttribute("book", book);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("92")
    			.pagePath("page/2-book/editForm_book.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // 도서 정보 수정 요청 : 정보
    @PutMapping("/{booksId}")
    public String editBookInfoProc(@PathVariable("booksId") int booksId, @ModelAttribute Book book, 
    		HttpServletRequest request, RedirectAttributes redirectAttributes) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	try {
    		//bookService.updateBookInfo(book);
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addAttribute("alertMessage", "도서 수정 실패하였습니다");
    		redirectAttributes.addAttribute("alertType", "fail");
    		
    		return "redirect:/admin/books";
    	}
    	
		redirectAttributes.addAttribute("alertType", "success");
		redirectAttributes.addAttribute("alertMessage", "도서 수정 성공하였습니다");
    	
    	return "redirect:/admin/books";
    	
    }
    
    // 도서 정보 수정 요청 - 비활성화
    @PutMapping("/{booksId}/{type}")
    public String editBookDisableProc(@PathVariable("booksId") int booksId,
    		@PathVariable("type") String type, 
    		HttpServletRequest request, RedirectAttributes redirectAttributes) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	try {
    		if (type.equals("disable")) {
    			//bookService.updateBookDisable(booksId); // 도서 비활성화
    		} else if (type.equals("enable")) {
    			//bookService.updateBookEnable(booksId); // 도서 활성화
    		}
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addAttribute("alertType", "fail");
    		if (type.equals("disable")) {
    			redirectAttributes.addAttribute("alertMessage", "도서 비활성화 실패 하였습니다");
    		} else if (type.equals("enable")) {
    			redirectAttributes.addAttribute("alertMessage", "도서 활성화 실패 하였습니다");
    		}
    		
    		return "redirect:/admin/books"; // 실패: 목록으로 이동
    	}
    	
    	redirectAttributes.addAttribute("alertType", "success");
    	if (type.equals("disable")) {
			redirectAttributes.addAttribute("alertMessage", "도서 비활성화 성공 하였습니다");
		} else if (type.equals("enable")) {
			redirectAttributes.addAttribute("alertType", "fail");
			redirectAttributes.addAttribute("alertMessage", "도서 활성화 성공 하였습니다");
		}
    	
    	return "redirect:/admin/books"; // 실패: 목록으로 이동
    	
    }

    // 도서 정보 삭제 요청
    @DeleteMapping("/{booksId}")
    public String deleteBookProc(@PathVariable("booksId") int booksId, 
    		HttpServletRequest request, RedirectAttributes redirectAttributes) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	try {
    		//bookService.deleteBook(booksId);
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addAttribute("alertType", "fail");
    		redirectAttributes.addAttribute("alertMessage", "도서 삭제 실패하였습니다");
    		
    		return "redirect:/admin/books";
    	}

		redirectAttributes.addAttribute("alertType", "success");
		redirectAttributes.addAttribute("alertMessage", "도서 삭제 성공하였습니다");
    	
    	return "redirect:/admin/books";
    	
    }

    
	
    
}