package com.library.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.PageInfo;
import com.library.service.ArticleService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
    
    // 관리용 게시글 전체 목록 조회
    @GetMapping
    public String getAllArticles(Model model) {
    	
//		List<Article> articleList = articleService.getAllArticles();
//		model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("93")
    			.pagePath("page/9-admin/articleList_admin.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    
}