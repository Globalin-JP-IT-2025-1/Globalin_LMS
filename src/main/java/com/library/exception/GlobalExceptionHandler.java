package com.library.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(LoanNotAllowedException.class)
    public String handleLoanNotAllowedException(RedirectAttributes redirectAttributes) {
    	
    	log.info("handleLoanNotAllowedException 진입!! - GlobalExceptionHandler");
    	
    	redirectAttributes.addFlashAttribute("alertType", "fail");
        redirectAttributes.addFlashAttribute("alertMessage", "대출이 불가능 합니다.");
        
        return "redirect:/";
    }
    
}
