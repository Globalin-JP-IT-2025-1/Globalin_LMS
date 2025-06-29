package com.library.service;

import com.library.model.book.BookReview;
import com.library.model.book.ReviewListResponse;

public interface ReviewService {
	
	// 조회
	// 1) 목록 조회 (도서 ID 기반)
	public ReviewListResponse getReviewListByBooksId(int booksId, int reviewCurrentPage);
	
	// 1) 목록 개수 (도서 ID 기반)
	public int getReviewListCount(int booksId);
    
    // 수정
    // 1) 비공개 (soft delete)
    public int updateReviewDisable(int bookReviewsId);

    // 2) 공개
    public int updateReviewEnable(int bookReviewsId);
    
    // 3) 비밀
    public int updateReviewSecret(int bookReviewsId);
    
    // 추가
    public int insertReview(BookReview bookReview);

    // 삭제 (hard delete)
    public int deleteReview(int booksId, int bookReviewsId);
    
}