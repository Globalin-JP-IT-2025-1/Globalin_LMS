package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.dto.Article;
import com.library.dto.PageInfo;
import com.library.service.ArticleService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/Articles")
@AllArgsConstructor
public class ArticleController {
    private final ArticleService articleService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    @GetMapping
    public String getAllArticles(Model model) {
    	System.out.println("✅ ArticleController - /Articles - GET 요청 정상 처리!");
    	List<Article> articleList = articleService.getAllArticles();
        
    	model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/articleList.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    
}