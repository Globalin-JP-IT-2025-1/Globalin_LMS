package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Article;
import com.library.model.PageInfo;
import com.library.service.ArticleService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/private/articles")
@AllArgsConstructor
public class PrivateArticleController {
    private final ArticleService articleService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 희망 도서 신청 전체 목록 조회
    @GetMapping("/req")
    public String getArticlesRequest(Model model) {
    	System.out.println("✅ ArticleController - /private/articles/req - GET 요청 정상 처리!");
		
		List<Article> articleList = articleService.getAllArticlesByCategory("req");
		
		model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("24")
    			.pagePath("page/3-article/articleList_req.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    
}