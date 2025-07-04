package com.library.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.exception.LoanNotAllowedException;
import com.library.service.BookService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/books")
@AllArgsConstructor
public class AdminBookController2 {
	private final BookService bookService;

	// 도서 대출 처리
	@PostMapping("/{booksId}/loan")
	public String loanBook(@PathVariable int booksId,
	                       @RequestParam("cardNo") String cardNo,
	                       RedirectAttributes redirectAttributes) {
	    try {
	        bookService.loanBook(booksId, cardNo);
	        
	        redirectAttributes.addFlashAttribute("alertType", "success");
			redirectAttributes.addFlashAttribute("alertMessage", "도서 대출을 완료 하였습니다.");
	        
	    } catch (LoanNotAllowedException e) {
	    	redirectAttributes.addFlashAttribute("alertType", "error");
	        redirectAttributes.addFlashAttribute("alertMessage", "대출 실패: " + e.getMessage());
	        
	        return "redirect:/admin/books"; // 실패
	        
	    } catch (Exception e) {
	    	redirectAttributes.addFlashAttribute("alertType", "error");
	        redirectAttributes.addFlashAttribute("alertMessage", "서버 오류로 대출 실패");
	        
	        return "redirect:/admin/books"; // 실패
	    }
	    return "redirect:/admin/books"; // 대출 후 이동할 페이지
	}


	// 도서 반납 처리
	@PostMapping("/{booksId}/return")
	public String returnBook(@PathVariable int booksId,
			                 @RequestParam("cardNo") String cardNo,
			                 RedirectAttributes redirectAttributes) {
		try {
			bookService.returnBook(booksId, cardNo);
			
			redirectAttributes.addFlashAttribute("alertType", "success");
			redirectAttributes.addFlashAttribute("alertMessage", "도서 반납을 완료 하였습니다.");
			
		} catch (LoanNotAllowedException e) {
			redirectAttributes.addFlashAttribute("alertType", "error");
			redirectAttributes.addFlashAttribute("alertMessage", "반납 실패: " + e.getMessage());
			
			return "redirect:/admin/books"; // 실패
			
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("alertType", "error");
			redirectAttributes.addFlashAttribute("alertMessage", "서버 오류로 반납 실패");
			
			return "redirect:/admin/books"; // 실패
		}
		return "redirect:/admin/books"; // 반납 후 이동할 페이지
	}

}