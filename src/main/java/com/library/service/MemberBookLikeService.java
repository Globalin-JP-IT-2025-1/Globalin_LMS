package com.library.service;


import java.util.List;

import com.library.model.BookLike;

public interface MemberBookLikeService {
	
	// 회원별 관심 도서 목록 전체 조회 - 회원
	public List<BookLike> getAllBookLikes(int membersId);
	
	// 회원별 관심 도서 등록 - 회원
	public int insertBookLike(int membersId, int booksId);
	
	// 회원별 관심 도서 해제 - 회원
	public int deleteBookLike(int bookLikeId);

}
