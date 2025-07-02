package com.library.controller.member;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;
import com.library.model.member.Member;
import com.library.model.validation.OnRegister;
import com.library.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/public/members")
@RequiredArgsConstructor
@PropertySource("classpath:application.properties")
public class PublicMemberController {
    private final MemberService memberService;
    
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
    public String insertMember(@Validated(OnRegister.class) @ModelAttribute Member member, 
							   BindingResult result,
    						   RedirectAttributes redirectAttributes) {
    	
    	if (result.hasErrors()) {
            return "redirect:/public/members/register"; // 유효성 실패: 회원 가입 폼으로 이동
        }
    	
    	try {
    		memberService.insertMember(member); // 회원 등록
    	
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

    // 아이디 찾기 + 알림 띄우기
    @PostMapping("/check")
    public String checkMember(@ModelAttribute Member member,
    						  RedirectAttributes redirectAttributes) {
		
    	String errorMessage = null;
		String usernameResult = null;
    	
    	try {
    		Member memberResult = memberService.getMemberByEmail(member.getEmail());
    		if (memberResult == null) {
    			errorMessage = "회원 정보가 존재하지 않습니다.";
    			throw new Exception(errorMessage);
    		}
    		
    		if (!memberResult.getMobile().equals(member.getMobile())) {
    			errorMessage = "회원 정보가 일치하지 않습니다.";
    			throw new Exception(errorMessage);
    		}
    		
    		usernameResult = memberResult.getUsername();
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", errorMessage);
    		
    		return "redirect:/public/members/check"; // 실패: 아이디 찾기 페이지로
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
		redirectAttributes.addFlashAttribute("alertMessage", "아이디 찾기 성공 하였습니다 : " + usernameResult);
		
		return "redirect:/public/auth/login"; // 성공: 로그인 페이지로
    }
    
    // 비밀번호 재발급 + 임시 비밀번호 알림 띄우기
    @PostMapping("/repass")
    public String resetPassword(@ModelAttribute Member member,
			  					RedirectAttributes redirectAttributes) {
    	
    	String errorMessage = null;
    	String repass = null;
    	
    	try {
    		Member memberResult = memberService.getMemberByUsername(member.getUsername());
    		
    		if (memberResult == null) {
    			errorMessage = "회원 정보가 존재하지 않습니다.";
    			throw new Exception(errorMessage);
    		}
    		
    		if (!memberResult.getEmail().equals(member.getEmail())) {
    			errorMessage = "회원 정보가 일치하지 않습니다.";
    			throw new Exception(errorMessage);
    		}
    		
    		if (!memberResult.getMobile().equals(member.getMobile())) {
    			errorMessage = "회원 정보가 일치하지 않습니다.";
    			throw new Exception(errorMessage);
    		}
    		
    		repass = memberService.resetPassword(memberResult);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", "비밀번호 재설정을 실패 하였습니다 : " + errorMessage);
    		
    		return "redirect:/public/members/repass"; // 실패: 비밀번호 재발급 페이지로
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
		redirectAttributes.addFlashAttribute("alertMessage", "비밀번호 재설정을 완료 하였습니다 : " + repass + "\n로그인 후 재설정 바랍니다.");
		
		return "redirect:/public/auth/login"; // 성공: 로그인 페이지로
    }

}