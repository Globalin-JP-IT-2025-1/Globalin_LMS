package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.dto.PageInfo;
import com.library.service.MemberService;
import com.library.vo.Member;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/members")
@AllArgsConstructor
public class MemberController {
    private final MemberService memberService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitle", pageInfo.getPageTitle());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 회원 목록 조회
    @GetMapping
    public String getAllMembers(Model model) {
    	List<Member> memberList = memberService.findAllMembers();
        
    	model.addAttribute("memberList", memberList);

    	pageInfo = PageInfo.builder()
			.pageTitle(new String[] { "", "회원 목록 조회" })
			.pagePath("page/memberList.jsp")
			.build();
    	
    	model.addAttribute("alertType", "success");
    	model.addAttribute("alertMessage", "회원 목록 조회를 완료하였습니다.");
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 회원 상세 조회
    @GetMapping("/{membersId}")
    public String getMemberById(@PathVariable("membersId") int membersId, Model model) {
    	Member member = memberService.findMemberById(membersId);
        
    	model.addAttribute("member", member);

    	pageInfo = PageInfo.builder()
			.pageTitle(new String[] { "내 서재", "내 정보" })
			.pagePath("page/memberDetail.jsp")
			.build();
    	
    	model.addAttribute("alertType", "success");
    	model.addAttribute("alertMessage", "회원" + member.getName() + "의 상세 정보 조회를 완료하였습니다.");
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    
    // 회원 정보 수정 (회원 탈퇴 처리 포함)
    @RequestMapping(value = "/{membersId}", method = RequestMethod.PUT)
    public String updateMember(@PathVariable("membersId") int membersId, RedirectAttributes redirectAttributes) {
    	int result = memberService.updateMember(membersId);
    	
    	if (result == 1) {
    		redirectAttributes.addFlashAttribute("alertType", "error");
        	redirectAttributes.addFlashAttribute("alertMessage", "회원 정보 수정 실패");

        	return "redirect:/members/" + membersId + "/edit"; // 회원 정보 수정 페이지 그대로
    	}
    	redirectAttributes.addFlashAttribute("alertType", "success");
    	redirectAttributes.addFlashAttribute("alertMessage", "회원 정보 수정 완료");
    	
    	return "redirect:/members/" + membersId; // 회원 정보 상세 조회 페이지로
    }
    
    // 회원 삭제
    @RequestMapping(value = "/{membersId}", method = RequestMethod.DELETE)
    public String deleteMember(@PathVariable("membersId") int membersId, RedirectAttributes redirectAttributes) {
    	int result = memberService.deleteMember(membersId);
    	
    	if (result == 1) {
    		redirectAttributes.addFlashAttribute("alertType", "error");
        	redirectAttributes.addFlashAttribute("alertMessage", "회원 삭제 실패");

        	return "redirect:/members/" + membersId; // 회원 정보 상세 조회 페이지 그대로
    	}
    	redirectAttributes.addFlashAttribute("alertType", "success");
    	redirectAttributes.addFlashAttribute("alertMessage", "회원 삭제 완료");
    	
    	return "redirect:/"; // 홈으로
    }
    
}