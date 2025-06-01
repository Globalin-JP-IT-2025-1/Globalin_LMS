package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.dto.PageInfo;
import com.library.service.MemberService;
import com.library.vo.Member;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/Members")
@AllArgsConstructor
public class MemberController {
    private final MemberService memberService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitle", pageInfo.getPageTitle());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    @GetMapping
    public String getAllMembers(Model model) {
    	List<Member> memberList = memberService.findAllMembers();
        
    	model.addAttribute("memberList", memberList);

    	pageInfo = PageInfo.builder()
			.pageTitle("회원 목록 조회")
			.pagePath("page/memberList.jsp")
			.build();
    	
    	setPageInfo(model);
    	
        return "layout";
    }

    
}