package com.library.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Article;
import com.library.model.PageInfo;
import com.library.service.ArticleService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
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
    public String getArticlesReq(HttpServletRequest request, Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
		
//		List<Article> articleList = articleService.getAllArticlesByCategory("req");
//		
//		model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("24")
    			.pagePath("page/3-article/articleList_req.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // 희망도서 신청 상세 조회
    @GetMapping("/req/{articlesId}")
    public String getArticleReq(@PathVariable("articlesId") int articlesId, HttpServletRequest request, Model model) {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
		
//		Map<String, Object> articleWithReply = articleService.getArticleWithReply(articlesId);
//		
//		model.addAttribute("article", articleWithReply.get("article"));
//		if (articleWithReply.containsKey("reply")) {
//			model.addAttribute("reply", articleWithReply.get("reply"));
//		}
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("24")
    			.pagePath("page/3-article/articleDetail_req.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    
}