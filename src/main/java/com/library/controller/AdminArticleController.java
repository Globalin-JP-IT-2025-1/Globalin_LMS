package com.library.controller;

import java.util.List;

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
@RequestMapping("/admin/articles")
@AllArgsConstructor
public class AdminArticleController {
    private final ArticleService articleService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 전체 게시글 목록 조회
    @GetMapping
    public String getArticles(Model model) {
    	System.out.println("✅ AdminArticleController - /admin/articles/ - GET 요청 정상 처리!");
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("93")
    			.pagePath("page/9-admin/articleList_admin.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // 공지사항 게시글 등록 폼 요청
    @GetMapping("/not/add")
    public String getArticlesNotice(Model model) {
    	System.out.println("✅ AdminArticleController - /admin/articles/not/add - GET 요청 정상 처리!");
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/3-article/addForm_article.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    
}