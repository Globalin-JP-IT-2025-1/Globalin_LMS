package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.PageInfo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/")
@AllArgsConstructor
public class HomeController {
	private PageInfo pageInfo;
    
	public void setPageInfo(Model model) {
		model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}
	
	@RequestMapping
    public String showHome(@RequestParam(value="logout", required = false) boolean logout, 
    		@RequestParam(value="login", required = false) boolean login,
    		Model model) {
    	System.out.println("✅ HomeController - / - GET 요청 정상 처리!");
    	
    	if (logout) {
    		model.addAttribute("alertType", "success");
    		model.addAttribute("alertMessage", "로그아웃 성공하였습니다");
    	}
    	
    	if (login) {
    		model.addAttribute("alertType", "success");
    		model.addAttribute("alertMessage", "로그인 성공하였습니다");
    	}
    	
    	setPageInfo(model);
        
        return "layout";
    }
    
}