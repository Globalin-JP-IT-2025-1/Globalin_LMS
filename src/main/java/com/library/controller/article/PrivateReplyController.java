package com.library.controller.article;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;
import com.library.model.Reply;
import com.library.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/private/replies/{articlesId}/{originCat}")
@AllArgsConstructor
public class PrivateReplyController {
    private final ReplyService replyService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
 	
     
	// 등록 처리
    @PostMapping
    public String insertProc(
    		 @PathVariable("originCat") String originCat, 
    		 @PathVariable("articlesId") int articlesId, 
    		 @ModelAttribute Reply reply, 
    		 RedirectAttributes redirectAttributes) {
     	
     	try {
     		reply.setOriginArticleId(articlesId); // 원본 글 설정
     		replyService.insertReply(reply); // 댓글 추가
     		
     	} catch (Exception e) {
     		e.printStackTrace();
     		
     		redirectAttributes.addFlashAttribute("alertType", "fail");
     		redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 등록 실패");
     		redirectAttributes.addFlashAttribute("reply", reply); // 입력 내용 반환
     		
     		return "redirect:/public/articles/" + originCat + "/" + articlesId; // 실패: 원본 글 상세 조회로 이동
     	}
     	
     	redirectAttributes.addFlashAttribute("alertType", "success");
     	redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 등록 성공");
     	
     	return "redirect:/public/articles/" + originCat + "/" + articlesId; // 성공: 원본 글 상세 조회로 이동
     }
 	
     
     // 활성화, 비활성화, 잠금 처리
     @PutMapping("/{repliesId}/{status}")
     public String updateDisplayProc(@PathVariable("originCat") String originCat,  // 원본 글 카테고리
    		 						 @PathVariable("articlesId") int articlesId,  // 원본 글 id
    		 						 @PathVariable("repliesId") int repliesId, // 댓글 id
    		 						 @PathVariable("status") int status,  // 요청 작업 코드
    		 						 HttpServletRequest request,
    		 			    		 RedirectAttributes redirectAttributes) {
     	
     	try {
     		if (status == 1) {
     			replyService.updateReplyDisable(repliesId); // 댓글 비활성화 (관리자 페이지에서만 조회 가능) (soft del)
     		} else if (status == 0) {
     			replyService.updateReplyEnable(repliesId); // 댓글 활성화 (모든 사용자 조회 가능)
     		} else if (status == 2) {
     			replyService.updateReplySecret(repliesId); // 댓글 잠금 (작성자, 관리자만 조회 가능)
     		}
     		
     	} catch (Exception e) {
     		e.printStackTrace();
     		
     		redirectAttributes.addFlashAttribute("alertType", "fail");
     		if (status == 1) {
     			redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 비활성화 실패");
     		} else if (status == 0) {
     			redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 활성화 실패");
     		} else if (status == 2) {
     			redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 잠금 실패");
     		}
     		
     		return "redirect:/public/articles/" + originCat + "/" + articlesId; // 실패: 원본 글 상세 조회로 이동
     	}
     	
     	redirectAttributes.addFlashAttribute("alertType", "success");
     	if (status == 1) {
 			redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 비활성화 성공");
     	} else if (status == 0) {
 			redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 활성화 성공");
 		} else if (status == 2) {
 			redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 잠금 성공");
 		}
     	
     	System.out.println(request.getRequestURI());
     	
     	return "redirect:/public/articles/" + originCat + "/" + articlesId; // 성공: 원본 글 상세 조회로 이동
     }
     
     // 삭제 처리 (hard del)
     @DeleteMapping("/{articlesId}")
     public String deleteProc(@PathVariable("originCat") String originCat, 
    		 				  @PathVariable("repliesId") int repliesId, 
							  @PathVariable("articlesId") int articlesId, 
		 			    	  RedirectAttributes redirectAttributes) {
     	
     	try {
 			replyService.deleteReply(repliesId); // 댓글 DB 삭제
     		
     	} catch (Exception e) {
     		e.printStackTrace();
     		
     		redirectAttributes.addFlashAttribute("alertType", "fail");
 			redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 삭제 실패");
     		
 			return "redirect:/public/articles/" + originCat + "/" + articlesId; // 실패: 원본 게시글로 이동
     	}
     	
     	redirectAttributes.addFlashAttribute("alertType", "success");
 		redirectAttributes.addFlashAttribute("alertMessage", "[댓글] 삭제 성공");
     	
 		return "redirect:/public/articles/" + originCat + "/" + articlesId; // 성공: 원본 게시글로 이동
     }
     
    
    
}