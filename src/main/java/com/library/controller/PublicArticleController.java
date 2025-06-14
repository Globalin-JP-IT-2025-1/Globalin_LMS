package com.library.controller;

import java.util.List;
import java.util.Map;

import javax.websocket.server.PathParam;

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
public class PublicArticleController {
    private final ArticleService articleService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 카테고리별 게시글 목록 조회
    @GetMapping("/{category}")
    public String getArticlesByCategory(@PathParam("category") String category, Model model) {
    	System.out.println("✅ ArticleController - /private/articles/" + category + " - GET 요청 정상 처리!");
		
		List<Article> articleList = articleService.getAllArticlesByCategory(category);
		
		model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("24")
    			.pagePath("page/3-article/articleList_" + category + ".jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    // 게시글 상세 조회 - faq 제외
    @GetMapping("/{articlesId}")
    public String getArticlesRequest(@PathParam("articlesId") int articlesId, Model model) {
    	System.out.println("✅ ArticleController - /private/articles/" + articlesId + " - GET 요청 정상 처리!");
		
		Map<String, Object> articleWithReply = articleService.getArticleWithReply(articlesId);
		
		model.addAttribute("article", articleWithReply.get("article"));
		if (articleWithReply.containsKey("reply")) {
			model.addAttribute("reply", articleWithReply.get("reply"));
		}
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("24")
    			.pagePath("page/3-article/articleDetail.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    
}