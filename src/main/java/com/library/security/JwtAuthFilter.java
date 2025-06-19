//package com.library.security;
//
//import java.io.IOException;
//
//import javax.servlet.FilterChain;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.stereotype.Component;
//import org.springframework.util.ObjectUtils;
//import org.springframework.util.StringUtils;
//import org.springframework.web.filter.OncePerRequestFilter;
//
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//
//// JWT 인증 필터
//@Slf4j
//@Component
//@RequiredArgsConstructor
//public class JwtAuthFilter extends OncePerRequestFilter {
//
//	// JWT의 생성, 해독, 변환 등을 담당
//    private final JwtProvider jwtProvider;
//
//    @Override
//    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
//        FilterChain filterChain) throws ServletException, IOException {
//
//        // 헤더에서 토큰 부분을 분리
//        String token = resolveTokenFromRequest(request);
//
//        // 토큰 유효성 검증
//        if(StringUtils.hasText(token) && jwtProvider.validateToken(token)){
//            // Authentication 객체 받아오기
//            Authentication auth = jwtProvider.getAuthentication(token);
//            // SecurityContextHoler에 저장
//            SecurityContextHolder.getContext().setAuthentication(auth);
//        }
//
//        filterChain.doFilter(request, response);
//    }
//    
//    private String resolveTokenFromRequest(HttpServletRequest request){
//        // 헤더에서 토큰 부분을 분리
//        String token = request.getHeader(SecurityConstants.TOKEN_HEADER); // "Authorization"
//
//        // 해당 키에 해당하는 헤더가 존재하고, 그 값이 Bearer로 시작한다면 (즉 JWT가 있다면)
//        if(!ObjectUtils.isEmpty(token) && token.startsWith(SecurityConstants.TOKEN_PREFIX)) { // "Bearer "
//            // PREFIX 부분을 날리고 JWT만 token에 할당함.
//            return token.substring(SecurityConstants.TOKEN_PREFIX.length());
//        }
//        
//        return null;
//    }
//}
