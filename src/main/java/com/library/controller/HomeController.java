package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public String showHome(Model model) {
    	System.out.println("✅ HomeController - / - GET 요청 정상 처리!");
    	
    	setPageInfo(model);
        
        return "layout";
    }
    
}