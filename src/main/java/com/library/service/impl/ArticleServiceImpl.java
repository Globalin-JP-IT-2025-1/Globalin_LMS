package com.library.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.ResourceAccessException;

import com.library.mapper.ArticleMapper;
import com.library.model.Article;
import com.library.model.Member;
import com.library.model.Reply;
import com.library.service.ArticleService;
import com.library.service.MemberService;
import com.library.service.ReplyService;

import lombok.RequiredArgsConstructor;

@Service("articleService")
@RequiredArgsConstructor
public class ArticleServiceImpl implements ArticleService {
	private final ArticleMapper articleMapper; // 게시글
	private final ReplyService replyService; // 댓글
	private final MemberService memberService; // 작성자
	
	// 게시글 전체 조회 - admin
	@Override
	public List<Article> getAllArticles() {
		return articleMapper.getAllArticles();
	}
	
	// 게시글 목록 조회
	@Override
	public List<Article> getAllArticlesByCategory(String category) {
		return articleMapper.getAllArticlesByCategory(category);
	}
	
	// 게시글 목록 및 작성자 목록 조회
	@Override
	public Map<String, Object> getAllArticlesByCategoryWithAuthor(String category) {
		
		Map<String, Object> articleListWithAuthor = new HashMap<>();
		
		List<Article> articleList = getAllArticlesByCategory(category);
		List<Member> authorList = new ArrayList<>();
		
		for (Article a : articleList) {
			Member m = memberService.getMemberById(a.getAuthorId());
			authorList.add(m);
		}
		
		articleListWithAuthor.put("articleList", articleList);
		articleListWithAuthor.put("authorList", authorList);
		
		return articleListWithAuthor;
	}

	// 회원별 희망 도서 신청 목록 조회 - book-req
	@Override
	public List<Article> getArticlesReqByMembersId(int membersId) {
		return articleMapper.getAllBookReqsByMembersId(membersId);
	}
	
	// 게시글 상세 조회
	@Override
	public Article getArticleById(int articlesId) {
		return articleMapper.getArticleById(articlesId);
	}
	
	// 게시글 상세 조회 (게시글, 게시글 작성자) - fnq
	@Override
	public Map<String, Object> getArticleByIdWithAuthor(int articlesId) {
		Map<String, Object> articleWithAuthor = new HashMap<>();
		
		// 게시글 가져오기
		Article article = articleMapper.getArticleById(articlesId);
		if (article == null) {
	        throw new ResourceAccessException("게시글을 찾을 수 없습니다.");
	    }
		articleWithAuthor.put("article", article);

		// 작성자 가져오기
		Member member = memberService.getMemberById(article.getAuthorId());
		articleWithAuthor.put("a_author", member);
		
		
		return articleWithAuthor;
	}
	
	// 게시글 상세 조회 (게시글, 게시글 작성자, 댓글 목록, 댓글 작성자 목록) - not, qna, req
	@Override
	@Transactional
	public Map<String, Object> getArticleWithAuthorAndReplies(int articlesId) {
		// 게시글 + 작성자 정보
		Map<String, Object> articleWithAuthorAndReplies = getArticleByIdWithAuthor(articlesId);
		Article article = (Article) articleWithAuthorAndReplies.get("article");
		
		// 댓글 + 댓글 작성자 목록 가져오기
		if (article.getReplyCount() > 0) {
			List<Reply> replyList = replyService.getAllRepliesByArticlesId(articlesId);
			articleWithAuthorAndReplies.put("replyList", replyList);
			
			List<Member> r_authorList = new ArrayList<>();
			for (Reply r : replyList) {
				Member m = memberService.getMemberById(r.getAuthorId());
				r_authorList.add(m);
			}
			articleWithAuthorAndReplies.put("r_authorList", r_authorList);
		}
		
		return articleWithAuthorAndReplies;
	}
	
	// 게시글 등록
	@Override
	public int insertArticle(Article article) {
		return articleMapper.insertArticle(article);
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
	
    // 게시글 삭제 - 관리자 삭제
	@Override
	public int deleteArticleById(int articlesId) {
		return articleMapper.deleteArticleById(articlesId);
	}
	


}