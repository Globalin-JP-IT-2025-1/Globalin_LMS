//package com.library.service;
//
//import static org.assertj.core.api.Assertions.assertThat;
//import static org.mockito.ArgumentMatchers.any;
//import static org.mockito.Mockito.times;
//import static org.mockito.Mockito.verify;
//import static org.mockito.Mockito.when;
//
//import org.junit.After;
//import org.junit.Before;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//import org.mockito.junit.MockitoJUnitRunner;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.library.mapper.MemberMapper;
//import com.library.model.Member;
//import com.library.service.impl.MemberServiceImpl;
//
//@RunWith(MockitoJUnitRunner.class)
//@Transactional
//public class MemberServiceMockTest {
//	
//	@Mock
//	private MemberMapper memberMapper; // Mock 객체 설정
//
//	@InjectMocks
//	private MemberServiceImpl memberService; // 구현체 사용
//	
//	@Mock
//	private PasswordEncoder passwordEncoder;
//
//    @Before
//    public void setUp() { 
//        MockitoAnnotations.initMocks(this);
//        System.out.println("테스트 시작...");
//    }
//
//    @After
//    public void closeTest() { 
//        System.out.println("테스트 종료...");
//    }
//
//    @Test
//    public void testInsertMember() {
//
//    	// Given: 회원 객체를 생성
//        Member member = Member.builder()
//        		.username("test13")
//        		.password("password")
//        		.name("라길동") // 이름
//        	    .email("test13@test.com") // 이메일
//        	    .mobile("010-1234-1234") // 전화번호
//        	    .zipcode("12345") // 우편번호
//        	    .address("서울시 영등포구 가나다로 1") // 주소
//        	    .addressDetail("글로벌인 아파트") // 상세주소
//        		.build();
//        
//        System.out.println("member: " + member);
//        System.out.println("memberMapper: " + memberMapper);
//
//        System.out.println("ServiceTest: " +
//        		member.getUsername() + ", " +
//        		member.getPassword() + ", " +
//        		member.getName() + ", " +
//        		member.getEmail() + ", " +
//        		member.getMobile() + ", " +
//        		member.getZipcode() + ", " +
//        		member.getAddress() + ", " +
//        		member.getAddressDetail()
//			);
//        
//        //when(memberMapper.insertMember(member)).thenReturn(1);
//        
//        // When: 댓글을 삽입
//        int result = memberService.insertMember(member);
//        
//        System.out.println(result);
//
//        // Then: 정상적으로 삽입되었는지 검증(1이상 이어야 함)
//        assertThat(result).isGreaterThanOrEqualTo(1);
//        
//    }
//	
//	
//}
