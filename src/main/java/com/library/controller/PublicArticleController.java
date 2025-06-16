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
@RequestMapping("/public/articles")
@AllArgsConstructor
public class PublicArticleController {
    private final ArticleService articleService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 공지사항 목록 조회
    @GetMapping("/not")
    public String getAllArticlesNot(HttpServletRequest request, Model model) {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
		
//		List<Article> articleList = articleService.getAllArticlesByCategory("not");
//		
//		model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/3-article/articleList_not.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // 자주 묻는 질문 목록 조회
    @GetMapping("/faq")
    public String getAllArticlesFaq(HttpServletRequest request, Model model) {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
		
//		List<Article> articleList = articleService.getAllArticlesByCategory("not");
//		
//		model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("22")
    			.pagePath("page/3-article/articleList_faq.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // Q&A 목록 조회
    @GetMapping("/qna")
    public String getAllArticlesQna(HttpServletRequest request, Model model) {
		log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
		
//		List<Article> articleList = articleService.getAllArticlesByCategory("qna");
//		
//		model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("23")
    			.pagePath("page/3-article/articleList_qna.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    // 공지사항 상세 조회
    @GetMapping("/not/{articlesId}")
    public String getArticleNot(@PathVariable("articlesId") int articlesId, HttpServletRequest request, Model model) {
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
    			.pageTitleCode("22")
    			.pagePath("page/3-article/articleDetail_not.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // Q&A 상세 조회
    @GetMapping("/qna/{articlesId}")
    public String getArticleQna(@PathVariable("articlesId") int articlesId, HttpServletRequest request, Model model) {
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
    			.pageTitleCode("23")
    			.pagePath("page/3-article/articleDetail_qna.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    
}