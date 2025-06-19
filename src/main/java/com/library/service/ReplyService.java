package com.library.service;

import java.util.List;

import com.library.model.Reply;

public interface ReplyService {
	
	// 댓글 목록 조회 (게시글 id 기반)
	public List<Reply> getAllRepliesByArticlesId(int articlesId);
	
	// 댓글 작성
    public int insertReply(Reply reply);
    
    // 댓글 수정 - 내용
    public int updateReplyInfo(Reply reply);

    // 댓글 수정 - 비공개 (soft delete)
    public int updateReplyDisable(int replyId);

    // 댓글 수정 - 공개
    public int updateReplyEnable(int replyId);
    
    // 댓글 수정 - 비밀
    public int updateReplySecret(int replyId);

    // 댓글 삭제 (hard delete)
    public int deleteReply(int replyId);
    
}