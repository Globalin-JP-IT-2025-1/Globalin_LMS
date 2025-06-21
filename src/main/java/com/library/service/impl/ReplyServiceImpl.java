package com.library.service.impl;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.ReplyMapper;
import com.library.model.Reply;
import com.library.model.ReplyListRequest;
import com.library.model.ReplyListResponse;
import com.library.model.ReplyWithAuthor;
import com.library.service.ReplyService;

import lombok.RequiredArgsConstructor;

@Service("ReplyService")
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private final ReplyMapper replyMapper;
	
	private static final int REPLIES_PER_PAGE = 10; // 한 페이지당 댓글 수
	
	// 조회
	// 1) 댓글 목록 조회 (게시글 ID 기반)
	@Override
	public ReplyListResponse getReplyListByArticlesId(int articlesId, int replyCurrentPage) {
		
		int totalCount = getReplyListCount(articlesId);
        int totalPage = (int) Math.ceil((double) totalCount / REPLIES_PER_PAGE);
        int startRow = (replyCurrentPage - 1) * REPLIES_PER_PAGE;
        int endRow = replyCurrentPage * REPLIES_PER_PAGE;
        
        List<ReplyWithAuthor> replyList = replyMapper.getReplyListByArticlesId(ReplyListRequest.builder()
				.originArticleId(articlesId)
				.startRow(startRow)
				.endRow(endRow)
				.build());
        
		return ReplyListResponse.builder()
				.replyList(replyList)
				.totalCount(totalCount)
				.totalPages(totalPage)
				.build();
	}
	
	// 2) 댓글 수 (게시글 ID 기반)
	public int getReplyListCount(int articlesId) {
		return replyMapper.getReplyListCount(articlesId);
	}
	
	
    // 댓글 수정
    // 1) 비공개 (soft delete)
	@Override
    public int updateReplyDisable(int replyId) {
        return replyMapper.updateReplyDisable(replyId);
    }

    // 2) 공개
	@Override
    public int updateReplyEnable(int replyId) {
        return replyMapper.updateReplyEnable(replyId);
    }
    
    // 3) 비밀
	@Override
    public int updateReplySecret(int replyId) {
    	return replyMapper.updateReplySecret(replyId);
    }
	
	// 댓글 등록
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

    // 댓글 삭제 (hard delete)
	@Override
    public int deleteReply(int replyId) {
        return replyMapper.deleteReply(replyId);
    }
    
}