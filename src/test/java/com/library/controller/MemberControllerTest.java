package com.library.controller;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;

import com.library.service.MemberService;
import com.library.vo.Member;

@RunWith(MockitoJUnitRunner.class)
public class MemberControllerTest {

    @Mock
    private MemberService memberService;

    @InjectMocks
    private MemberController memberController;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        System.out.println("테스트 시작...");
    }
    
    @After
    public void closeTest() {
    	System.out.println("테스트 종료...");
    }
    
    // 회원 목록 조회 테스트
    @Test
    public void testGetAllMembers() {
    	// given
        List<Member> mockMemberList = Arrays.asList(
    		new Member(1, 0, null, "bob@google.com", "bob456", "Bob", "010-5678-5678", "54321", "부산시 해운대구 마바로 2", Date.valueOf(LocalDate.now()), null),
    		new Member(2, 1, "20250601-A00001", "charlie@daum.net", "charlie789", "Charlie", "010-9876-9876", "67890", "대구시 수성구 사아로 3", Date.valueOf("2025-06-01"), null),
    		new Member(3, 2, "20250501-A12345", "alice@naver.com", "alice123", "Alice", "010-1234-1234", "12345", "서울시 영등포구 가나다로 1", Date.valueOf("2025-05-01"), null)
        );
        
        when(memberService.getAllMembers()).thenReturn(mockMemberList);

        // when
        List<Member> result = memberService.getAllMembers();
        
        // then
        assertThat(result.size()).isEqualTo(3); // 멤버 수 일치하는지
        assertThat(result.get(0).getName()).isEqualTo("Bob"); // 이름 일치하는지
        assertThat(result.get(1).getEmail()).isEqualTo("charlie@daum.net"); // 이메일이 일치하는지
    }
    
    // 회원 상세 조회 테스트
    @Test
    public void testGetMemberById() {
    	// given
        Member mockMember = new Member(2, 1, "20250601-A00001", "charlie@daum.net", "charlie789", "Charlie", "010-9876-9876", "67890", "대구시 수성구 사아로 3", Date.valueOf("2025-06-01"), null);
        when(memberService.getMemberById(2)).thenReturn(mockMember);
        
        // when
        Member result = memberService.getMemberById(2);
        
        // then
        assertThat(result.getName()).isEqualTo("Charlie"); // 이름 일치하는지
        assertThat(result.getCardNum()).isEqualTo("20250601-A00001"); // 회원카드번호가 일치하는지
    }
    
    // 회원 상세 조회 테스트
    @Test
    public void testGetMemberById_NotFound() {
    	// given
        when(memberService.getMemberById(9999)).thenReturn(null);
        
        // when
        Member result = memberService.getMemberById(9999);
        
        // then
        assertThat(result).isNull(); // 없는 회원일 경우 null 반환하는지
    }
    
}
