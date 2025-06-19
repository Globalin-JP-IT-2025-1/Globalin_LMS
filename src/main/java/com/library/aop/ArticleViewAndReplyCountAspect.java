package com.library.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.library.model.Reply;
import com.library.service.ArticleService;

import lombok.RequiredArgsConstructor;

@Aspect
@Component
@RequiredArgsConstructor
public class ArticleViewAndReplyCountAspect {
	
	@Autowired
	private ArticleService articleService;

    // 게시글 상세 조회 시 --> ok
    @After("execution(* com.library.service.impl.ArticleServiceImpl.getArticleWithAuthorAndReplies(..))")
    public void increaseViewCountAfterGetArticleDetail(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	int articlesId = (int) args[0];
    	
    	if (articlesId > 1) {
    	    articleService.updateArticleViewCountUp(articlesId);
    	}

    }

    // 댓글 등록 시 --> ok
    @After("execution(* com.library.service.impl.ReplyServiceImpl.insertReply(..))")
    public void increaseReplyCountAfterInsertReply(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	Reply reply = (Reply) args[0];

    	System.out.println("작성자id:" + reply.getAuthorId() + 
    					   ", 댓글 내용: " + reply.getContent() + "- ArticleViewAndReplyCountAspect");

    	if (reply != null) {
    	    articleService.updateArticleReplyCountUp(reply.getOriginArticleId());
    	}
    	
    }
    
    // 댓글 비활성화 시 (soft delete 시) 
    @After("execution(* com.library.service.impl.ReplyServiceImpl.updateReplyDisable(..))")
    public void decreaseReplyCountAfterDeleteReply(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	int articlesId = (int) args[0];

    	if (articlesId > 1) {
    	    articleService.updateArticleReplyCountDown(articlesId);
    	}
    	
    }
    
}

