package com.library.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.library.service.BookService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class BookViewCountAspect {
	
	@Autowired
	private BookService bookService;

    // 책 상세 조회 시
    @After("execution(* com.library.service.impl.BookServiceImpl.getBookById(..))")
    public void increaseViewCountAfterGetArticleDetail(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	int booksId = (int) args[0];
    	
    	log.info("책id:" + booksId + " - BookViewCountAspect");
    	
    	if (booksId > 0) {
    		bookService.updateBookViewCountUp(booksId);
    	}

    }
    
}

