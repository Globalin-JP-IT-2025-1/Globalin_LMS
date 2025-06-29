package com.library.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.SearchRequest;
import com.library.model.article.Article;
import com.library.model.article.ArticleListRequest;
import com.library.model.article.ArticleWithAuthor;

@Mapper
public interface ArticleMapper {
	
	// 목록 조회
	List<ArticleWithAuthor> getArticleList(ArticleListRequest articleListRequest); // 1) 목록 전체 조회 - 관리자
	List<ArticleWithAuthor> getArticleListByCategory(ArticleListRequest articleListRequest); // 2) 게시글 목록 조회 (카테고리 기준)
	List<ArticleWithAuthor> getArticleListByReqByMembersId(ArticleListRequest articleListRequest); // 3) 희망 도서 신청 게시글 목록 조회 (회원ID 기준)
	List<ArticleWithAuthor> getArticleListByKeyword(ArticleListRequest articleListRequest); // 4-1) 키워드 검색 (전체)
	List<ArticleWithAuthor> getArticleListByNotByKeyword(ArticleListRequest articleListRequest); // 4-2) 키워드 검색 (공지사항)
	List<ArticleWithAuthor> getArticleListByQnaByKeyword(ArticleListRequest articleListRequest); // 4-3) 키워드 검색 (qna)
	List<ArticleWithAuthor> getArticleListByReqByKeyword(ArticleListRequest articleListRequest); // 4-4) 키워드 검색 (req)
	
	// 목록 개수
	int getArticleListCount(); // 1) 전체 게시글 수
	int getArticleListCountByCategory(String category); // 2) 게시글 수 (카테고리 기준)
	int getArticleListCountByReqByMembersId(int membersId); // 3) 희망 도서 신청 게시글 수 (회원ID 기준)
	int getArticleListCountByKeyword(SearchRequest searchRequest); // 4-1) 검색에 따른 목록 개수 (전체)
	int getArticleListCountByNotByKeyword(SearchRequest searchRequest); // 4-2) 검색에 따른 목록 개수 (공지사항)
	int getArticleListCountByQnaByKeyword(SearchRequest searchRequest); // 4-3) 검색에 따른 목록 개수 (qna)
	int getArticleListCountByReqByKeyword(SearchRequest searchRequest); // 4-4) 검색에 따른 목록 개수 (req)
	
	// 상세 조회
	ArticleWithAuthor getArticleByArticlesId(int articleId); // 1) 게시글 상세 조회
    
    // 게시글 수정
    int updateArticleInfo(Article article); // 1) 제목 & 내용 수정
    int updateArticleDisable(int articleId); // 2) 비공개글 전환
    int updateArticleEnable(int articleId); // 3) 공개글 전환
    int updateArticleSecret(int articleId); // 4) 비밀글 전환
    
    int updateArticleViewCountUp(int articleId); // 5) view count 증가
    int updateArticleReplyCountUp(int articleId); // 6) reply count 증가
    int updateArticleReplyCountDown(int articleId); // 7) reply count 감소
    
    // 게시글 등록
    int insertArticle(Article article);
    
    // 게시글 삭제
    int deleteArticleById(int articleId);


    
}
