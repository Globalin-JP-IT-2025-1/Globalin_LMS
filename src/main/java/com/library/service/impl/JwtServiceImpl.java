package com.library.service.impl;

import java.security.Key;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import com.library.model.Member;
import com.library.service.BlacklistedTokenService;
import com.library.service.JwtService;
import com.library.service.MemberService;
import com.library.service.RefreshTokenService;
import com.library.util.JwtUtil;

import io.jsonwebtoken.Jwts;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("jwtService")
@AllArgsConstructor
public class JwtServiceImpl implements JwtService {
	private final JwtUtil jwtUtil;
	private final BlacklistedTokenService blacklistedTokenService;
	private final RefreshTokenService refreshTokenService;
	private final MemberService memberService;
    
	@Value("${jwt.secret}")
    private String secretKey;
    private Key key;
	
    // 토큰 검증 (무결성, 유효시간, 회원 존재 여부, 블랙리스트)
	@Override
    public boolean isValidToken(String token) {
		// 현재 시간
		LocalDateTime now = LocalDateTime.now();
        Timestamp currentDate = Timestamp.valueOf(now);
		
		try {
			Timestamp expiresDate = jwtUtil.extractExpiresDate(token);
			
			// 1) 유효시간 검사
			if (currentDate.getTime() > expiresDate.getTime()) {
				return false;
			}
			
			// 2) 무결성 검사 : 시크릿 키를 사용해 토큰을 파싱하고 검증
			if (Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token) == null) {
				return false;
			}
			
			// 3) 블랙리스트 검사
			if (blacklistedTokenService.isBlacklistedToken(token)) {
				return false;
			}
			
			// 4) 해당 회원이 유효한지 (탈퇴 회원(status: 3)이거나 조회되지 않거나)
			String username = jwtUtil.extractUsername(token);
			Member member = memberService.getMemberByUsername(username);
			if (member.getStatus() == 3 || member == null) {
				return false;
			}
			
			return true; // 검증 성공
			
	    } catch (Exception e) {
	    	log.error("토큰 검증 실패: {}", e.getMessage());
	        return false; // 검증 실패
	    }
		
    }
    
    // 액세스 토큰 발급 & 리프레시 토큰 발급
	@Override
    public Map<String, String> generateTokens(String username) {
    	return jwtUtil.generateTokens(username);
    }
    
    // 액세스 토큰 유효성 검사 후 유효한 경우 블랙리스트에 올리기 (로그아웃 성공 시 or 탈퇴 시)
	@Override
    public void insertBlacklistedToken(String token, int type) {
    	blacklistedTokenService.insertBlacklistedToken(token, 0);
    }
    
    // DB 리프레시 토큰 삭제 요청 (
	@Override
	public void deleteRefreshTokens(int membersId) {
		refreshTokenService.deleteRefreshToken(membersId);
	}
	
	// 인증 객체 얻기
	@Override
	public Authentication getAuthentication(String token) {
	    // 1) 아이디 추출
	    String username = jwtUtil.extractUsername(token);

	    // 2) 권한 추출
	    Collection<? extends GrantedAuthority> authorities = jwtUtil.extractRoles(token);

	    // 3) 인증 객체 생성 (비밀번호는 null로 처리)
	    return new UsernamePasswordAuthenticationToken(username, null, authorities);
	}
	
	// username 얻기
	@Override
	public String getUsername(String token) {
		//
		
		return null;
	}

    
    // DB 로그인 검증 --> Spring Security 로 이전

}
