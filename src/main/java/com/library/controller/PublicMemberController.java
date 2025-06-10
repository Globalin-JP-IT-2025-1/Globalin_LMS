package com.library.controller;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.Member;
import com.library.model.PageInfo;
import com.library.service.EmailService;
import com.library.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/public/members")
@AllArgsConstructor
public class PublicMemberController {
    private final MemberService memberService;
    private final EmailService emailService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 회원 가입 여부 확인 폼
    @GetMapping("/check")
    public String showMemberCheck(Model model) {
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("62")
    			.pagePath("page/memberCheck.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }

    // 회원 가입 여부 확인하기 + 이메일 보내기
    @PostMapping("/check")
    public ResponseEntity<Void> checkMember(@RequestBody Map<String, String> requestData) {
		Member member = memberService.getMemberByEmail(requestData.get("email"));
		
		if (member == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // 404 반환 (회원 없음)
		}
		
    	if (!member.getMobile().equals(requestData.get("mobile"))) {
    		return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // 404 반환 (회원 정보 불일치)
    	}
    	
    	emailService.sendUsername(member);
    	
    	return ResponseEntity.ok().build(); // 성공 시 200 반환
    }
    
    // 비밀번호 재발급 폼
    @GetMapping("/repass")
    public String showResetPassword(Model model) {
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("63")
    			.pagePath("page/resetPassword.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }
    
    // 비밀번호 재발급 + 이메일 보내기
    @PostMapping("/repass")
    public ResponseEntity<Void> resetPassword(@RequestBody Map<String, String> requestData) {
		Member member = memberService.getMemberByEmail(requestData.get("email"));
		
		if (member == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // 404 반환 (회원 없음)
		}
		
    	if (!member.getMobile().equals(requestData.get("mobile"))) {
    		return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // 404 반환 (회원 정보 불일치)
    	}
    	
    	String repass = memberService.resetPassword(member);
		emailService.sendResetPassword(member, repass);
    	
    	return ResponseEntity.ok().build(); // 성공 시 200 반환
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
    
    // 회원 등록
    @PostMapping
    public ResponseEntity<Member> insertMember(@RequestBody Map<String, String> requestData) {
    	Member member = Member.builder()
    			.username(requestData.get("username"))
    			.password(requestData.get("password"))
    			.name(requestData.get("name"))
    			.email(requestData.get("email"))
    			.mobile(requestData.get("mobile"))
    			.zipcode(requestData.get("zipcode"))
    			.address(requestData.get("address"))
    			.build();
    	
    	if (memberService.insertMember(member) < 0) {
    		return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    	}
    	
    	member = memberService.getMemberByUsername(member.getUsername());
    	
    	if (member.getMembersId() < 0) {
    		return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    	}
    	
    	emailService.sendRegister(member);
    	
    	return ResponseEntity.ok().body(member);
    }

}