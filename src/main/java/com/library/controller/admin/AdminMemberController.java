package com.library.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;
import com.library.model.member.MemberListResponse;
import com.library.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/members")
@AllArgsConstructor
public class AdminMemberController {
    private final MemberService memberService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 회원 목록 조회
    @GetMapping
    public String getMemberList(@RequestParam(defaultValue = "1") int page,
    							Model model) {
    	MemberListResponse memberList = memberService.getMemberList(page);
    	
		model.addAttribute("memberList", memberList.getMemberList()); // 게시글 목록
		model.addAttribute("totalCount", memberList.getTotalCount()); // 게시글 페이징
    	model.addAttribute("totalPages", memberList.getTotalPages()); // 게시글 페이징
    	model.addAttribute("currentPage", page); // 게시글 페이징
    	
    	pageInfo = PageInfo.builder()
			.pageTitleCode("94")
			.pagePath("page/9-admin/memberList.jsp")
			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }

    // 회원 삭제
    @DeleteMapping("/{membersId}")
    public String deleteMember(@PathVariable("membersId") int membersId,
    						   RedirectAttributes redirectAttributes) {

        try {
    		memberService.deleteMember(membersId);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", "[회원] 삭제 실패");
    		
    		return "redirect:/admin/members"; // 실패: 회원 목록으로
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
		redirectAttributes.addFlashAttribute("alertMessage", "[회원] 삭제 성공");
		
		return "redirect:/admin/members"; // 성공: 회원 목록으로
    }



}