package com.library.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.library.dto.PageInfo;
import com.library.service.AuthService;
import com.library.service.RefreshTokenService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@CrossOrigin(origins = "*")
public class AuthController {
	private PageInfo pageInfo;
	private final AuthService authService;
	private final RefreshTokenService refreshTokenService;
    
	public void setPageInfo(Model model) {
		model.addAttribute("pageTitleCode", pageInfo.getPageTitleCode());
		model.addAttribute("pagePath", pageInfo.getPagePath());
	}
	
	// 로그인 폼
    @GetMapping("/public/auth/login")
    public String showLoginForm(Model model) {
    	System.out.println("✅ AuthController - /login - GET 요청 정상 처리!");
    	
    	pageInfo = PageInfo.builder()
    			.pageTitleCode("61")
    			.pagePath("page/loginForm.jsp")
    			.build();
    	
    	setPageInfo(model);
        
        return "layout";
    }
	
    // 로그인 처리
    @PostMapping("/public/auth/login")
    public ResponseEntity<Void> loginProc(@RequestBody Map<String, String> requestData, HttpServletRequest request, HttpServletResponse response) {
    	System.out.println("✅ AuthController - /login - POST 요청 정상 처리!");
    	
    	// DB 로그인 검증
    	int membersId = authService.verifyMemberDB(requestData.get("username"), requestData.get("password"));
    	if (membersId < 0) {
    		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    	}
    	
    	// 토큰 관리 처리
    	try {
    		// 액세스 토큰 & 리프레시 토큰 발급
    		Map<String, String> tokens = authService.generateTokens(String.valueOf(membersId));
    		
    		// 액세스 토큰: 쿠키에 저장
    		Cookie cookie = new Cookie("aToken", tokens.get("aToken"));
            cookie.setHttpOnly(true); // JavaScript 접근 불가 (XSS 방지)
            cookie.setSecure(true); // HTTPS에서만 쿠키 전송 (보안 강화)
            cookie.setPath("/"); // 전체 도메인에서 쿠키 사용 가능
            cookie.setMaxAge(600); // 쿠키 유효기간: 10분 (초 단위)
            response.addCookie(cookie);
    		
         // 리프레시 토큰: DB에 저장
            if (refreshTokenService.insertRefreshToken(membersId, tokens.get("rToken")) < 0) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
            }
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    	}
    	
    	return ResponseEntity.ok().build();
    }
    
    // 로그아웃 처리
    @PostMapping("/private/auth/logout/{membersId}")
    public ResponseEntity<Void> logoutProc(@PathVariable("membersId") String membersId) {
    	System.out.println("✅ AuthController - /logout - POST 요청 정상 처리!");
    	
    	// 액세스 토큰: 쿠키에서 가져온 후 삭제
    	// 리프레시 토큰: DB에서 가져온 후 삭제
    	// 블랙리스트에 저장
    	
    	int result = 0;
    	
    	if (result == -1) {
    		return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); // 404 반환
    	}
        
    	return ResponseEntity.ok().build(); // 성공 시 200 반환
    }

}
