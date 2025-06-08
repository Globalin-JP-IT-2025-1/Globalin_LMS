package com.library.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.dto.CardnumSerial;
import com.library.dto.Member;
import com.library.mapper.MemberMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberService {
	private final MemberMapper memberMapper;
	private final TokenBlacklistService tokenBlacklistService;
	private final PasswordEncoder passwordEncoder;
	
	public boolean canAccess(int membersId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = authentication.getName(); // 현재 로그인한 사용자
        
        Member member = getMemberById(membersId); // id로 회원 정보 조회
        return member.getUsername().equals(currentUsername); // 요청한 정보가 본인 것인지 확인
    }
	
	// 회원 목록 조회
	public List<Member> getAllMembers() {
		return memberMapper.getAllMembers();
	}

	// 회원 정보 조회
	// membersId 기반
	public Member getMemberById(int membersId) {
		return memberMapper.getMemberById(membersId);
	}
	
	// username 기반
	public Member getMemberByUsername(String username) {
		return memberMapper.getMemberByUsername(username);
	}
	
	// email 기반
	public Member getMemberByEmail(String email) {
		return memberMapper.getMemberByEmail(email);
	}
	
	// 회원 정보 수정
	public int updateMemberInfo(Member member) {
		return memberMapper.updateMemberInfo(member);
	}
	
	// 회원 탈퇴
	@Transactional
	public int updateMemberLeave(int membersId, Map<String, String> tokens) {
		Member member = memberMapper.getMemberById(membersId);
		
		LocalDateTime leaveDate = LocalDateTime.now();
		Timestamp tsLeaveDate = Timestamp.valueOf(leaveDate);
		
		member.setStatus(3); // 탈퇴회원으로 상태 변경
		member.setLeaveDate(tsLeaveDate); // 탈퇴날짜 추가
		
		// 탈퇴 회원의 토큰을 블랙리스트에 추가
		tokenBlacklistService.addAccessTokenToBlacklist(tokens.get("aToken"));
		tokenBlacklistService.addRefreshTokenToBlacklist(tokens.get("rToken"));

		return memberMapper.updateMemberLeave(member);
	}
	
	// 회원 등급 수정
	@Transactional
	public int updateMemberGrade(int membersId) {
		Member member = memberMapper.getMemberById(membersId);
		CardnumSerial cardnumSerial = memberMapper.getCardnumSerial();
		
		// 오늘날짜
		LocalDateTime currentDateReal = LocalDateTime.now();
        DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyyMMdd");
        String strCurrentDateReal = currentDateReal.format(formatDate);
        
        // DB상 마지막 날짜
        Timestamp currentDateDB = cardnumSerial.getCurrentDate();
        SimpleDateFormat formatTimestamp = new SimpleDateFormat("yyyyMMdd");
        String strCurrentDateDB = formatTimestamp.format(currentDateDB);
		
        String today = "";
        int serial = 0;
        
		if (!strCurrentDateReal.equals(strCurrentDateDB)) {
			Timestamp tsCurrentDateReal = Timestamp.valueOf(currentDateReal);
			cardnumSerial.setCurrentDate(tsCurrentDateReal);
			cardnumSerial.setSerial(1);
			memberMapper.updateCardnumSerial(cardnumSerial);
			
			today = strCurrentDateReal;
			serial = 1;
		} else {
			today = strCurrentDateDB;
			serial = cardnumSerial.getSerial();
		}

		String cardNum = today + "-" + String.format("%06d", serial);; // 카드발급날짜 8자리 - 000001

		member.setStatus(1); // 정회원
		member.setCardNum(cardNum);

		return memberMapper.updateMemberGrade(member);
	}
	
	// 회원 삭제
	public int deleteMember(int membersId) {
		return memberMapper.deleteMember(membersId);
	}
	
	// 회원 등록
	public int insertMember(Member member) {
		LocalDateTime now = LocalDateTime.now();
        Timestamp joinDate = Timestamp.valueOf(now);
        
		member.setStatus(0); // 준회원
		member.setCardNum(null);
		member.setJoinDate(joinDate); // 가입 날짜 설정
		member.setLeaveDate(null);
		
		// 비밀번호 암호화
		String encodedPassword = passwordEncoder.encode(member.getPassword());
		member.setPassword(encodedPassword);

		return memberMapper.insertMember(member);
	}
	
	// 비밀번호 초기화
	public String resetPassword(Member member) {
		
		String randomPassword = generateRandomPassword();
		
		// 비밀번호 암호화
		String encodedPassword = passwordEncoder.encode(randomPassword);
		member.setPassword(encodedPassword);
		
		return randomPassword;
	}
	
	// 랜덤 비밀번호 생성기 (8자리)
	private String generateRandomPassword() {
        return UUID.randomUUID().toString().substring(0, 8);
    }

}