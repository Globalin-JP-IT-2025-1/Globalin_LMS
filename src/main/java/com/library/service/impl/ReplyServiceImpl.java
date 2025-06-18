package com.library.service.impl;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.ReplyMapper;
import com.library.model.Reply;
import com.library.service.ReplyService;

import lombok.RequiredArgsConstructor;

@Service("ReplyService")
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private final ReplyMapper replyMapper;
	
	// 댓글 목록 조회 (게시글 id 기반)
	@Override
	public List<Reply> getAllRepliesByArticlesId(int articlesId) {
		return replyMapper.getAllRepliesByArticlesId(articlesId);
	}
	
	// 댓글 작성
	@Override
    public int insertReply(Reply reply) {
		// 오늘 날짜 설정
		LocalDateTime currentDate = LocalDateTime.now();
		Timestamp currentDateTS = Timestamp.valueOf(currentDate);
		
		reply.setCreateDate(currentDateTS);
		reply.setUpdateDate(currentDateTS);
		reply.setStatus(0);
		
        return replyMapper.insertReply(reply);
    }

    // 댓글 수정 - 내용
	@Override
    public int updateReplyInfo(Reply reply) {
		// 오늘 날짜 설정
		LocalDateTime currentDate = LocalDateTime.now();
		Timestamp currentDateTS = Timestamp.valueOf(currentDate);
		
		reply.setUpdateDate(currentDateTS);
		
        return replyMapper.updateReplyInfo(reply);
    }

    // 댓글 수정 - 비공개 (soft delete)
	@Override
    public int updateReplyDisable(int replyId) {
        return replyMapper.updateReplyDisable(replyId);
    }

    // 댓글 수정 - 공개
	@Override
    public int updateReplyEnable(int replyId) {
        return replyMapper.updateReplyEnable(replyId);
    }
    
    // 댓글 수정 - 비밀
	@Override
    public int updateReplySecret(int replyId) {
    	return replyMapper.updateReplySecret(replyId);
    }

    // 댓글 삭제 (hard delete)
	@Override
    public int deleteReply(int replyId) {
        return replyMapper.deleteReply(replyId);
    }
    
}