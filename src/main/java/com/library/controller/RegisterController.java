package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.dto.PageInfo;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/register")
@AllArgsConstructor
public class RegisterController {
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitle", pageInfo.getPageTitle());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 회원가입 폼
    @GetMapping
    public String showRegForm(Model model) {
    	pageInfo = PageInfo.builder()
			.pageTitle(new String[] { "회원 정보", "회원가입" })
			.pagePath("page/regForm.jsp")
			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }

}
