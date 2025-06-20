package com.library.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@AllArgsConstructor
public class AuthController {
	private PageInfo pageInfo;
	
	public void setPageInfo(Model model) {
		model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}
	
	// 로그인 폼 --> ok!!
    @GetMapping("/public/auth/login")
    public String showLoginForm(@RequestParam(value="status", defaultValue = "1") Integer status, 
    		HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("61")
				.pagePath("page/0-auth/loginForm.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	
    	if (status == 0) {
    		model.addAttribute("alertType", "info");
    		model.addAttribute("alertMessage", "로그인 하시기 바랍니다.");
    	}
    	
        return "layout";
    }
    
    // 로그인 실패 처리
    @GetMapping("/public/auth/login/fail")
    public String loginFailProc(HttpSession session, 
    							RedirectAttributes redirectAttributes) {
    	
    	String errorMsg = (String) session.getAttribute("LOGIN_ERROR_MSG");
    	
    	redirectAttributes.addFlashAttribute("alertType", "error");

        if (errorMsg != null) {
        	redirectAttributes.addFlashAttribute("alertMessage", errorMsg);
        	session.removeAttribute("LOGIN_ERROR_MSG");
        } else {
        	redirectAttributes.addFlashAttribute("alertMessage", "로그인 실패");
        }
        
    	return "redirect:/public/auth/login";
    }
	
    // 로그인 처리 --> Spring Security로 이전
//    @PostMapping("/public/auth/login")
//    public String loginProc() {}
    
    // 로그아웃 처리 --> Spring Security로 이전
//    @PostMapping("/private/auth/logout") 
//    public String logoutProc() {}
   
    
}
