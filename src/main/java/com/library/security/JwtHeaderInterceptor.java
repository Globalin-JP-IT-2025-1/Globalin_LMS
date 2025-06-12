package com.library.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

// JWT 토큰을 HTTP 요청에 자동으로 추가
public class JwtHeaderInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
    	// 특정 URL에서는 JWT 추가하지 않음
//    	String requestURI = request.getRequestURI();
//        if (requestURI.startsWith("/public")) {
//            return true;
//        }
    	
        String aToken = JwtCookieUtil.getJwtFromCookie(request);
        if (aToken != null) {
            request.setAttribute("Authorization", "Bearer " + aToken);
        }
        return true;
    }

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
