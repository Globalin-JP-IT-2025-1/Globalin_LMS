package com.library.controller.admin;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

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
    	model.addAttribute("alertMessage", "회원 목록 조회를 완료하였습니다.");
    	
    	setPageInfo(model);
    	
        return "layout";
    }

    // 정회원으로 회원 등급 수정 --> 진행중
    @PutMapping("/{membersId}/upgrade")
    public ResponseEntity<Void> updateMemberGrade(@PathVariable("membersId") int membersId, @RequestBody Map<String, String> requestData) {
        int result = memberService.updateMemberCardnum(membersId, requestData.get("cardNumber"));
        
        System.out.println(membersId + ", " + result + ", " + requestData.get("cardNumber")); // 디버깅용
        
        if (result == -1) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 400
        }

        return ResponseEntity.ok().build(); // 200
    }
    
    // 회원카드 발급 --> 진행중
    @GetMapping("/cardnumber")
    public ResponseEntity<String> gMemberGrade() {
        String cardnum = cardnumberService.generateCardNumber();
        
        System.out.println(cardnum); // 디버깅용
        
        if (cardnum == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 400
        }

        return ResponseEntity.ok().build(); // 200
    }

    
    // 회원 삭제
    @DeleteMapping("/{membersId}")
    public ResponseEntity<Void> deleteMembers(@PathVariable("membersId") int membersId) {
        int result = memberService.deleteMember(membersId);

        if (result == -1) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 400
        }

        return ResponseEntity.ok().build(); // 200
    }



}