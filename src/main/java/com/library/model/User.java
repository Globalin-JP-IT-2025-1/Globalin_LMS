package com.library.model;

public class User {
	private long id;
	private String name;
	private String email;
	private String userid;
	private String password;

	// 생성자
	public User() {
	}
	
	public User(long id, String name, String email, String userid, String password) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.userid = userid;
		this.password = password;
	}
	
	// Setter
	public void setId(long id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	// Getter
	public long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public String getUserid() {
		return userid;
	}

	public String getPassword() {
		return password;
	}

}
