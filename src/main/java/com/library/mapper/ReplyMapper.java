package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.article.Reply;
import com.library.model.article.ReplyListRequest;
import com.library.model.article.ReplyWithAuthor;

@Mapper
public interface ReplyMapper {
	
	// 조회
	// 1) 관리자용 댓글 조회 (전체)
	public List<ReplyWithAuthor> getReplyList(ReplyListRequest replyListRequest);
	
	// 2) 댓글 수 (전체)
	public int getReplyListCount();
	
	// 1) 목록 조회 (게시글 ID 기반)
	public List<ReplyWithAuthor> getReplyListByArticlesId(ReplyListRequest replyListRequest);
	
	// 2) 댓글 수 (게시글 ID 기반)
	public int getReplyListCountByArticlesId(int articlesId);

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
	
	
	// 댓글 가져오기 (삭제용)
	public Reply getReplyById(int repliesId);
	
}
