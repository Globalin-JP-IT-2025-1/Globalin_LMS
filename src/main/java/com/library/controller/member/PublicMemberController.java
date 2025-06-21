package com.library.controller.member;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.Member;
import com.library.model.PageInfo;
import com.library.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/public/members")
@RequiredArgsConstructor
@PropertySource("classpath:application.properties")
public class PublicMemberController {
    private final MemberService memberService;
    //private final EmailService emailService;
    
    @Value("${google.maps.api.key}")
    private String apiKey;
    
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    // 회원가입 폼 --> ok
    @GetMapping("/register")
    public String showRegForm(Model model) {
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("64")
    			.pagePath("page/1-member/regForm.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	model.addAttribute("apiKey", apiKey);
    	
    	return "layout";
    }
    
    // 회원 등록 처리 --> ok
    @PostMapping
    public String insertMember(@ModelAttribute Member member, 
    						   RedirectAttributes redirectAttributes) {
    	
    	try {
    		memberService.insertMember(member); // 회원 등록
    		// emailService.sendRegister(member); // 메일 보내기
    	
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", "회원가입 실패");
    		redirectAttributes.addFlashAttribute("member", member); // 입력 내용 반환
    		
    		return "redirect:/public/members/register"; // 실패: 회원 가입 폼으로 이동
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
    	redirectAttributes.addFlashAttribute("alertMessage", "회원가입 성공");
    	
    	return "redirect:/public/auth/login"; // 성공: 로그인 폼으로 이동
    }
    
    // 아이디 찾기 폼
    @GetMapping("/check")
    public String showMemberCheck(Model model) {
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("62")
    			.pagePath("page/1-member/memberCheck.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
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

    // 아이디 찾기 + 이메일 보내기
    @PostMapping("/check")
    public String checkMember(@ModelAttribute Member member,
    						  RedirectAttributes redirectAttributes) {
		
    	try {
    		Member memberResult = memberService.getMemberByEmail(member.getEmail());
    		
    		if (memberResult == null) {
    			throw new IllegalArgumentException("회원 정보가 존재하지 않습니다.");
    		}
    		
    		if (!memberResult.getMobile().equals(member.getMobile())) {
    			throw new IllegalArgumentException("회원 정보가 일치하지 않습니다.");
    		}
    		
    		//emailService.sendUsername(member);
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", "아이디 찾기 실패");
    		
    		return "redirect:/public/members/check"; // 실패: 아이디 찾기 페이지로
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
		redirectAttributes.addFlashAttribute("alertMessage", "아이디 찾기 성공. 메일 확인 바랍니다.");
		
		return "redirect:/public/auth/login"; // 성공: 로그인 페이지로
    }
    
    
    // 비밀번호 재발급 + 이메일 보내기
    @PostMapping("/repass")
    public String resetPassword(@ModelAttribute Member member,
			  					RedirectAttributes redirectAttributes) {
    	
    	try {
    		Member memberResult = memberService.getMemberByUsername(member.getUsername());
    		
    		if (memberResult == null) {
    			throw new IllegalArgumentException("회원 정보가 존재하지 않습니다.");
    		}
    		
    		if (!memberResult.getEmail().equals(member.getEmail())) {
    			throw new IllegalArgumentException("회원 정보가 일치하지 않습니다.");
    		}
    		
    		if (!memberResult.getMobile().equals(member.getMobile())) {
    			throw new IllegalArgumentException("회원 정보가 일치하지 않습니다.");
    		}
    		
    		//String repass = memberService.resetPassword(member);
    		//emailService.sendResetPassword(member, repass);
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", "비밀번호 재발급 실패");
    		
    		return "redirect:/public/members/repass"; // 실패: 비밀번호 재발급 페이지로
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
		redirectAttributes.addFlashAttribute("alertMessage", "비밀번호 재발급 성공. 메일 확인 바랍니다.");
		
		return "redirect:/public/auth/login"; // 성공: 로그인 페이지로
    }

}