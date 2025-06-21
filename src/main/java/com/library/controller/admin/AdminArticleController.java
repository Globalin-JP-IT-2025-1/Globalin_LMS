package com.library.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.ArticleListResponse;
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
    
    // 관리용 게시글 전체 목록 조회
    @GetMapping
    public String getArticleList(@RequestParam(defaultValue = "1") int page, 
    							 Model model) {
    	ArticleListResponse articleList = articleService.getArticleList(page);
    	
		model.addAttribute("articleListWithAuthor", articleList.getArticleWithAuthorList()); // 게시글 목록
		model.addAttribute("totalCount", articleList.getTotalCount()); // 게시글 페이징
    	model.addAttribute("totalPages", articleList.getTotalPages()); // 게시글 페이징
    	model.addAttribute("currentPage", page); // 게시글 페이징
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("93")
    			.pagePath("page/9-admin/articleList_admin.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    
}