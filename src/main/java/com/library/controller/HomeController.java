package com.library.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.PageInfo;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
    public String showHome(HttpServletRequest request, 
    					   Model model) {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
		
    	setPageInfo(model);
    	
        return "layout";
    }
    
}