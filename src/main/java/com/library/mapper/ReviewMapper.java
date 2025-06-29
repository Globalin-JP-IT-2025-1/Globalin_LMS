package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.book.BookReview;
import com.library.model.book.ReviewListRequest;
import com.library.model.book.ReviewWithAuthor;

@Mapper
public interface ReviewMapper {
	
	// 조회
	// 1) 목록 조회 (도서 ID 기반)
	public List<ReviewWithAuthor> getReviewListByBooksId(ReviewListRequest reviewListRequest);
	
	// 2) 리뷰 수 (도서 ID 기반)
	public int getReviewListCount(int booksId);

	// 리뷰 수정
	// 1) 비공개 (soft delete)
	public int updateReviewDisable(int bookReviewsId);
	
    // 2) 공개
	public int updateReviewEnable(int bookReviewsId);
	
    // 3) 비밀
	public int updateReviewSecret(int bookReviewsId);
	
	// 등록
	public int insertReview(BookReview bookReview);
	
	// 삭제
	public int deleteReview(int bookReviewsId);
	
}
