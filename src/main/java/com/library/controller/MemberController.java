package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Member;
import com.library.service.MemberService;

@Controller
@RequestMapping("/Members")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping
    public String getAllMembers(Model model) {
    	List<Member> memberList = memberService.findAllMembers();
        
    	model.addAttribute("memberList", memberList);
    	model.addAttribute("pageTitle", "회원 목록 조회");
    	model.addAttribute("pagePath", "page/memberList.jsp");
    	
        return "layout";
    }

    
}
