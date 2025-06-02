package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.dto.PageInfo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/login")
@AllArgsConstructor
public class LoginController {
	private PageInfo pageInfo;
    
	public void setPageInfo(Model model) {
		model.addAttribute("pageTitle", pageInfo.getPageTitle());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}
	
    @GetMapping
    public String showLoginForm(Model model) {
    	System.out.println("✅ LoginController - /login - GET 요청 정상 처리!");
    	
    	pageInfo = PageInfo.builder()
    			.pageTitle("로그인")
    			.pagePath("page/loginForm.jsp")
    			.build();
    	
    	setPageInfo(model);
        
        return "layout";
    }
    
}