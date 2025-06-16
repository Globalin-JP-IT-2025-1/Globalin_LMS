package com.library.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.library.model.BlacklistedToken;
import com.library.model.PageInfo;
import com.library.service.BlacklistedTokenService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/tokens")
@AllArgsConstructor
public class AdminTokenController {
    private final BlacklistedTokenService tokenBlacklistService;
    private PageInfo pageInfo;
    
    public void setPageInfo(Model model) {
    	model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
    	model.addAttribute("pagePath", pageInfo.getPagePath());
    }
    
    // 차단된 토큰 목록 조회
    @GetMapping
    public String getAllBlacklistedTokens(Model model) {
    	List<BlacklistedToken> blackList = tokenBlacklistService.getAllBlacklistedTokens();
        
    	model.addAttribute("blackList", blackList);

    	pageInfo = PageInfo.builder()
			.pageTitleCode("94")
			.pagePath("page/9-admin/blacklistedTokenList.jsp")
			.build();
    	
    	model.addAttribute("alertType", "success");
    	model.addAttribute("alertMessage", "차단된 토큰 목록 조회를 완료하였습니다.");
    	
    	setPageInfo(model);
    	
        return "layout";
    }

}