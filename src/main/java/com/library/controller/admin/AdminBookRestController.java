package com.library.controller.admin;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.exception.LoanNotAllowedException;
import com.library.model.member.CardNumberRequest;
import com.library.service.BookService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/books")
@AllArgsConstructor
public class AdminBookRestController {
	private final BookService bookService;

	// 도서 대출 처리
	@PostMapping("/{booksId}/loan")
	public String loanBook(@PathVariable("booksId") int booksId, 
									  @RequestBody CardNumberRequest request) {
		try {
			bookService.loanBook(booksId, request.getCardNum());

			return "redirect:/admin/books";
		} catch (LoanNotAllowedException e) {
			log.warn("도서 대출 실패: {}", e.getMessage());
			return "redirect:/";
		} catch (Exception e) {
			log.error("도서 대출 처리 중 오류 발생", e);
			return "redirect:/";

		}
	}

	// 도서 반납 처리
	@PostMapping("/{booksId}/return")
	public ResponseEntity<String> returnBook(@PathVariable("booksId") int booksId, 
									  	@RequestBody CardNumberRequest request) {
		try {
			bookService.returnBook(booksId, request.getCardNum());

			return ResponseEntity.ok().body("도서 반납 처리 성공");
		} catch (Exception e) {
			log.error("도서 반납 처리 중 오류 발생", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("서버 오류로 대출 실패");
		}
	}

}