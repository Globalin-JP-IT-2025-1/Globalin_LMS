package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.mapper.ArticleMapper;
import com.library.model.Article;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ArticleService {
	private final ArticleMapper articleMapper;
	
	public List<Article> getAllArticles() {
		return articleMapper.getAllArticles();
	}

	/*
	 * public Article findById(int id) { return articleMapper.findById(id); }
	 * 
	 * public boolean save(Article article) { return articleMapper.save(article); }
	 * 
	 * public boolean deleteById(int id) { return articleMapper.deleteById(id); }
	 */

}