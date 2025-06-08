package com.library.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.dto.Member;
import com.library.dto.PageInfo;
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

    // 회원 등급 수정 (준-->정)
    @PatchMapping("/{membersId}/grade")
    public ResponseEntity<Void> updateMemberGrade(@PathVariable("membersId") int membersId) {
        int result = memberService.updateMemberGrade(membersId);

        if (result == -1) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 실패 시 400 반환
        }

        return ResponseEntity.ok().build(); // 성공 시 200 반환
    }

    
    // 회원 삭제
    @DeleteMapping("/{membersId}")
    public ResponseEntity<Void> deleteMembers(@PathVariable("membersId") int membersId) {
        int result = memberService.deleteMember(membersId);

        if (result == -1) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 실패 시 400 반환
        }

        return ResponseEntity.ok().build(); // 성공 시 200 반환
    }



}