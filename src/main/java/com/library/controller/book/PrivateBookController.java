package com.library.controller.book;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;
import com.library.model.status.MemberStatus;
import com.library.security.CustomUserDetails;
import com.library.service.BookService;
import com.library.service.MemberBookLikeService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/public/books")
@AllArgsConstructor
public class PrivateBookController {
	private final BookService bookService; // 도서 처리
    private final MemberBookLikeService memberBookLikeService;       // 회원별 희망 도서 처리
    private PageInfo pageInfo;

    public void setPageInfo(Model model) {
        model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
        model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    // 도서 대출 예약, 취소
    @PutMapping("/{category}/{booksId}/loan")
    @Transactional
    public String loanReserveBook(@PathVariable("category") int category, 
								  @PathVariable("booksId") int booksId,
								  @RequestParam(required = false) boolean isTrue,
								  RedirectAttributes redirectAttributes,
								  Authentication authentication) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    		redirectAttributes.addFlashAttribute("alertType", "fail");
			redirectAttributes.addFlashAttribute("alertMesssage", "대출 예약은 로그인 후 가능합니다.");
			
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증 객체에서 회원 id 추출
    	CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
    	
    	// 대출 정지 회원 or 준회원 : 대출 불가
    	int status = userDetails.getStatus();
    	if (status == MemberStatus.LOAN_HOLD.getCode()) {
    		redirectAttributes.addFlashAttribute("alertType", "fail");
			redirectAttributes.addFlashAttribute("alertMesssage", "대출 정지 회원은 대출 예약이 불가능 합니다.");
			
    	    return "redirect:/public/books/" + category + "/" + booksId;
    	} else if (status == MemberStatus.JUNIOR.getCode()) {
    		redirectAttributes.addFlashAttribute("alertType", "fail");
			redirectAttributes.addFlashAttribute("alertMesssage", "준회원은 대출 예약이 불가능 합니다.");
			
    	    return "redirect:/public/books/" + category + "/" + booksId;
    	}
    	
    	// 대출 예약, 취소 처리
    	try {
    		if (isTrue) {
    			bookService.updateBookLoanReserved(booksId);
    		} else {
    			bookService.updateBookLoanable(booksId);
    		}
    	} catch (Exception e) {
    		if (isTrue) {
    			log.error("대출 예약 실패 : " + e);
	    		redirectAttributes.addFlashAttribute("alertType", "fail");
	    		redirectAttributes.addFlashAttribute("alertMesssage", "대출 예약을 실패 하였습니다.");
    		} else {
    			log.error("대출 예약 취소 실패 : " + e);
    			redirectAttributes.addFlashAttribute("alertType", "fail");
    			redirectAttributes.addFlashAttribute("alertMesssage", "대출 예약 취소를 실패 하였습니다.");
    		}
    		
    		return "redirect:/public/books/" + category + "/" + booksId;
    	}
    	if (isTrue) {
	    	redirectAttributes.addFlashAttribute("alertType", "success");
			redirectAttributes.addFlashAttribute("alertMesssage", "대출 예약이 완료 되었습니다.");
    	} else {
    		redirectAttributes.addFlashAttribute("alertType", "success");
    		redirectAttributes.addFlashAttribute("alertMesssage", "대출 예약 취소가 완료 되었습니다.");
    	}
    	
    	return "redirect:/public/books/" + category + "/" + booksId;
    }

    // 도서 찜 등록, 취소
    @PutMapping("/{category}/{booksId}/like")
    @Transactional
    public String likeBook(@PathVariable("category") int category, 
								  @PathVariable("booksId") int booksId,
								  @RequestParam(required = false) boolean isTrue,
								  RedirectAttributes redirectAttributes,
								  Authentication authentication) {
    	
    	// 인증되지 않은 경우 (비로그인 상태) : 로그인 페이지로
    	authentication = SecurityContextHolder.getContext().getAuthentication();
    	if (authentication == null || !authentication.isAuthenticated()) {
    		redirectAttributes.addFlashAttribute("alertType", "fail");
			redirectAttributes.addFlashAttribute("alertMesssage", "찜 등록은 로그인 후 가능합니다.");
			
    	    return "redirect:/public/auth/login?status=0";
    	}
    	
    	// 인증 객체에서 회원 id 추출
    	CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
    	int membersId = userDetails.getMembersId();
    	
    	// 찜 등록, 취소 처리
    	// 1) 찜 등록 시, 도서 Like Count 증가 처리 (bookService --> books 테이블)
    	// 2) 회원별 도서 찜 목록에 추가, 삭제 (memberBookLikeService --> BookLike 테이블)
    	try {
    		if (isTrue) {
    			bookService.updateBookLikeCountUp(booksId);
    			memberBookLikeService.insertBookLike(membersId, booksId);
    		} else {
    			memberBookLikeService.deleteBookLike(membersId, booksId);
    		}
    		
    	} catch (Exception e) {
    		if (isTrue) {
    			log.error("찜 등록 실패 : " + e);
	    		redirectAttributes.addFlashAttribute("alertType", "fail");
	    		redirectAttributes.addFlashAttribute("alertMesssage", "찜 등록을 실패 하였습니다.");
    		} else {
    			log.error("찜 취소 실패 : " + e);
    			redirectAttributes.addFlashAttribute("alertType", "fail");
    			redirectAttributes.addFlashAttribute("alertMesssage", "찜 등록 취소를 실패 하였습니다.");
    		}
    		
    		return "redirect:/public/books/" + category + "/" + booksId;
    	}
    	if (isTrue) {
	    	redirectAttributes.addFlashAttribute("alertType", "success");
			redirectAttributes.addFlashAttribute("alertMesssage", "찜 등록이 완료 되었습니다.");
    	} else {
    		redirectAttributes.addFlashAttribute("alertType", "success");
    		redirectAttributes.addFlashAttribute("alertMesssage", "찜 등록 취소가 완료 되었습니다.");
    	}
    	
    	return "redirect:/public/books/" + category + "/" + booksId;
    }
    
}
