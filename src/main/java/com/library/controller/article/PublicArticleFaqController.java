package com.library.controller.article;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.ArticleListResponse;
import com.library.model.PageInfo;
import com.library.service.ArticleService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// faq 목록 조회
@Slf4j
@Controller
@RequestMapping("/public/articles/faq")
@AllArgsConstructor
public class PublicArticleFaqController {
    private final ArticleService articleService; // 게시글
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // faq 목록 조회
    @GetMapping
    public String getListFaq(@RequestParam(defaultValue = "1") int page, 
    						 HttpServletRequest request,
    						 Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	ArticleListResponse articleListWithAuthor = articleService.getArticleListByCategory("faq", page);
    	
    	model.addAttribute("articleListWithAuthor", articleListWithAuthor.getArticleWithAuthorList());
		model.addAttribute("totalCount", articleListWithAuthor.getTotalCount());
    	model.addAttribute("totalPages", articleListWithAuthor.getTotalPages());
    	model.addAttribute("currentPage", page);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("22")
    			.pagePath("page/3-article/articleList_faq.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // faq 상세 조회 --> x
    // 수정 폼 요청 --> admin
    // 등록 처리 --> admin
    // 내용 수정 처리 --> admin
    // 활성화, 비활성화 처리 --> admin
    // 삭제 처리 --> admin
    
    
}