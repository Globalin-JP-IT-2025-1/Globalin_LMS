package com.library.security;

import java.security.Key;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.library.model.Member;
import com.library.service.BlacklistedTokenService;
import com.library.service.MemberService;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

// JWT 생성 및 검증
@Component
public class JwtUtil {
	private static final Logger logger = LoggerFactory.getLogger(JwtUtil.class);
	
	private final long ACCESS_EXPIRATION_TIME = 600000; // 10분
	private final long REFRESH_EXPIRATION_TIME = 604800000; // 7일
	
	@Value("${jwt.secret}")
    private String secretKey;
    private Key key;
    
    private MemberService memberService;
    private BlacklistedTokenService blacklistedTokenService;
    
    // 초기 설정
    @PostConstruct
    public void init() {
        byte[] decodedKey = Base64.getDecoder().decode(secretKey); // Base64 디코딩
        
        if (decodedKey.length != 32) {
            throw new IllegalArgumentException("JWT Secret Key must be exactly 32 bytes (256 bits).");
        }
        this.key = Keys.hmacShaKeyFor(decodedKey);
    }	

	// JWT 생성
	public Map<String, String> generateTokens(String username, String name, String membersId) {
		Map<String, String> tokens = new HashMap<>();
		
		String accessToken = Jwts.builder()
				.setSubject(username)
				.claim("name", name)
	            .claim("membersId", membersId)
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + ACCESS_EXPIRATION_TIME)) // 10분
				.signWith(key, SignatureAlgorithm.HS256).compact();

		String refreshToken = Jwts.builder()
				.setSubject(username)
				.claim("name", name)
	            .claim("membersId", membersId)
				.setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + REFRESH_EXPIRATION_TIME)) // 7일
				.signWith(key, SignatureAlgorithm.HS256).compact();
		
		tokens.put("aToken", accessToken);
		tokens.put("rToken", refreshToken);
		
		return tokens;
	}

	// 토큰 검증
	public boolean isValidToken(String token) {
		// 현재 시간
		LocalDateTime now = LocalDateTime.now();
        Timestamp currentDate = Timestamp.valueOf(now);
		
		try {
			// 무결성 검사 : 시크릿 키를 사용해 토큰을 파싱하고 검증
			Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
			
			Timestamp expiresDate = extractExpiresDate(token);
			
			// 유효시간 검사 : 현재 시간 - 리프레시 토큰 유효기간 < 0
			if ((currentDate.getTime() - expiresDate.getTime()) < 0) {
				return false;
			}
			
			// 해당 회원이 유효한지 (탈퇴 회원(status: 3)이거나 조회되지 않거나)
			int membersId =  extractMembersId(token);
			Member member = memberService.getMemberById(membersId);
			if (member.getStatus() == 3 || member == null) {
				return false;
			}
			
			// 블랙리스트 검사
			int bToken = blacklistedTokenService.getBlacklistedTokenByToken(token);
			if (bToken < 0) {
				return false;
			}
			
			return true; // 검증 성공
			
	    } catch (Exception e) {
	    	logger.error("토큰 검증 실패: {}", e.getMessage());
	        return false; // 검증 실패
	    }
	}

	// 토큰에서 Username 추출
	public String extractUsername(String token) {
		return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
				.getBody().getSubject();
	}
	
	// 토큰에서 ExpiresDate 추출
	public Timestamp extractExpiresDate(String token) {
		Date expiresDate = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
				.getBody().getExpiration();
		
		return new Timestamp(expiresDate.getTime());
	}
	
	// 토큰에서 name 추출
	public String extractName(String token) {
		return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
				.getBody().get("name", String.class);
	}
	
	// 토큰에서 membersId 추출
	public int extractMembersId(String token) {
		try {
	        String membersId = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
	                .getBody().get("membersId", String.class);
	        
	        return Integer.parseInt(membersId);
	        
	    } catch (Exception e) {
	    	logger.error("membersId를 추출하는 중 오류 발생: {}", e.getMessage());
	        return -1; // 오류 발생 시 기본값 반환
	    }
	}

}
