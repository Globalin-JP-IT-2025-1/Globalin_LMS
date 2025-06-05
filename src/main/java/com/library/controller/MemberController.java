package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 회원 목록 조회
    @GetMapping
    public String getAllMembers(Model model) {
    	List<Member> memberList = memberService.getAllMembers();
        
    	model.addAttribute("memberList", memberList);

    	pageInfo = PageInfo.builder()
			.pageTitleCode("91")
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
    	Member member = memberService.getMemberById(membersId);
        
    	model.addAttribute("member", member);

    	pageInfo = PageInfo.builder()
			.pageTitleCode("31")
			.pagePath("page/memberDetail.jsp")
			.build();
    	
    	model.addAttribute("alertType", "success");
    	model.addAttribute("alertMessage", "" + member.getName() + " 님의 상세 정보 조회를 완료하였습니다.");
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 회원가입 폼
    @GetMapping("/register")
    public String showRegForm(Model model) {
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("64")
    			.pagePath("page/regForm.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // 회원 정보 수정 폼으로 이동
    @GetMapping("/{membersId}/edit")
    public String showEditMemberInfo(@PathVariable("membersId") int membersId, Model model) {
    	Member member = memberService.getMemberById(membersId);
    	
    	model.addAttribute("member", member);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("31")
    			.pagePath("page/editForm_member.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // 회원 목록 조회
    @PostMapping
    public String insertMember(RedirectAttributes redirectAttributes) {
    	int result = memberService.insertMember();
    	
    	if (result == 1) {
    		redirectAttributes.addFlashAttribute("alertType", "error");
        	redirectAttributes.addFlashAttribute("alertMessage", "회원 가입 실패");

        	return "redirect:/members/register"; // 회원 정보 상세 조회 페이지 그대로
    	}
    	redirectAttributes.addFlashAttribute("alertType", "success");
    	redirectAttributes.addFlashAttribute("alertMessage", "회원 가입 완료");
    	
    	return "redirect:/"; // 홈으로
    }
    

    // 회원 정보 수정 (회원 탈퇴 처리 포함)
    @PutMapping("/{membersId}")
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
    
    // 회원 탈퇴 처리
    @PatchMapping("/{membersId}/leave")
    public String leaveMember(@PathVariable("membersId") int membersId, RedirectAttributes redirectAttributes) {
    	int result = memberService.leaveMember(membersId);
    	
    	if (result == 1) {
    		redirectAttributes.addFlashAttribute("alertType", "error");
        	redirectAttributes.addFlashAttribute("alertMessage", "회원 탈퇴 실패");

        	return "redirect:/members/" + membersId; // 회원 정보 조회 페이지 그대로
    	}
    	redirectAttributes.addFlashAttribute("alertType", "success");
    	redirectAttributes.addFlashAttribute("alertMessage", "회원 탈퇴 완료");
    	
    	return "redirect:/"; // 홈으로
    }
    
    // 회원 삭제
    @DeleteMapping("/{membersId}")
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