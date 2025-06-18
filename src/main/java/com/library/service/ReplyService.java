package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.ReplyMapper;
import com.library.model.Reply;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class ReplyService {
	private final ReplyMapper replyMapper;
	
	// 댓글 목록 조회 (게시글 id 기반)
	public List<Reply> getAllRepliesByArticlesId(int articlesId) {
		return replyMapper.getAllRepliesByArticlesId(articlesId);
	}
	
	// 댓글 작성
    public int insertReply(Reply reply) {
        return replyMapper.insertReply(reply);
    }

    // 댓글 수정 - 내용
    public int updateReplyInfo(Reply reply) {
        return replyMapper.updateReplyInfo(reply);
    }

    // 댓글 수정 - 비공개 (soft delete)
    public int updateReplyDisable(int replyId) {
        return replyMapper.updateReplyDisable(replyId);
    }

    // 댓글 수정 - 공개
    public int updateReplyEnable(int replyId) {
        return replyMapper.updateReplyEnable(replyId);
    }
    
    // 댓글 수정 - 비밀
    public int updateReplySecret(int replyId) {
    	return replyMapper.updateReplySecret(replyId);
    }

    // 댓글 삭제 (hard delete)
    public int deleteReply(int replyId) {
        return replyMapper.deleteReply(replyId);
    }
    
}