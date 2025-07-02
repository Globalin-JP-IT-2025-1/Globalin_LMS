package com.library.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.PageInfo;
import com.library.model.article.ReplyListResponse;
import com.library.service.ReplyService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/replies")
@AllArgsConstructor
public class AdminReplyController {
    private final ReplyService replyService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 관리용 댓글 전체 목록 조회
    @GetMapping
    public String getReplyList(@RequestParam(defaultValue = "1") int page, 
    							 Model model) {
    	ReplyListResponse replyList = replyService.getReplyList(page);
    	
    	System.out.println(replyList.getReplyList().size());
    	
		model.addAttribute("replyList", replyList.getReplyList()); // 댓글 목록 (작성자 포함)
		model.addAttribute("totalCount", replyList.getTotalCount()); // 페이징
    	model.addAttribute("totalPages", replyList.getTotalPages()); // 페이징
    	model.addAttribute("currentPage", page); // 페이징
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("93")
    			.pagePath("page/9-admin/replyList_admin.jsp")
    			.build();
        	
        setPageInfo(model);
    	
        return "layout";
    }

    
}