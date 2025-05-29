package com.library.model;

import java.sql.Date;

public class Book {

	private int booksId;        // 도서ID
    private String title;        // 제목
    private String author;       // 저자
    private String publisher;    // 출판사
    private Date publishDate;    // 출판날짜
    private String isbn;         // ISBN
    private String category;     // 카테고리: 총류, ...
    private String imageLink;    // 썸네일
    private String description;  // 설명
    private Date createDate;     // 등록날짜
    private int loanCount;      // 대출횟수
    private int likeCount;      // 북마크개수
    private int status;         // 도서 상태: 0-기본, 1-대여중, 2-대여예약중
    
    public Book() {
    	
    }
    
    public Book(int booksId, String title, String author, String publisher, Date publishDate, String isbn,
			String category, String imageLink, String description, Date createDate, int loanCount, int likeCount,
			int status) {
		this.booksId = booksId;
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.publishDate = publishDate;
		this.isbn = isbn;
		this.category = category;
		this.imageLink = imageLink;
		this.description = description;
		this.createDate = createDate;
		this.loanCount = loanCount;
		this.likeCount = likeCount;
		this.status = status;
	}
    
	// Setter
	public void setBooksId(int booksId) {
		this.booksId = booksId;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setImageLink(String imageLink) {
		this.imageLink = imageLink;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public void setLoanCount(int loanCount) {
		this.loanCount = loanCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public void setStatus(int status) {
		this.status = status;
	}
    
    // Getter
	public int getBooksId() {
		return booksId;
	}
	public String getTitle() {
		return title;
	}
	public String getAuthor() {
		return author;
	}
	public String getPublisher() {
		return publisher;
	}
	public Date getPublishDate() {
		return publishDate;
	}
	public String getIsbn() {
		return isbn;
	}
	public String getCategory() {
		return category;
	}
	public String getImageLink() {
		return imageLink;
	}
	public String getDescription() {
		return description;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public int getLoanCount() {
		return loanCount;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public int getStatus() {
		return status;
	}
    
    
}
