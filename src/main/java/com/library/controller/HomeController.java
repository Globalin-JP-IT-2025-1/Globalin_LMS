package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.dto.PageInfo;

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
	
    @GetMapping
    public String showHome(@RequestParam(name = "membersId", required = false) String membersId, Model model) {
    	System.out.println("✅ HomeController - / - GET 요청 정상 처리!");
    	
    	if (membersId != null) {
    		model.addAttribute("membersId", membersId);
    	}
    	
    	setPageInfo(model);
        
        return "layout";
    }
    
}