package com.library.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.model.PageInfo;
import com.library.service.CardNumberService;
import com.library.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/members")
@AllArgsConstructor
public class AdminMemberController2 {
    private final MemberService memberService;
    private final CardNumberService cardnumberService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    // 회원 등급 + 카드번호 갱신
    @PutMapping("/admin/members/{memberId}/upgrade")
    public String upgradeMemberGrade(@PathVariable int membersId,
                                     @RequestParam String cardNo,
                                     RedirectAttributes redirectAttributes) {
        try {
            memberService.updateMemberCardnum(membersId, cardNo);
            
            redirectAttributes.addFlashAttribute("alertType", "success");
            redirectAttributes.addFlashAttribute("alertMessage", "회원 등급이 성공적으로 변경되었습니다.");
            
        } catch (Exception e) {
        	redirectAttributes.addFlashAttribute("alertType", "error");
            redirectAttributes.addFlashAttribute("alertMessage", "등급 변경 중 오류가 발생했습니다.");
        }
        
        return "redirect:/admin/members";
    }


    
    // 회원카드 발급
//    @GetMapping("/cardnumber")
//    public ResponseEntity<String> generateCardNumber() {
//        String cardnum = cardnumberService.generateCardNumber();
//        if (cardnum == null) {
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("카드번호 생성 실패");
//        }
//        return ResponseEntity.ok(cardnum);
//    }

}