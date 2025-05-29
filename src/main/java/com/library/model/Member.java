package com.library.model;

import java.sql.Date;

//import lombok.AllArgsConstructor;
//import lombok.Getter;
//import lombok.NoArgsConstructor;
//import lombok.Setter;

//@Getter
//@Setter
//@AllArgsConstructor
//@NoArgsConstructor
public class Member {
	
	private int membersId; // 회원 ID (MEMBERS_ID, PK)
    private int status; // 회원 등급 (STATUS, 0:준회원, 1:정회원, 2:대출정지)
    private String cardNum; // 회원 카드번호 (CARD_NUM, UUID 형식)
    private String email; // 이메일 (EMAIL, UNIQUE)
    private String password; // 비밀번호 (PASSWORD)
    private String name; // 이름 (NAME)
    private String mobile; // 전화번호 (MOBILE)
    private String zipcode; // 우편번호 (ZIPCODE)
    private String address; // 상세주소 (ADDRESS)
    private Date joinDate; // 가입일자 (JOIN_DATE)
    private Date leaveDate; // 탈퇴일자 (LEAVE_DATE)
    
    public Member() {
    }
    
	public Member(int membersId, int status, String cardNum, String email, String password, String name, String mobile,
			String zipcode, String address, Date joinDate, Date leaveDate) {
		this.membersId = membersId;
		this.status = status;
		this.cardNum = cardNum;
		this.email = email;
		this.password = password;
		this.name = name;
		this.mobile = mobile;
		this.zipcode = zipcode;
		this.address = address;
		this.joinDate = joinDate;
		this.leaveDate = leaveDate;
	}
    
    // Setter
	public void setMembersId(int membersId) {
		this.membersId = membersId;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public void setLeaveDate(Date leaveDate) {
		this.leaveDate = leaveDate;
	}
	
	// Getter
	public int getMembersId() {
		return membersId;
	}
	public int getStatus() {
		return status;
	}
	public String getCardNum() {
		return cardNum;
	}
	public String getEmail() {
		return email;
	}
	public String getPassword() {
		return password;
	}
	public String getName() {
		return name;
	}
	public String getMobile() {
		return mobile;
	}
	public String getZipcode() {
		return zipcode;
	}
	public String getAddress() {
		return address;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public Date getLeaveDate() {
		return leaveDate;
	}

}
