package com.library.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class LoggingAdvice {
	
	@Pointcut("execution(* com.library.service.memberService*.*(..))")
    private void cut(){}
	
	@Before("cut()")
    public void logBefore() {
    	System.out.println("memberService!! - LoggingAspect");
    	
		log.info("=============컨트롤러 실행======================");
        
    }
}

