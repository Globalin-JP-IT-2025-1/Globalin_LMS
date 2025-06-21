package com.library.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lang/{lang}")
@AllArgsConstructor
public class LangController {
	
	@GetMapping
	public String setLanguage(@PathVariable("lang") String lang, 
							  HttpServletRequest request, 
							  Model model) {
    	log.info("### {} - {} - {} 요청 매핑 정상 처리!", 
				this.getClass().getSimpleName(), 
				request.getRequestURI(),
				request.getMethod());
    	
    	Locale locale;
    	if ("en".equals(lang)) {
    	    locale = Locale.ENGLISH;
    	} else if ("jp".equals(lang) || "ja".equals(lang)) {
    	    locale = Locale.JAPANESE;
    	} else {
    	    locale = Locale.KOREAN;
    	}
    	
	    request.getSession().setAttribute(
	            SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, locale
	        );
        return "redirect:" + request.getHeader("Referer"); // 이전 페이지로 돌아감
    	
	}

}
