package com.library.service.impl;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.MemberMapper;
import com.library.model.member.Member;
import com.library.model.member.MemberListRequest;
import com.library.model.member.MemberListResponse;
import com.library.model.status.MemberStatus;
import com.library.service.MemberService;
import com.library.util.CommonUtil;

import lombok.AllArgsConstructor;

@Service("memberService")
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	private final PasswordEncoder passwordEncoder;

	private final MemberMapper memberMapper;
	private final CommonUtil commonUtil;
	
	private static final int MEMBERS_PER_PAGE = 7; // 한 페이지당 게시글 수

	// 조회
	// 1) 회원 목록 조회
	@Override
	public MemberListResponse getMemberList(int currentPage) {
		
		int totalCount = getMemberListCount(); // 전체 개수
		int totalPages = (int)Math.ceil((double)totalCount / MEMBERS_PER_PAGE);
    	int startRow = (currentPage - 1) * MEMBERS_PER_PAGE;
    	int endRow = currentPage * MEMBERS_PER_PAGE;
    	
    	MemberListRequest memberListRequest = MemberListRequest.builder()
				.startRow(startRow)
				.endRow(endRow)
				.build();
		
		List<Member> memberList = memberMapper.getMemberList(memberListRequest);
		
		return MemberListResponse.builder()
				.memberList(memberList)
				.totalCount(totalCount) // 전체 게시글 수
				.totalPages(totalPages) // 전체 페이지 수
				.build();
	}
	
	// 2) 회원 전체 수
	@Override
	public int getMemberListCount() {
		return memberMapper.getMemberListCount();
	}
	

	// 3) 회원 정보 조회
	// membersId 기반
	@Override
	public Member getMemberById(int membersId) {
		return memberMapper.getMemberById(membersId);
	}

	// username 기반
	@Override
	public Member getMemberByUsername(String username) {
		return memberMapper.getMemberByUsername(username);
	}

	// email 기반
	@Override
	public Member getMemberByEmail(String email) {
		return memberMapper.getMemberByEmail(email);
	}

	// 회원 정보 수정
	@Override
	// 1) 회원 - 내 정보 수정 (password, email, mobile, zipcode, address, addressDetail)
	public int updateMemberInfo(Member member) {
		if (member.getPassword() != null) {
			// 비밀번호 암호화
			String encodedPassword = passwordEncoder.encode(member.getPassword());
			member.setPassword(encodedPassword);
		}

		return memberMapper.updateMemberInfo(member);
	}

	// 2) 회원 - 탈퇴 (status, leaveDate)
	@Override
	public int updateMemberLeave(int membersId) {
		
		// 오늘 날짜 계산
		LocalDateTime leaveDate = LocalDateTime.now();
		Timestamp tsLeaveDate = Timestamp.valueOf(leaveDate);

		Member member = Member.builder()
				.membersId(membersId)
				.status(MemberStatus.LEAVE.getCode()) // 탈퇴회원
				.leaveDate(tsLeaveDate) // 탈퇴날짜 추가
				.build();

		return memberMapper.updateMemberLeave(member);
	}

	// 3) 관리자 - 회원카드 등록 (status, cardnum)
	@Override
	@Transactional
	public int updateMemberCardnum(int membersId, String cardNum) {
		Member member = memberMapper.getMemberById(membersId);

		member.setStatus(MemberStatus.REGULER.getCode()); // 1-정회원 으로 변경
		member.setCardNum(cardNum); // 회원카드 추가

		return memberMapper.updateMemberCardnum(member);
	}

	// 4) 도서 시스템 - 도서 연체 (status)
	@Override
	public int updateMemberOverdue(Member member) {

		member.setStatus(MemberStatus.LOAN_HOLD.getCode()); // 2-대출정지 로 변경

		return memberMapper.updateMemberOverdue(member);
	}

	// 5) 도서 시스템 - 도서 대출 (loanCount)
	@Override
	public int updateMemberLoanCountUp(int membersId) {
		return memberMapper.updateMemberLoanCountUp(membersId);
	}
	
	// 5) 도서 시스템 - 도서 반납 (loanCount)
	@Override
	public int updateMemberLoanCountDown(int membersId) {
		return memberMapper.updateMemberLoanCountDown(membersId);
	}

	// 회원 삭제 - 관리자
	@Override
	public int deleteMember(int membersId) {
		return memberMapper.deleteMember(membersId);
	}

	// 회원 등록 - 회원
	@Override
	public int insertMember(Member member) {
		LocalDateTime now = LocalDateTime.now();
		Timestamp joinDate = Timestamp.valueOf(now);

		member.setStatus(MemberStatus.JUNIOR.getCode()); // 준회원
		member.setCardNum(null); // 회원 카드 번호 기본값
		member.setLoanCount(0); // 현재 대출 권수 기본값

		member.setJoinDate(joinDate); // 가입 날짜 설정
		member.setLeaveDate(null); // 탈퇴 날짜 기본값

		// 비밀번호 암호화
		String encodedPassword = passwordEncoder.encode(member.getPassword());
		member.setPassword(encodedPassword);
		
		System.out.println("ServiceTest: " +
        		member.getUsername() + ", " +
        		member.getPassword() + ", " +
        		member.getName() + ", " +
        		member.getEmail() + ", " +
        		member.getMobile() + ", " +
        		member.getZipcode() + ", " +
        		member.getAddress() + ", " +
        		member.getAddressDetail()
			);

		return memberMapper.insertMember(member);
	}

	// 비밀번호 초기화
	@Override
	public String resetPassword(Member member) {

		String randomPassword = commonUtil.getRandomNumber();

		// 비밀번호 암호화
		String encodedPassword = passwordEncoder.encode(randomPassword);
		member.setPassword(encodedPassword);

		return randomPassword;
	}

}