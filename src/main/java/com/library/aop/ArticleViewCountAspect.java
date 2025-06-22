package com.library.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.library.service.ArticleService;

import lombok.RequiredArgsConstructor;

@Aspect
@Component
@RequiredArgsConstructor
public class ArticleViewCountAspect {
	
	@Autowired
	private ArticleService articleService;

    // 게시글 상세 조회 시 --> ok
    @After("execution(* com.library.service.impl.ArticleServiceImpl.getArticleWithReplyList(..))")
    public void increaseViewCountAfterGetArticleDetail(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	int articlesId = (int) args[0];
    	
    	if (articlesId > 0) {
    	    articleService.updateArticleViewCountUp(articlesId);
    	}

    }
    
}

