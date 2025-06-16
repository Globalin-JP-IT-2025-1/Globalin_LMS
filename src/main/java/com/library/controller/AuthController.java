package com.library.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String showLoginForm(@RequestParam(value="status", defaultValue = "1") Integer status, HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("61")
    			.pagePath("page/loginForm.jsp")
				/* .pagePath("page/0-auth/loginForm.jsp") */
    			.build();
    	
    	setPageInfo(model);
    	
    	if (status == -1) {
    		model.addAttribute("alertType", "error");
    		model.addAttribute("alertMessage", "로그인 실패 하였습니다. 다시 시도해주세요.");
    	} else if (status == 0) {
    		model.addAttribute("alertType", "info");
    		model.addAttribute("alertMessage", "로그인 하시기 바랍니다.");
    	} else if (status == 2) {
    		model.addAttribute("alertType", "success");
    		model.addAttribute("alertMessage", "회원가입 성공 하였습니다!");
    	}
    	
        return "layout";
    }
	
    // 로그인 처리 --> Spring Security로 이전
//    @PostMapping("/public/auth/login")
//    public String loginProc() {}
    
    // 로그아웃 처리 --> Spring Security로 이전
//    @PostMapping("/private/auth/logout") 
//    public String logoutProc() {}
   
    
}
