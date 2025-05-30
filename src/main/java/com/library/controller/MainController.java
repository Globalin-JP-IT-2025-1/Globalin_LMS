package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping({"/", "/home"})
public class MainController {
    
    @GetMapping
    public String showHome(@RequestParam(name = "userid", required = false) String userid, Model model) {
    	System.out.println("✅ HomeController - /, /home - GET 요청 정상 처리!");
    	
    	if (userid != null) {
    		model.addAttribute("userid", userid);
    	}
        model.addAttribute("pageTitle", "main");
        model.addAttribute("pagePath", "page/main.jsp");
        
        return "layout";
    }

}