package com.library.controller.admin;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.Member;
import com.library.model.PageInfo;
import com.library.service.CardNumberService;
import com.library.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/members")
@AllArgsConstructor
public class AdminMemberController {
    private final MemberService memberService;
    private final CardNumberService cardnumberService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 회원 목록 조회 --> ok
    @GetMapping
    public String getAllMembers(Model model) {
    	
    	List<Member> memberList = memberService.getAllMembers();
    	model.addAttribute("memberList", memberList);

    	pageInfo = PageInfo.builder()
			.pageTitleCode("91")
			.pagePath("page/9-admin/memberList.jsp")
			.build();
    	
    	model.addAttribute("alertType", "success");
    	model.addAttribute("alertMessage", "회원 목록 조회 완료");
    	
    	setPageInfo(model);
    	
        return "layout";
    }

    // 회원 등급 수정 --> 진행중
    @PutMapping("/{membersId}/{status}/{cardNumber}")
    public String updateMemberGrade(@PathVariable("membersId") int membersId,
    								@PathVariable("status") int status,
    								@PathVariable("cardNumber") String cardNumber,
    								RedirectAttributes redirectAttributes) {
    	
    	try {
    		memberService.updateMemberCardnum(membersId, cardNumber);
    		System.out.println(membersId + ", " + cardNumber); // 디버깅용
    	} catch (Exception e) {
    		e.printStackTrace();
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", "[회원 등급] 수정 실패");
    		
    		return "redirect:/admin/members"; // 실패: 회원 목록으로
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
		redirectAttributes.addFlashAttribute("alertMessage", "[회원 등급] 수정 성공");
		
		return "redirect:/admin/members"; // 성공: 회원 목록으로
    }
    
    
    // 회원카드 발급 --> 진행중
    @GetMapping("/cardnumber")
    public ResponseEntity<String> generateMemberGrade() {
    	
        String cardnum = cardnumberService.generateCardNumber();
        
        if (cardnum == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }

        return ResponseEntity.ok().build();
    }

    
    // 회원 삭제
    @DeleteMapping("/{membersId}")
    public String deleteMember(@PathVariable("membersId") int membersId,
    						   RedirectAttributes redirectAttributes) {

        try {
    		memberService.deleteMember(membersId);
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		redirectAttributes.addFlashAttribute("alertType", "fail");
    		redirectAttributes.addFlashAttribute("alertMessage", "[회원] 삭제 실패");
    		
    		return "redirect:/admin/members"; // 실패: 회원 목록으로
    	}
    	
    	redirectAttributes.addFlashAttribute("alertType", "success");
		redirectAttributes.addFlashAttribute("alertMessage", "[회원] 삭제 성공");
		
		return "redirect:/admin/members"; // 성공: 회원 목록으로
    }



}