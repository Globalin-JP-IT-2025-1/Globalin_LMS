package com.library.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.library.model.Reply;
import com.library.service.ArticleService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class ArticleReplyCountAspect {
	
	@Autowired
	private ArticleService articleService;

    // 댓글 등록 시 --> ok
    @After("execution(* com.library.service.impl.ReplyServiceImpl.insertReply(..))")
    public void increaseReplyCountAfterInsertReply(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	Reply reply = (Reply) args[0];

    	log.info("작성자id:" + reply.getAuthorId() + ", "
    			+ "댓글 내용: " + reply.getContent() + "- ArticleReplyCountAspect");

    	if (reply != null) {
    	    articleService.updateArticleReplyCountUp(reply.getOriginArticleId());
    	}
    	
    }
    
    // 댓글 삭제 시 (hard delete 시) 
    @After("execution(* com.library.service.impl.ReplyServiceImpl.deleteReply(..))")
    public void decreaseReplyCountAfterDeleteReply(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	int articlesId = (int) args[0];
    	
    	System.out.println("삭제 대상 댓글 id:" + articlesId + "- ArticleReplyCountAspect");

    	if (articlesId > 0) {
    	    articleService.updateArticleReplyCountDown(articlesId);
    	}
    	
    }
    
}

