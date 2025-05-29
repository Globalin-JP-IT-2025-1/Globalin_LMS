package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping({"/", "/main"})
public class MainController {
    
    @GetMapping
    public String showMain(@RequestParam(name = "membersId", required = false) String membersId, Model model) {
    	System.out.println("✅ MainController - /, /main - GET 요청 정상 처리!");
    	
    	if (membersId != null) {
    		model.addAttribute("membersId", membersId);
    	}
//        model.addAttribute("message", "글로벌인 도서관에 오신 걸 환영합니다!");
        model.addAttribute("pageTitle", "main");
        model.addAttribute("pagePath", "page/main.jsp");
        
        return "layout";
    }

}