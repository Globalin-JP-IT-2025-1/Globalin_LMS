package com.library.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String showHome(@RequestParam(value="status", defaultValue="1") Integer status,
    					   HttpServletRequest request, 
    					   Model model) {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
		
    	setPageInfo(model);
    	
    	if (status == -1) {
    		model.addAttribute("alertType", "fail");
    		model.addAttribute("alertMessage", "접근 권한이 없습니다.");
    	}
    	
        return "layout";
    }
    
}