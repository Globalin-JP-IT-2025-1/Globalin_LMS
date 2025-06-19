package com.library.controller.article;

import java.util.List;
import java.util.Map;

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

// not, faq, qna 목록 조회 및 상세 조회
@Slf4j
@Controller
@RequestMapping("/public/articles")
@AllArgsConstructor
public class PublicArticleController {
    private final ArticleService articleService; // 게시글
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // not 목록 조회 --> ok
    @GetMapping("/not")
    public String getListNot(Model model) {
		
		Map<String, Object> articleListWithAuthor = articleService.getAllArticlesByCategoryWithAuthor("not");
		
		model.addAttribute("articleList", articleListWithAuthor.get("articleList"));
		model.addAttribute("authorList", articleListWithAuthor.get("authorList"));
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/3-article/articleList_not.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // faq 목록 조회
    @GetMapping("/faq")
    public String getListFaq(Model model) {
		
		List<Article> articleList = articleService.getAllArticlesByCategory("faq");
		model.addAttribute("articleList", articleList);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("22")
    			.pagePath("page/3-article/articleList_faq.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // qna 목록 조회
    @GetMapping("/qna")
    public String getListQna(Model model) {
    	
    	Map<String, Object> articleListWithAuthor = articleService.getAllArticlesByCategoryWithAuthor("qna");
    	
    	model.addAttribute("articleList", articleListWithAuthor.get("articleList"));
    	model.addAttribute("authorList", articleListWithAuthor.get("authorList"));
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("23")
    			.pagePath("page/3-article/articleList_qna.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // not 상세 조회 --> test 중
    @GetMapping("/not/{articlesId}")
    public String getDetailNot(@PathVariable("articlesId") int articlesId, 
			    		       Model model) {
		
		try {
			Map<String, Object> articleWithAuthorAndReplies = articleService.getArticleWithAuthorAndReplies(articlesId);
			model.addAttribute("article", articleWithAuthorAndReplies.get("article")); // 게시글 상세 정보
			model.addAttribute("a_author", articleWithAuthorAndReplies.get("a_author")); // 작성자 정보
			model.addAttribute("replyList", articleWithAuthorAndReplies.get("replyList")); // 댓글 리스트
			model.addAttribute("r_authorList", articleWithAuthorAndReplies.get("r_authorList")); // 댓글 작성자 리스트
			
		} catch (Exception e) {
			e.printStackTrace();
			
			model.addAttribute("alertType", "fail");
			model.addAttribute("alertMesssage", "[공지사항] 게시글 상세 조회 실패");
		}
		
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/3-article/articleDetail_not.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }
    
    // qna 상세 조회 (+댓글)
    @GetMapping("/qna/{articlesId}")
    public String getDetailQna(@PathVariable("articlesId") int articlesId, 
				    		   Model model) {
		
		try {
			Map<String, Object> articleWithAuthorAndReplies = articleService.getArticleWithAuthorAndReplies(articlesId);
			model.addAttribute("article", articleWithAuthorAndReplies.get("article")); // 게시글 상세 정보
			model.addAttribute("author", articleWithAuthorAndReplies.get("author")); // 작성자 정보
			model.addAttribute("replyList", articleWithAuthorAndReplies.get("replyList")); // 댓글 리스트
			
		} catch (Exception e) {
			e.printStackTrace();
			
			model.addAttribute("alertType", "fail");
			model.addAttribute("alertMesssage", "[Q&A] 게시글 상세 조회 실패");
		}
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("23")
    			.pagePath("page/3-article/articleDetail_qna.jsp")
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