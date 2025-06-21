package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Reply;
import com.library.model.ReplyListRequest;
import com.library.model.ReplyWithAuthor;

@Mapper
public interface ReplyMapper {
	
	// 조회
	// 1) 목록 조회 (게시글 ID 기반)
	public List<ReplyWithAuthor> getReplyListByArticlesId(ReplyListRequest replyListRequest);
	
	// 2) 댓글 수 (게시글 ID 기반)
	public int getReplyListCount(int articlesId);

	// 댓글 수정
	// 1) 비공개 (soft delete)
	public int updateReplyDisable(int replyId);
	
    // 2) 공개
	public int updateReplyEnable(int replyId);
	
    // 3) 비밀
	public int updateReplySecret(int replyId);
	
	// 댓글 등록
	public int insertReply(Reply reply);
	
	// 댓글 삭제
	public int deleteReply(int repliesId);
	
}
