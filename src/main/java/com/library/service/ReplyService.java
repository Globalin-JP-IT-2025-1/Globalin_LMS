package com.library.service;

import com.library.model.article.Reply;
import com.library.model.article.ReplyListResponse;

public interface ReplyService {
	
	// 조회
	// 관리자용 댓글 전체 목록 조회
	public ReplyListResponse getReplyList(int replyCurrentPage);
	
	// 관리자용 댓글 수 (전체)
	public int getReplyListCount();
	
	// 1) 댓글 목록 조회 (게시글 ID 기반)
	public ReplyListResponse getReplyListByArticlesId(int articlesId, int replyCurrentPage);
	
	// 1) 댓글 수 (게시글 ID 기반)
	public int getReplyListCountByArticlesId(int articlesId);
    
    // 수정
    // 1) 비공개 (soft delete)
    public int updateReplyDisable(int replyId);

    // 2) 공개
    public int updateReplyEnable(int replyId);
    
    // 3) 비밀
    public int updateReplySecret(int replyId);
    
    // 추가
    public int insertReply(Reply reply);

    // 삭제 (hard delete)
    public int deleteReply(int articlesId, int replyId);

	public Reply getReplyById(int repliesId);
    
}