package com.library.service.impl;


import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.MemberBookLikeMapper;
import com.library.model.BookLike;
import com.library.service.MemberBookLikeService;

import lombok.AllArgsConstructor;

@Service("memberBookLikeService")
@AllArgsConstructor
public class MemberBookLikeServiceImpl implements MemberBookLikeService {
	private final MemberBookLikeMapper memberBookLikeMapper;
	
	// 회원별 관심 도서 목록 전체 조회 - 회원
	@Override
	public List<BookLike> getAllBookLikes(int membersId) {
		return memberBookLikeMapper.getAllBookLikes(membersId);
	}
	
	// 회원별 관심 도서 등록 - 회원
	@Override
	public int insertBookLike(int membersId, int booksId) {
		LocalDateTime currentDate = LocalDateTime.now();
		Timestamp currentDateTS = Timestamp.valueOf(currentDate);
		
		BookLike bookLike = BookLike.builder()
				.booksId(booksId)
				.membersId(membersId)
				.likeDate(currentDateTS)
				.build();
		
		return memberBookLikeMapper.insertBookLike(bookLike);
	}
	
	// 회원별 관심 도서 해제 - 회원
	@Override
	public int deleteBookLike(int bookLikeId) {
		return memberBookLikeMapper.deleteBookLike(bookLikeId);
	}
	

}
