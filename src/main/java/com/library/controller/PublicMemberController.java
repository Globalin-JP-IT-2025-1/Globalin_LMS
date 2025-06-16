package com.library.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.model.Member;
import com.library.model.PageInfo;
import com.library.service.EmailService;
import com.library.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/public/members")
@RequiredArgsConstructor
@PropertySource("classpath:application.properties")
public class PublicMemberController {
    private final MemberService memberService;
    private final EmailService emailService;
    @Value("${google.maps.api.key}")
    private String apiKey;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    // 회원가입 폼 --> ok
    @GetMapping("/register")
    public String showRegForm(@RequestParam(value = "status", defaultValue = "1") Integer status, Model model) {
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("64")
    			.pagePath("page/1-member/regForm.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	model.addAttribute("apiKey", apiKey);
    	
    	if (status == -1) {
    		model.addAttribute("alertType", "fail");
    		model.addAttribute("alertMessage", "회원가입 실패 하였습니다. 다시 시도 해주세요.");
    	}
    	
    	return "layout";
    }
    
    // 회원 등록 --> ok
    @PostMapping
    public String insertMember(@ModelAttribute Member member) {
    	
    	try {
    		memberService.insertMember(member);
    	} catch (Exception e) {
    		e.printStackTrace();
    		return "redirect:/public/members/register?status=-1"; // 실패(-1): 회원 가입 폼으로 이동
    	}
    	
    	// 메일 보내기
		// emailService.sendRegister(member);
    	
    	return "redirect:/public/auth/login?status=2"; // 성공(2): 로그인 폼으로 이동
    }
    
    // 회원 가입 여부 확인 폼
    @GetMapping("/check")
    public String showMemberCheck(Model model) {
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("62")
    			.pagePath("page/1-member/memberCheck.jsp")
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
    			.pagePath("page/1-member/resetPassword.jsp")
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

}