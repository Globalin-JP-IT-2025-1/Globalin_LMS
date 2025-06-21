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

// qna 목록 조회 및 상세 조회
@Controller
@RequestMapping("/public/articles/qna")
@AllArgsConstructor
public class PublicArticleQnaController {
    private final ArticleService articleService; // 게시글
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // qna 목록 조회
    @GetMapping
    public String getListQna(@RequestParam(defaultValue = "1") int page, 
							 Model model) {
		ArticleListResponse articleListWithAuthor = articleService.getArticleListByCategory("qna", page);
		
		model.addAttribute("articleListWithAuthor", articleListWithAuthor.getArticleWithAuthorList());
		model.addAttribute("totalCount", articleListWithAuthor.getTotalCount());
    	model.addAttribute("totalPages", articleListWithAuthor.getTotalPages());
    	model.addAttribute("currentPage", page);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("23")
    			.pagePath("page/3-article/articleList_qna.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }

    // qna 상세 조회
    @GetMapping("/{articlesId}")
    public String getDetailQna(@PathVariable("articlesId") int articlesId, 
    						   @RequestParam(defaultValue = "1") int page,
    						   RedirectAttributes redirectAttributes,
    						   Model model) {
		try {
			ArticleDetailResponse ArticleDetail = articleService.getArticleWithReplyList(articlesId, page);
			
			model.addAttribute("article", ArticleDetail.getArticleWithAuthor()); // 게시글 상세 정보
			model.addAttribute("replyList", ArticleDetail.getReplyList().getReplyList()); // 댓글 리스트
			model.addAttribute("totalCount", ArticleDetail.getReplyList().getTotalCount());
	    	model.addAttribute("totalPages", ArticleDetail.getReplyList().getTotalPages());
	    	model.addAttribute("currentPage", page);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			redirectAttributes.addFlashAttribute("alertType", "fail");
			redirectAttributes.addFlashAttribute("alertMesssage", "게시글 상세 조회에 실패하였습니다.");
			
			return "redirect:/public/articles/qna";
		}
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("23")
    			.pagePath("page/3-article/articleDetail_qna.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // 등록 폼 요청 --> private
    // 수정 폼 요청 --> js
    // 등록 처리 --> private
    // 내용 수정 처리 --> private
    // 활성화, 비활성화, 비밀글 처리 --> private
    // 삭제 처리 --> admin
    
    
}