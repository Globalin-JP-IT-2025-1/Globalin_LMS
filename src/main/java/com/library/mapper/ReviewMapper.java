package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Reply;
import com.library.model.BookReview;

@Mapper
public interface ReviewMapper {
	
	// 도서별 리뷰 전체 조회
	public List<BookReview> getAllReviewsByBooksId(int booksId);
	
	// 회원별 리뷰 전체 조회 --> 현재 보여줄 메뉴가 없음
//	public List<Review> getAllReviewsByMembersId(int membersId);

	// 댓글 등록
	public int insertReview(Reply reply);
	
	// 댓글 수정
	public int updateReview(Reply reply);
	
	// 댓글 삭제
	public int deleteReview(int reviewsId);
	
}
