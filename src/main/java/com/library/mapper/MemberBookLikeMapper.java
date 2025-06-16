package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.BookLike;

@Mapper
public interface MemberBookLikeMapper {
	
	// 회원별 관심 도서 목록 전체 조회 - 회원
	public List<BookLike> getAllBookLikes(int membersId);
	
	// 회원별 관심 도서 등록 - 회원
	public int insertBookLike(BookLike bookLike);
	
	// 회원별 관심 도서 해제 - 회원
	public int deleteBookLike(int bookLikeId);

}
