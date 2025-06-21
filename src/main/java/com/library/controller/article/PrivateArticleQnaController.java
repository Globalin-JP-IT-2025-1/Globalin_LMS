package com.library.controller.article;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.Article;
import com.library.model.PageInfo;
import com.library.service.ArticleService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/private/articles/qna")
@AllArgsConstructor
public class PrivateArticleQnaController {
    private final ArticleService articleService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 등록 폼 요청
 	@GetMapping("/add")
 	public String showAddForm(Model model) {
 		
 		pageInfo = PageInfo.builder()
 				.pageTitleCode("23")
 				.pagePath("page/3-article/addForm_article_qna.jsp")
 				.build();
 		  
 		setPageInfo(model);
 		  
 		return "layout";
 	}
 	
    // 등록 처리
 	@PostMapping
     public String insertProc(@ModelAttribute Article article,  
     						  RedirectAttributes redirectAttributes) {
     	
     	try {
     		articleService.insertArticle(article); // 게시글 등록
     		
     	} catch (Exception e) {
     		e.printStackTrace();
     		
     		redirectAttributes.addFlashAttribute("alertType", "fail");
     		redirectAttributes.addFlashAttribute("alertMessage", "Q&A가 등록되지 않았습니다. 다시 시도해주세요.");
     		//redirectAttributes.addFlashAttribute("article", article); // 입력 내용 반환
     		
     		return "redirect:/public/articles/qna/"; // 실패: 등록 폼으로 이동
     	}
     	
     	redirectAttributes.addFlashAttribute("alertType", "success");
     	redirectAttributes.addFlashAttribute("alertMessage", "Q&A가 등록되었습니다.");
     	
     	return "redirect:/public/articles/qna/"; // 성공: 목록으로 이동
     }
     
	// 내용 수정 처리
    @PutMapping("/{articlesId}")
    public String updateInfoProc(@PathVariable("articlesId") int articlesId, 
					    		 @ModelAttribute Article article,
					     		 RedirectAttributes redirectAttributes) {
    	 
     	try {
 			//articleService.updateArticleInfo(article); // 게시글 내용 수정
     		
     	} catch (Exception e) {
     		e.printStackTrace();
     		
     		redirectAttributes.addFlashAttribute("alertType", "fail");
 			redirectAttributes.addFlashAttribute("alertMessage", "내용 수정되지 않았습니다. 다시 시도해주세요.");
 			redirectAttributes.addFlashAttribute("article", article); // 입력 내용 반환
     		
     		return "redirect:/public/articles/qna/" + articlesId + "/edit"; // 실패: 상세 조회로 이동
     	}
     	
     	redirectAttributes.addFlashAttribute("alertType", "success");
 		redirectAttributes.addFlashAttribute("alertMessage", "수정되었습니다.");
 		
     	
     	return "redirect:/public/articles/qna/" + articlesId; // 성공: 상세 조회로 이동
     	
    }
     
    // 활성화, 비활성화 처리
    @PutMapping("/{articlesId}/{type}")
    public String updateDisplayProc(@PathVariable("articlesId") int articlesId, 
						    		 @PathVariable("status") int type,
						     		 RedirectAttributes redirectAttributes) {
     	try {
     		if (type == 1) {
     			articleService.updateArticleDisable(articlesId); // 게시글 비활성화 (soft del)
     		} else if (type == 0) {
     			articleService.updateArticleEnable(articlesId); // 게시글 활성화
     		} else if (type == 2) {
     			articleService.updateArticleSecret(articlesId); // 게시글 잠금 (soft del)
     		}
     		
     	} catch (Exception e) {
     		e.printStackTrace();
     		
     		redirectAttributes.addFlashAttribute("alertType", "fail");
     		if (type == 1) {
     			redirectAttributes.addFlashAttribute("alertMessage", "[희망 도서 신청] 삭제 실패");
     		} else if (type == 0) {
     			redirectAttributes.addFlashAttribute("alertMessage", "[희망 도서 신청] 공개 실패");
     		} else if (type == 2) {
     			redirectAttributes.addFlashAttribute("alertMessage", "[희망 도서 신청] 비공개 실패");
     		}
     		
     		return "redirect:/public/articles/qna/" + articlesId; // 실패: 상세 조회로 이동
     	}
     	
     	redirectAttributes.addFlashAttribute("alertType", "success");
     	if (type == 1) {
 			redirectAttributes.addFlashAttribute("alertMessage", "[희망 도서 신청] 삭제 성공");
 		} else if (type == 0) {
 			redirectAttributes.addFlashAttribute("alertMessage", "[희망 도서 신청] 공개 성공");
 		} else if (type == 2) {
 			redirectAttributes.addFlashAttribute("alertMessage", "[희망 도서 신청] 비공개 성공");
 		}
     	
     	return "redirect:/public/articles/qna/" + articlesId; // 성공: 상세 조회로 이동
    }
     
    // 삭제 처리 (hard del)
    @DeleteMapping("/{articlesId}")
    public String deleteProc(@PathVariable("articlesId") int articlesId,
     						  RedirectAttributes redirectAttributes) {
     	
     	try {
 			articleService.deleteArticleById(articlesId); // 게시글 DB 삭제
     		
     	} catch (Exception e) {
     		e.printStackTrace();
     		
     		redirectAttributes.addFlashAttribute("alertType", "fail");
 			redirectAttributes.addFlashAttribute("alertMessage", "삭제되지않았습니다. 다시 시도해주세요.");
     		
 			return "redirect:/public/articles/qna/" + articlesId; // 실패: 상세 조회로 이동
     	}
     	
     	redirectAttributes.addFlashAttribute("alertType", "success");
 		redirectAttributes.addFlashAttribute("alertMessage", "삭제되었습니다.");
     	
 		return "redirect:/public/articles/qna"; // 성공: 목록으로 이동
    }
    
    // 수정 폼 요청 --> js
    
}