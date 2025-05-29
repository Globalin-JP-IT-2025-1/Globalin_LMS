package com.library.model;

import java.sql.Date;

public class Article {
	
	private int articlesId; // 게시글ID
	private int authorId; // 작성자
	private String category; // 카테고리
	private String title; // 제목
	private String content; // 내용
	private Date createDate; // 최초등록날짜
	private Date updateDate; // 마지막수정날짜
	private int replyCount; // 댓글수
	private int viewCount; // 조회수
	private boolean isSecret; // 비밀글여부
	
	public Article() {
	}
	
	public Article(int articlesId, int authorId, String category, String title, String content, Date createDate,
			Date updateDate, int replyCount, int viewCount, boolean isSecret) {
		this.articlesId = articlesId;
		this.authorId = authorId;
		this.category = category;
		this.title = title;
		this.content = content;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.replyCount = replyCount;
		this.viewCount = viewCount;
		this.isSecret = isSecret;
	}
	
	// Setter
	public void setArticlesId(int articlesId) {
		this.articlesId = articlesId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public void setSecret(boolean isSecret) {
		this.isSecret = isSecret;
	}
	
	// Getter
	public int getArticlesId() {
		return articlesId;
	}

	public int getAuthorId() {
		return authorId;
	}

	public String getCategory() {
		return category;
	}

	public String getTitle() {
		return title;
	}

	public String getContent() {
		return content;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public int getViewCount() {
		return viewCount;
	}

	public boolean isSecret() {
		return isSecret;
	}
	
	
}
