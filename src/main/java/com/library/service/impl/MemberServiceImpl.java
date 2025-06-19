package com.library.service.impl;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.mapper.MemberMapper;
import com.library.model.Member;
import com.library.service.BlacklistedTokenService;
import com.library.service.MemberService;
import com.library.util.CommonUtil;

import lombok.AllArgsConstructor;

@Service("memberService")
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	private final PasswordEncoder passwordEncoder;

	private final BlacklistedTokenService blacklistedTokenService;

	private final MemberMapper memberMapper;
	private final CommonUtil commonUtil;


	// 회원 목록 조회
	@Override
	public List<Member> getAllMembers() {
		return memberMapper.getAllMembers();
	}

	// 회원 정보 조회
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
	public int updateMemberLeave(Member member) {
		LocalDateTime leaveDate = LocalDateTime.now();
		Timestamp tsLeaveDate = Timestamp.valueOf(leaveDate);

		member.setStatus(3); // 3-대출정지 로 변경
		member.setLeaveDate(tsLeaveDate); // 탈퇴날짜 추가

		return memberMapper.updateMemberLeave(member);
	}

	// 회원 탈퇴 토큰 처리
	@Override
	@Transactional
	public int updateMemberLeave(int membersId, Map<String, String> tokens) {
		Member member = memberMapper.getMemberById(membersId);

		// 회원 정보 수정
		updateMemberLeave(member);

		// 탈퇴 회원의 토큰을 블랙리스트에 추가
		// access token
		blacklistedTokenService.insertBlacklistedToken(tokens.get("aToken"), 0);

		// refresh token
		blacklistedTokenService.insertBlacklistedToken(tokens.get("rToken"), 1);

		return 1;
	}

	// 3) 관리자 - 회원카드 등록 (status, cardnum)
	@Override
	@Transactional
	public int updateMemberCardnum(int membersId, String cardNum) {
		Member member = memberMapper.getMemberById(membersId);

		member.setStatus(1); // 1-정회원 으로 변경
		member.setCardNum(cardNum); // 회원카드 추가

		return memberMapper.updateMemberCardnum(member);
	}

	// 4) 도서 시스템 - 도서 연체 (status)
	@Override
	public int updateMemberOverdue(Member member) {

		member.setStatus(2); // 2-대출정지 로 변경

		return memberMapper.updateMemberOverdue(member);
	}

	// 5) 도서 시스템 - 도서 대출 (loanCount)
	@Override
	public int updateMemberLoanCount(Member member) {

		member.setStatus(2); // 2-대출정지 로 변경

		return memberMapper.updateMemberLoanCount(member);
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

		member.setStatus(0); // 준회원
		member.setCardNum(null); // 회원 카드 번호 기본값
		member.setLoanCount(0); // 현재 대출 권수 기본값

		member.setJoinDate(joinDate); // 가입 날짜 설정
		member.setLeaveDate(null); // 탈퇴 날짜 기본값

		// 비밀번호 암호화
		String encodedPassword = passwordEncoder.encode(member.getPassword());
		member.setPassword(encodedPassword);

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