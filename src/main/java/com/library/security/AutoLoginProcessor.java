package com.library.security;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.library.model.Member;
import com.library.model.MemberStatus;
import com.library.service.JwtService;
import com.library.service.MemberService;
import com.library.service.RefreshTokenService;

@Component
public class AutoLoginProcessor {
	private JwtService jwtService;
	private RefreshTokenService refreshTokenService;
	private MemberService memberService;
	private CustomUserDetailsService userDetailsService;
	
	public boolean tryAutoLogin(HttpServletRequest request, HttpServletResponse response) {
		// 쿠키에서 토큰 추출
		String aToken = getCookieValue(request.getCookies(), "aToken");
		String rToken = getCookieValue(request.getCookies(), "rToken");

		// aToken이 유효한 경우
		if (aToken != null && jwtService.isValidToken(aToken)) {
			return authenticateMember(aToken);
		}

		// rToken이 유효한 경우: 토큰 재발급 및 쿠키 업데이트
		if (rToken != null && jwtService.isValidToken(rToken)) {
			String username = jwtService.getUsername(rToken);
			Member member = memberService.getMemberByUsername(username);

			if (member == null) {
				return false;
			}

			jwtService.insertBlacklistedToken(rToken, 1);

			Map<String, String> tokens = jwtService.generateTokens(username);
			String newAToken = tokens.get("aToken");
			String newRToken = tokens.get("rToken");

			addCookie(response, "aToken", newAToken, SecurityConstants.ACCESS_EXPIRATION_TIME); // 30분
			addCookie(response, "rToken", newRToken, SecurityConstants.REFRESH_EXPIRATION_TIME); // 15일

			refreshTokenService.insertRefreshToken(member.getMembersId(), newRToken);

			return authenticateMember(newAToken);
		}

		return false;
	}

	// 특정 이름의 쿠키 값 가져오기
	private String getCookieValue(Cookie[] cookies, String name) {
		if (cookies == null)
			return null;
		for (Cookie cookie : cookies) {
			if (name.equals(cookie.getName())) {
				return cookie.getValue();
			}
		}
		return null;
	}

	// 쿠키 생성 및 응답에 추가
	private void addCookie(HttpServletResponse response, String name, String value, int maxAge) {
		Cookie cookie = new Cookie(name, value);
		cookie.setMaxAge(maxAge);
		cookie.setHttpOnly(true);
		cookie.setSecure(true);
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	// 사용자 인증 처리
	private boolean authenticateMember(String token) {
		String username = jwtService.getUsername(token);
		Member member = memberService.getMemberByUsername(username);

		if (member == null)
			return false;

		int status = member.getStatus();
		if (isAutoLoginStatus(status)) {
			UserDetails user = userDetailsService.loadUserByUsername(username);
			Authentication auth = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(auth);
			return true;
		}

		return false;
	}

	// 자동 로그인 허용 상태인지 여부
	private boolean isAutoLoginStatus(int status) {
		return status == MemberStatus.NON_REGULER_MEM_AUTO.getCode()
				|| status == MemberStatus.REGULER_MEM_AUTO.getCode() || status == MemberStatus.SUSPENDED_AUTO.getCode()
				|| status == MemberStatus.ADMIN_AUTO.getCode();
	}


}
