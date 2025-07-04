package com.library.service.impl;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.ArticleMapper;
import com.library.model.SearchRequest;
import com.library.model.article.Article;
import com.library.model.article.ArticleDetailResponse;
import com.library.model.article.ArticleListRequest;
import com.library.model.article.ArticleListResponse;
import com.library.model.article.ArticleWithAuthor;
import com.library.model.article.ReplyListResponse;
import com.library.service.ArticleService;
import com.library.service.ReplyService;

import lombok.RequiredArgsConstructor;

@Service("articleService")
@RequiredArgsConstructor
public class ArticleServiceImpl implements ArticleService {
	private final ArticleMapper articleMapper; // 게시글
	private final ReplyService replyService; // 댓글
	
	private static final int ARTICLES_PER_PAGE = 7; // 한 페이지당 게시글 수
	
	// 조회
	// 1) 게시글 전체 조회 - admin
	@Override
	public ArticleListResponse getArticleList(int currentPage) {
		
		int totalCount = getArticleListCount(); // 전체 개수
		int totalPages = (int)Math.ceil((double)totalCount / ARTICLES_PER_PAGE);
    	int startRow = (currentPage - 1) * ARTICLES_PER_PAGE;
    	int endRow = currentPage * ARTICLES_PER_PAGE;
    	
		ArticleListRequest articlesListRequest = ArticleListRequest.builder()
				.category(null)
				.searchRequest(null)
				.startRow(startRow)
				.endRow(endRow)
				.build();
		
		List<ArticleWithAuthor> articleList = articleMapper.getArticleList(articlesListRequest);
		
		return ArticleListResponse.builder()
				.articleList(articleList)
				.totalCount(totalCount) // 전체 게시글 수
				.totalPages(totalPages) // 전체 페이지 수
				.build();
	}
	
	// 2) 카테고리별 게시글 목록 조회
	@Override
	public ArticleListResponse getArticleListByCategory(String category, int currentPage) {

		int totalCount = getArticleListCountByCategory(category); // 공지사항 전체 개수
		int totalPages = (int)Math.ceil((double)totalCount / ARTICLES_PER_PAGE);
    	int startRow = (currentPage - 1) * ARTICLES_PER_PAGE;
    	int endRow = currentPage * ARTICLES_PER_PAGE;
    	
		ArticleListRequest articlesListRequest = ArticleListRequest.builder()
				.category(category)
				.searchRequest(null)
				.startRow(startRow)
				.endRow(endRow)
				.build();
		
		List<ArticleWithAuthor> articleList = articleMapper.getArticleListByCategory(articlesListRequest);
		
		return ArticleListResponse.builder()
				.articleList(articleList)
				.totalCount(totalCount) // 전체 게시글 수
				.totalPages(totalPages) // 전체 페이지 수
				.build();
	}
	
	// 3) 희망 도서 신청 게시글 목록 조회 (회원ID 기준)
	@Override
	public ArticleListResponse getArticleListByReqByMembersId(int membersId, int currentPage) {
		
		int totalCount = getArticleListCountByReqByMembersId(membersId);
		int totalPages = (int)Math.ceil((double)totalCount / ARTICLES_PER_PAGE);
    	int startRow = (currentPage - 1) * ARTICLES_PER_PAGE;
    	int endRow = currentPage * ARTICLES_PER_PAGE;
		
		ArticleListRequest articlesListRequest = ArticleListRequest.builder()
				.category("req")
				.membersId(membersId)
				.searchRequest(null)
				.startRow(startRow)
				.endRow(endRow)
				.build();
		
		List<ArticleWithAuthor> articleList = articleMapper.getArticleListByReqByMembersId(articlesListRequest);
		
		return ArticleListResponse.builder()
				.articleList(articleList)
				.totalCount(totalCount) // 전체 게시글 수
				.totalPages(totalPages) // 전체 페이지 수
				.build();
	}
	
	// 4-1) 키워드 검색 (전체) - admin
	@Override
	public ArticleListResponse getArticleListByKeyword(String type, String keyword, int currentPage) {
		
		SearchRequest searchRequest = SearchRequest.builder()
				.type(type)
				.keyword(keyword)
				.build();
		
		int totalCount = getArticleListCountByKeyword(searchRequest);
		int totalPages = (int)Math.ceil((double)totalCount / ARTICLES_PER_PAGE);
    	int startRow = (currentPage - 1) * ARTICLES_PER_PAGE;
    	int endRow = currentPage * ARTICLES_PER_PAGE;
    	
    	ArticleListRequest articleListRequest = ArticleListRequest.builder()
    			.category(null)
    			.startRow(startRow)
    			.endRow(endRow)
    			.searchRequest(searchRequest)
    			.build();
    	
    	List<ArticleWithAuthor> articleList = articleMapper.getArticleListByKeyword(articleListRequest);
		
		return ArticleListResponse.builder()
				.articleList(articleList)
				.totalCount(totalCount)
				.totalPages(totalPages)
				.build();
	}
	
	// 4-2) 키워드 검색 (카테고리별)
	@Override
	public ArticleListResponse getArticleListByCategoryByKeyword(String category, String type, String keyword, int currentPage) {
		
		SearchRequest searchRequest = SearchRequest.builder()
				.type(type)
				.keyword(keyword)
				.build();
		
		int totalCount = getArticleListCountByCategoryByKeyword(category, searchRequest);
		int totalPages = (int)Math.ceil((double)totalCount / ARTICLES_PER_PAGE);
    	int startRow = (currentPage - 1) * ARTICLES_PER_PAGE;
    	int endRow = currentPage * ARTICLES_PER_PAGE;
    	
    	List<ArticleWithAuthor> articleList = null;
    	
    	ArticleListRequest articleListRequest = ArticleListRequest.builder()
    			.category(category)
    			.startRow(startRow)
    			.endRow(endRow)
    			.searchRequest(searchRequest)
    			.build();
		
    	switch (category) {
	        case "not":
	            articleList = articleMapper.getArticleListByNotByKeyword(articleListRequest);
	            break;
	        case "qna":
	            articleList = articleMapper.getArticleListByQnaByKeyword(articleListRequest);
	            break;
	        case "req":
	            articleList = articleMapper.getArticleListByReqByKeyword(articleListRequest);
	            break;
	        default:
	            articleList = null; // 또는 예외 처리
	            break;
    	}
		
		return ArticleListResponse.builder()
				.articleList(articleList)
				.totalCount(totalCount)
				.totalPages(totalPages)
				.build();
	}
	
	// 5) 메인 전용 공지사항 최신 5건
	@Override
	public List<Article> getNoticeListForHome() {
		return articleMapper.getNoticeListForHome();
	}

	
	// 목록 개수
	// 1) 게시글 전체 수
	@Override
	public int getArticleListCount() {
		return articleMapper.getArticleListCount();
	}
	
	// 2) 게시글 전체 수 (카테고리 기준)
	@Override
	public int getArticleListCountByCategory(String category) {
		return articleMapper.getArticleListCountByCategory(category);
	}
	
	// 3) 희망 도서 신청 글 전체 수 (회원ID 기준) - req
	@Override
	public int getArticleListCountByReqByMembersId(int membersId) {
		return articleMapper.getArticleListCountByReqByMembersId(membersId);
	}
	
	// 4-1) 키워드 검색 목록 수 (전체)
	@Override
	public int getArticleListCountByKeyword(SearchRequest searchRequest) {
		return articleMapper.getArticleListCountByKeyword(searchRequest);
	}
	
	// 4-2) 키워드 검색 목록 수 (카테고리)
	@Override
	public int getArticleListCountByCategoryByKeyword(String category, SearchRequest searchRequest) {
		switch (category) {
	        case "not":
	        	return articleMapper.getArticleListCountByNotByKeyword(searchRequest);
	        case "qna":
	        	return articleMapper.getArticleListCountByQnaByKeyword(searchRequest);
	        case "req":
	        	return articleMapper.getArticleListCountByReqByKeyword(searchRequest);
	        default:
	        	return -1; // 또는 예외 처리
		}
	}

	// 상세 조회
	// 1) 게시글 상세 조회 (게시글 & 게시글 작성자, 댓글 & 댓글 작성자 목록) - not, qna, req
	@Override
	public ArticleDetailResponse getArticleWithReplyList(int articlesId, int replyCurrentPage) {
	    // 게시글 & 작성자 가져오기
	    ArticleWithAuthor articleWithAuthor = articleMapper.getArticleByArticlesId(articlesId);

	    // 기본 값 설정
	    ReplyListResponse replyListResponse = null;
	    
	    if (articleWithAuthor != null) {
	    	if (articleWithAuthor.getReplyCount() > 0) {
	    		replyListResponse = replyService.getReplyListByArticlesId(articlesId, replyCurrentPage);
	    	}
	    }

	    return ArticleDetailResponse.builder()
	            .articleWithAuthor(articleWithAuthor)
	            .replyListResponse(replyListResponse)
	            .build();
	}
    
	// 게시글 수정 
    // 1) 내용 수정 (제목, 내용) - 작성자
	@Override
	public int updateArticleInfo(Article article) {
		return articleMapper.updateArticleInfo(article);
	}
	
	// 2) 비공개글 전환 - 작성자 삭제 시
	@Override
	public int updateArticleDisable(int articlesId) {
		return articleMapper.updateArticleDisable(articlesId);
	}
	
	// 3) 공개글 전환 - 작성자 복구 요청 또는 비밀글 해제 시
	@Override
	public int updateArticleEnable(int articlesId) {
		return articleMapper.updateArticleEnable(articlesId);
	}
	
	// 4) 비밀글 전환(Q&A만) - 작성자 설정
	@Override
	public int updateArticleSecret(int articlesId) {
		return articleMapper.updateArticleSecret(articlesId);
	}
	
	// 5) view count 증가
	@Override
	public int updateArticleViewCountUp(int articlesId) {
		return articleMapper.updateArticleViewCountUp(articlesId);
	}
	
	// 6) reply count 증가
	@Override
	public int updateArticleReplyCountUp(int articlesId) {
		return articleMapper.updateArticleReplyCountUp(articlesId);
	}
	
	// 7) reply count 감소
	@Override
	public int updateArticleReplyCountDown(int articlesId) {
		return articleMapper.updateArticleReplyCountDown(articlesId);
	}
	

	// 게시글 등록
	@Override
	public int insertArticle(Article article) {
		// 오늘 날짜 설정
		LocalDateTime currentDate = LocalDateTime.now();
		Timestamp currentDateTS = Timestamp.valueOf(currentDate);
		
		article.setCreateDate(currentDateTS);
		article.setUpdateDate(currentDateTS);
		article.setViewCount(0);
		article.setReplyCount(0);
		
		System.out.println(
				"ArticleServiceImpl - "
				+ "ArticlesId : " + article.getArticlesId() + ", "
				+ "AuthorId : " + article.getAuthorId() + ", "
				+ "Category : " + article.getCategory() + ", "
				+ "Title : " + article.getTitle() + ", "
				+ "Content : " + article.getContent() + ", "
				+ "CreateDate : " + article.getCreateDate() + ", "
				+ "UpdateDate : " + article.getUpdateDate() + ", "
				+ "Status : " + article.getStatus());
		
		return articleMapper.insertArticle(article);
    }
	
    // 게시글 삭제 - 관리자 삭제
	@Override
	public int deleteArticleById(int articlesId) {
		return articleMapper.deleteArticleById(articlesId);
	}

}