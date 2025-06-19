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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/articles/not")
@AllArgsConstructor
public class AdminArticleNotController {
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
    			.pageTitleCode("21")
    			.pagePath("page/3-article/addForm_article_not.jsp")
    			.build();
        
        setPageInfo(model);
        
        return "layout";
    }
    
    // 수정 폼 요청
    @GetMapping("/edit/{articlesId}")
    public String showEditForm(Model model) {
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("21")
    			.pagePath("page/3-article/addForm_article_not.jsp")
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
    		
    		redirectAttributes.addAttribute("alertType", "fail");
    		redirectAttributes.addAttribute("alertMessage", "[공지사항] 등록 실패");
    		redirectAttributes.addFlashAttribute("article", article); // 입력 내용 반환
    		
    		return "redirect:/public/articles/not/add"; // 실패: 등록 폼으로 이동
    	}
    	
    	redirectAttributes.addAttribute("alertType", "success");
    	redirectAttributes.addAttribute("alertMessage", "[공지사항] 등록 성공");
    	
    	return "redirect:/public/articles/not"; // 성공: 목록으로 이동
    }
    
    
    // 내용 수정 처리
    @PutMapping("/{articlesId}")
    public String updateInfoProc(@PathVariable("articlesId") int articlesId, 
					    		 @ModelAttribute Article article,
					    		 RedirectAttributes redirectAttributes) {
    	
    	try {
			articleService.updateArticleInfo(article); // 게시글 내용 수정
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addAttribute("alertType", "fail");
			redirectAttributes.addAttribute("alertMessage", "[공지사항] 내용 수정 실패");
			redirectAttributes.addFlashAttribute("article", article); // 입력 내용 반환
    		
    		return "redirect:/public/articles/not/" + articlesId + "/edit"; // 실패: 상세 조회로 이동
    	}
    	
    	redirectAttributes.addAttribute("alertType", "success");
		redirectAttributes.addAttribute("alertMessage", "[공지사항] 내용 수정 성공");
		
    	
    	return "redirect:/public/articles/not/" + articlesId; // 성공: 상세 조회로 이동
    	
    }
    
    // 활성화, 비활성화, 잠금 처리
    @PutMapping("/{articlesId}/{type}")
    public String updateDisplayProc(@PathVariable("articlesId") int articlesId, 
    								@PathVariable("type") String type,
    								RedirectAttributes redirectAttributes) {
    	
    	try {
    		if (type.equals("disable")) {
    			articleService.updateArticleDisable(articlesId); // 게시글 비활성화
    		} else if (type.equals("enable")) {
    			articleService.updateArticleEnable(articlesId); // 게시글 활성화
    		} else if (type.equals("secret")) {
    			articleService.updateArticleEnable(articlesId); // 게시글 잠금
    		}
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addAttribute("alertType", "fail");
    		if (type.equals("disable")) {
    			redirectAttributes.addAttribute("alertMessage", "[공지사항] 비활성화 실패");
    		} else if (type.equals("enable")) {
    			redirectAttributes.addAttribute("alertMessage", "[공지사항] 활성화 실패");
    		} else if (type.equals("secret")) {
    			redirectAttributes.addAttribute("alertMessage", "[공지사항] 잠금 실패");
    		}
    		
    		return "redirect:/public/articles/not/" + articlesId; // 실패: 상세 조회로 이동
    	}
    	
    	redirectAttributes.addAttribute("alertType", "success");
    	if (type.equals("disable")) {
			redirectAttributes.addAttribute("alertMessage", "[공지사항] 비활성화 성공");
		} else if (type.equals("enable")) {
			redirectAttributes.addAttribute("alertMessage", "[공지사항] 활성화 성공");
		} else if (type.equals("secret")) {
			redirectAttributes.addAttribute("alertMessage", "[공지사항] 잠금 성공");
		}
    	
    	return "redirect:/public/articles/not/" + articlesId; // 성공: 상세 조회로 이동
    }
    
    // 삭제 처리
    @DeleteMapping("/{articlesId}")
    public String deleteProc(@PathVariable("articlesId") int articlesId, 
    						 RedirectAttributes redirectAttributes) {
    	
    	try {
			articleService.deleteArticleById(articlesId); // 게시글 DB 삭제
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addAttribute("alertType", "fail");
			redirectAttributes.addAttribute("alertMessage", "[공지사항] 삭제 실패");
    		
			return "redirect:/public/articles/not/" + articlesId; // 실패: 상세 조회로 이동
    	}
    	
    	redirectAttributes.addAttribute("alertType", "success");
		redirectAttributes.addAttribute("alertMessage", "[공지사항] 삭제 성공");
    	
		return "redirect:/public/articles/not"; // 성공: 목록으로 이동
    }
    
    
}