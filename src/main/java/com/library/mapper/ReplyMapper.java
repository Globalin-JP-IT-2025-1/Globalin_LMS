package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.Reply;

@Mapper
public interface ReplyMapper {
	
	// 게시글별 댓글 목록 조회
	public List<Reply> getAllRepliesByArticlesId(int articlesId);
	
	// 회원별 댓글 목록 조회 --> 현재 보여줄 메뉴가 없음
//	public List<Reply> getAllRepliesByMembersId(int membersId);

	// 댓글 등록
	public int insertReply(Reply reply);
	
	// 댓글 수정 - 내용
	public int updateReplyInfo(Reply reply);
	
	// 댓글 수정 - 비공개 (soft delete)
	public int updateReplyDisable(int replyId);
	
	// 댓글 수정 - 공개
	public int updateReplyEnable(int replyId);
	
	// 댓글 수정 - 비밀
	public int updateReplySecret(int replyId);
	
	// 댓글 삭제
	public int deleteReply(int repliesId);
	
}
