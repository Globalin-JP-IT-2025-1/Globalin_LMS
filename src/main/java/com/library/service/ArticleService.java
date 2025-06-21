package com.library.service;

import com.library.model.Article;
import com.library.model.ArticleDetailResponse;
import com.library.model.ArticleListResponse;

public interface ArticleService {
	
	// 조회
	// 1) 게시글 전체 조회 - admin
	public ArticleListResponse getArticleList(int currentPage);
	
	// 2) 카테고리별 게시글 목록 조회
	public ArticleListResponse getArticleListByCategory(String category, int currentPage);
	
	// 3) 희망 도서 신청 게시글 목록 조회 (회원ID 기준)
	public ArticleListResponse getArticleListByReqByMembersId(int membersId, int currentPage);
	
	// 4) 게시글 전체 수
	public int getArticleListCount();
	
	// 5) 게시글 수 (카테고리 기준)
	public int getArticleListCountByCategory(String category);
	
	// 6) 희망 도서 신청 글 전체 수 (회원ID 기준) - book-req
	public int getArticleListCountByReqByMembersId(int membersId);
	
	// 7) 게시글 상세 조회 (게시글 & 게시글 작성자, 댓글 & 댓글 작성자 목록) - not, qna, req
	public ArticleDetailResponse getArticleWithReplyList(int articlesId, int replyCurrentPage);
	
	// 게시글 등록
	public int insertArticle(Article article);
    
	// 게시글 수정 
    // 1) 내용 수정 (제목, 내용) - 작성자
	public int updateArticleInfo(Article article);
	
	// 2) 비공개글 전환 - 작성자 삭제 시
	public int updateArticleDisable(int articlesId);
	
	// 3) 공개글 전환 - 작성자 복구 요청 또는 비밀글 해제 시
	public int updateArticleEnable(int articlesId);
	
	// 4) 비밀글 전환(Q&A만) - 작성자 설정
	public int updateArticleSecret(int articlesId);
    
	// 5) view count 증가
	public int updateArticleViewCountUp(int articlesId);
	
	// 6) reply count 증가
	public int updateArticleReplyCountUp(int articlesId);
	
	// 7) reply count 감소
	public int updateArticleReplyCountDown(int articlesId);
	
    // 게시글 삭제 - 관리자 삭제
	public int deleteArticleById(int articlesId);


}