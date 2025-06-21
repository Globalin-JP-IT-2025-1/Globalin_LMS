package com.library.controller.article;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.ArticleDetailResponse;
import com.library.model.ArticleListResponse;
import com.library.model.PageInfo;
import com.library.service.ArticleService;

import lombok.AllArgsConstructor;

// not 목록 조회 및 상세 조회
@Controller
@RequestMapping("/public/articles/not")
@AllArgsConstructor
public class PublicArticleNotController {
    private final ArticleService articleService; // 게시글
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // not 목록 조회 --> ok
    @GetMapping
    public String getListNot(@RequestParam(defaultValue = "1") int page, 
							 Model model) {
    	
    	ArticleListResponse articleList = articleService.getArticleListByCategory("not", page);
		
		model.addAttribute("articleListWithAuthor", articleList.getArticleWithAuthorList()); // 게시글 목록
		model.addAttribute("totalCount", articleList.getTotalCount()); // 게시글 페이징
    	model.addAttribute("totalPages", articleList.getTotalPages()); // 게시글 페이징
    	model.addAttribute("currentPage", page); // 게시글 페이징
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/3-article/articleList_not.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    // not 상세 조회 --> ok
    @GetMapping("/{articlesId}")
    public String getDetailNot(@PathVariable("articlesId") int articlesId, 
				    		   @RequestParam(defaultValue = "1") int page,
						       RedirectAttributes redirectAttributes,
							   Model model) {
		try {
			ArticleDetailResponse articleDetail = articleService.getArticleWithReplyList(articlesId, page);
			
			model.addAttribute("article", articleDetail.getArticleWithAuthor()); // 게시글 상세 정보
			model.addAttribute("replyList", articleDetail.getReplyList().getReplyList()); // 댓글 리스트
			model.addAttribute("totalCount", articleDetail.getReplyList().getTotalCount()); // 댓글 페이징
	    	model.addAttribute("totalPages", articleDetail.getReplyList().getTotalPages()); // 댓글 페이징
	    	model.addAttribute("currentPage", page); // 댓글 페이징
			
		} catch (Exception e) {
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("alertType", "fail");
			redirectAttributes.addFlashAttribute("alertMesssage", "게시글 상세 조회에 실패하였습니다.");
			
			return "redirect:/public/articles/not";
		}
		
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/3-article/articleDetail_not.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // 등록 폼 요청 --> admin
    // 수정 폼 요청 --> js
    // 등록 처리 --> admin
    // 내용 수정 처리 --> admin
    // 활성화, 비활성화 처리 --> admin
    // 삭제 처리 --> admin
    
}