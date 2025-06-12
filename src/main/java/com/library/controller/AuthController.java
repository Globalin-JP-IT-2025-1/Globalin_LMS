package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.PageInfo;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@CrossOrigin(origins = "*") // 모든 요청에서 허용 
public class AuthController {
	private PageInfo pageInfo;
	
	public void setPageInfo(Model model) {
		model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}
	
	// 로그인 폼 --> ok!!
    @GetMapping("/public/auth/login")
    public String showLoginForm(@RequestParam(value="status", defaultValue = "0") Integer status, Model model) {
    	System.out.println("✅ AuthController - /public/auth/login - GET 요청 정상 처리!");
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("61")
    			.pagePath("page/loginForm.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	if (status == -1) {
    		model.addAttribute("alertType", "error");
    		model.addAttribute("alertMessage", "로그인 실패하였습니다. <br> 다시 시도해주세요.");
    	} else if (status == 0) {
    		model.addAttribute("alertType", "info");
    		model.addAttribute("alertMessage", "로그인 하시기 바랍니다.");
    	}
    	
        return "layout";
    }
	
    // 로그인 처리 --> Spring Security로 이전
//    @PostMapping("/public/auth/login")
//    public String loginProc(HttpServletRequest request, HttpServletResponse response) {
//    	
//    }
    
    // 로그아웃 처리 --> Spring Security로 이전
//    @PostMapping("/private/auth/logout/{membersId}") 
//    public String logoutProc(HttpServletRequest request, HttpServletResponse response) {
//    	
//    }
   
    
}
