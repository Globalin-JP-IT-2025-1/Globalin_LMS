package com.library.service;

import com.library.model.Reply;
import com.library.model.ReplyListResponse;

public interface ReplyService {
	
	// 조회
	// 1) 댓글 목록 조회 (게시글 ID 기반)
	public ReplyListResponse getReplyListByArticlesId(int articlesId, int replyCurrentPage);
	
	// 1) 댓글 수 (게시글 ID 기반)
	public int getReplyListCount(int articlesId);
    
    // 댓글 수정
    // 1) 비공개 (soft delete)
    public int updateReplyDisable(int replyId);

    // 2) 공개
    public int updateReplyEnable(int replyId);
    
    // 3) 비밀
    public int updateReplySecret(int replyId);
    
    // 댓글 작성
    public int insertReply(Reply reply);

    // 댓글 삭제 (hard delete)
    public int deleteReply(int replyId);
    
}