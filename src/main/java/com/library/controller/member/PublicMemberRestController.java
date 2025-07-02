package com.library.controller.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.library.model.member.Member;
import com.library.service.MemberService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/public/members")
@RequiredArgsConstructor
public class PublicMemberRestController {
    private final MemberService memberService;
    
    // 아이디 중복확인
	@PostMapping("/dupli/username")
	@ResponseBody
	public Map<String, Boolean> checkUsername(@RequestBody Member member) {
    	System.out.println(member.getUsername());
        boolean isAvailable = !memberService.isUsernameDuplicate(member.getUsername());
        
        Map<String, Boolean> response = new HashMap<>();
        response.put("available", isAvailable);  // true면 사용 가능
        return response;
    }
    
    // 이메일 중복확인
	@PostMapping("/dupli/email")
	@ResponseBody
	public Map<String, Boolean> checkEmail(@RequestBody Member member) {
        boolean isAvailable = !memberService.isEmailDuplicate(member.getEmail());
        
        Map<String, Boolean> response = new HashMap<>();
        response.put("available", isAvailable);  // true면 사용 가능
        return response;
    }

}