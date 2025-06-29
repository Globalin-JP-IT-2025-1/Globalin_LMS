package com.library.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.library.model.book.BookReview;
import com.library.service.BookService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class ReviewCountAspect {
	
	@Autowired
	private BookService bookService;

    // 북 리뷰 등록 시
    @After("execution(* com.library.service.impl.ReviewServiceImpl.insertReview(..))")
    public void increaseReviewCount(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	BookReview bookReview = (BookReview) args[0];

    	log.info("작성자id:" + bookReview.getAuthorId() + ", "
    			+ "리뷰 내용: " + bookReview.getContent() + "- ReviewCountAspect");

    	if (bookReview != null) {
    		bookService.updateBookReviewCountUp(bookReview.getBooksId());
    	}
    	
    }
    
    // 북 리뷰 삭제 시 (hard delete 시) 
    @After("execution(* com.library.service.impl.ReviewServiceImpl.deleteReview(..))")
    public void decreaseReviewCount(JoinPoint joinPoint) {
    	Object[] args = joinPoint.getArgs();
    	int booksId = (int) args[0];
    	
    	log.info("삭제 대상 리뷰 id:" + booksId + "- ReviewCountAspect");

    	if (booksId > 0) {
    		bookService.updateBookReviewCountDown(booksId);
    	}
    	
    }

}
