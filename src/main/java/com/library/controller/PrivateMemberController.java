package com.library.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.dto.Member;
import com.library.dto.PageInfo;
import com.library.dto.RefreshToken;
import com.library.service.MemberService;
import com.library.service.RefreshTokenService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/private/members")
@AllArgsConstructor
public class PrivateMemberController {
    private final MemberService memberService;
    private final RefreshTokenService refreshTokenService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
 
    // 회원 정보 조회 --> OK
	/* @PreAuthorize("hasRole('ADMIN') or @memberService.canAccess(#membersId)") */
    @GetMapping("/{membersId}")
    public String getMemberById(@PathVariable("membersId") int membersId, Model model) {
    	Member member = memberService.getMemberById(membersId);
        
    	model.addAttribute("member", member);

    	pageInfo = PageInfo.builder()
			.pageTitleCode("31")
			.pagePath("page/memberDetail.jsp")
			.build();
    	
    	model.addAttribute("alertType", "success");
    	model.addAttribute("alertMessage", "" + member.getName() + " 님의 상세 정보 조회를 완료하였습니다.");
    	
    	setPageInfo(model);
    	
        return "layout";
    }
    
    // 회원 정보 수정 폼으로 이동 --> OK
    @GetMapping("/{membersId}/edit")
    public String showEditMemberInfo(@PathVariable("membersId") int membersId, Model model) {
    	Member member = memberService.getMemberById(membersId);
    	
    	model.addAttribute("member", member);
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("31")
    			.pagePath("page/editForm_member.jsp")
    			.build();
    	
    	setPageInfo(model);
    	
    	return "layout";
    }

    // 회원 정보 수정 --> OK
    @PutMapping("/{membersId}")
    public ResponseEntity<Void> updateMemberInfo(@PathVariable("membersId") int membersId, @RequestBody Map<String, String> requestData) {
    	Member member = memberService.getMemberById(membersId);
    	
    	if (member == null) {
    		return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // 404 반환 (회원 없음)
    	}
    	
    	member.setPassword(requestData.get("password"));
    	member.setMobile(requestData.get("mobile"));
    	member.setZipcode(requestData.get("zipcode"));
    	member.setAddress(requestData.get("address"));
    	
    	int result = memberService.updateMemberInfo(member);
    	
    	if (result == -1) {
        	return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 실패 시 400 반환
    	}
    	
    	return ResponseEntity.ok().build(); // 성공 시 200 반환
    }
 
    // 회원 탈퇴 처리
    @PatchMapping("/{membersId}/leave")
    public ResponseEntity<Void> leaveMember(@PathVariable("membersId") int membersId, HttpServletRequest request) {
    	Map<String, String> tokens = new HashMap<>();
    	
    	// 세션에서 access token 가져온 후 삭제
    	HttpSession session = request.getSession();
    	if (session != null) {
    		tokens.put("aToken", (String)session.getAttribute("aToken"));
    		session.removeAttribute("aToken");
    	}
    	
    	// DB에서 refresh token 가져온 후 삭제
    	RefreshToken rToken = refreshTokenService.getRefreshTokenByMembersId(membersId);
    	tokens.put("rToken", rToken.getRefreshToken());
    	
    	// 회원 정보 수정 + 토큰 세트 블랙리스트에 저장
    	int result = memberService.updateMemberLeave(membersId, tokens);
    	
    	if (result == -1) {
    		return ResponseEntity.status(HttpStatus.BAD_REQUEST).build(); // 실패 시 400 반환
    	}
    	
    	return ResponseEntity.ok().build(); // 성공 시 200 반환
    }
    
    
}