package com.library.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import com.library.service.BlacklistedTokenService;

import lombok.AllArgsConstructor;

@Component
@AllArgsConstructor
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {
	private static final Logger logger = LoggerFactory.getLogger(CustomLogoutSuccessHandler.class);
	private final BlacklistedTokenService blacklistedTokenService;

	// 로그아웃 처리 (액세스 토큰 처리 + 세션 처리)
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		String requestUri = request.getRequestURI();
		String membersId = requestUri.replaceAll(".*/private/auth/logout/", ""); // 경로에서 ID 추출

		logger.info("✅ CustomLogoutHandler - /private/auth/logout/{} - POST 요청 처리!", membersId);

		String baToken = "";

		try {
			// 액세스 토큰: 쿠키에서 가져온 후 저장 후 삭제
			Cookie[] cookies = request.getCookies();
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("aToken")) {
					baToken = cookie.getValue(); // 토큰 저장
				}
				cookie.setMaxAge(0); // 쿠키 만료시간 0 설정
				cookie.setPath("/"); // 같은 path로 설정
				response.addCookie(cookie); // 덮어쓰기
			}

			// 블랙리스트에 저장
			blacklistedTokenService.insertBlacklistedToken(baToken, 0);

			// 세션에서 회원 정보 제거
			HttpSession session = request.getSession(false);

			if (session != null) {
				session.removeAttribute("currentMember"); // 세션에서 제거
				session.invalidate(); // 세션 무효화
				System.out.println("✅ 로그아웃 완료 - 세션 정보 삭제됨!");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("/?logout=true");
		
	}

}
