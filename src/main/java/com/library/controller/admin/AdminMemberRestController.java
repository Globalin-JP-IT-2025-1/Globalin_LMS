package com.library.controller.admin;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.library.model.PageInfo;
import com.library.model.member.CardNumberRequest;
import com.library.service.CardNumberService;
import com.library.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/admin/members")
@AllArgsConstructor
public class AdminMemberRestController {
    private final MemberService memberService;
    private final CardNumberService cardnumberService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }

    // 회원 등급 + 카드번호 갱신
    @PutMapping("/{membersId}/upgrade")
    public ResponseEntity<String> updateMemberGrade(@PathVariable int membersId,
								             		@PathVariable int status,
								             		@RequestBody CardNumberRequest request) {
        try {
            memberService.updateMemberCardnum(membersId, request.getCardNum());
            return ResponseEntity.ok("회원 정보 갱신 성공");
        } catch (Exception e) {
            log.error("회원 정보 갱신 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("회원 정보 갱신 실패");
        }
    }
    
    // 회원카드 발급
    @GetMapping("/cardnumber")
    public ResponseEntity<String> generateCardNumber() {
        String cardnum = cardnumberService.generateCardNumber();
        if (cardnum == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("카드번호 생성 실패");
        }
        return ResponseEntity.ok(cardnum);
    }

}