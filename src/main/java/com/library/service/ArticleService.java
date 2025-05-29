package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.ArticleMapper;
import com.library.model.Article;

//import lombok.RequiredArgsConstructor;

@Service
//@RequiredArgsConstructor
public class ArticleService {
	private final ArticleMapper articleMapper;
	
	public ArticleService(ArticleMapper articleMapper) {
		this.articleMapper = articleMapper;
	}
	
	public List<Article> findAllArticles() {
		return articleMapper.findAllArticles();
	}

	/*
	 * public Article findById(int id) { return articleMapper.findById(id); }
	 * 
	 * public boolean save(Article article) { return articleMapper.save(article); }
	 * 
	 * public boolean deleteById(int id) { return articleMapper.deleteById(id); }
	 */

}
