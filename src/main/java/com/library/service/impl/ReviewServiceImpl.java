package com.library.service.impl;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.ReviewMapper;
import com.library.model.book.BookReview;
import com.library.model.book.ReviewListRequest;
import com.library.model.book.ReviewListResponse;
import com.library.model.book.ReviewWithAuthor;
import com.library.service.ReviewService;

import lombok.RequiredArgsConstructor;

@Service("ReviewService")
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {
	private final ReviewMapper reviewMapper;
	
	private static final int REVIEWS_PER_PAGE = 10; // 한 페이지당 댓글 수
	
	// 조회
	// 1) 리뷰 목록 조회 (도서 ID 기반)
	@Override
	public ReviewListResponse getReviewListByBooksId(int booksId, int reviewCurrentPage) {
		
		int totalCount = getReviewListCount(booksId);
        int totalPage = (int) Math.ceil((double) totalCount / REVIEWS_PER_PAGE);
        int startRow = (reviewCurrentPage - 1) * REVIEWS_PER_PAGE;
        int endRow = reviewCurrentPage * REVIEWS_PER_PAGE;
        
        List<ReviewWithAuthor> reviewList = reviewMapper.getReviewListByBooksId(ReviewListRequest.builder()
				.booksId(booksId)
				.startRow(startRow)
				.endRow(endRow)
				.build());
        
		return ReviewListResponse.builder()
				.reviewList(reviewList)
				.totalCount(totalCount)
				.totalPages(totalPage)
				.build();
	}
	
	// 2) 리뷰 수 (도서 ID 기반)
	public int getReviewListCount(int booksId) {
		return reviewMapper.getReviewListCount(booksId);
	}
	
	
    // 수정
    // 1) 비공개 (soft delete)
	@Override
    public int updateReviewDisable(int bookReviewsId) {
        return reviewMapper.updateReviewDisable(bookReviewsId);
    }

    // 2) 공개
	@Override
    public int updateReviewEnable(int bookReviewsId) {
        return reviewMapper.updateReviewEnable(bookReviewsId);
    }
    
    // 3) 비밀
	@Override
    public int updateReviewSecret(int bookReviewsId) {
    	return reviewMapper.updateReviewSecret(bookReviewsId);
    }
	
	// 추가
	@Override
    public int insertReview(BookReview bookReview) {
		// 오늘 날짜 설정
		LocalDateTime currentDate = LocalDateTime.now();
		Timestamp currentDateTS = Timestamp.valueOf(currentDate);
		
		bookReview.setCreateDate(currentDateTS);
		bookReview.setUpdateDate(currentDateTS);
		bookReview.setStatus(0);
		
        return reviewMapper.insertReview(bookReview);
    }

    // 삭제 (hard delete)
	// aop를 위해 파라미터에 booksId 추가. 실제로 사용은 안 함.
	@Override
    public int deleteReview(int booksId, int bookReviewsId) {
        return reviewMapper.deleteReview(bookReviewsId);
    }
    
}