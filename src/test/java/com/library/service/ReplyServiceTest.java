//package com.library.service;
//
//import static org.assertj.core.api.Assertions.assertThat;
//import static org.mockito.ArgumentMatchers.any;
//import static org.mockito.Mockito.times;
//import static org.mockito.Mockito.verify;
//import static org.mockito.Mockito.when;
//
//import java.sql.Timestamp;
//import java.util.Arrays;
//
//import org.junit.After;
//import org.junit.Before;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//import org.mockito.junit.MockitoJUnitRunner;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.context.SecurityContext;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.library.mapper.ReplyMapper;
//import com.library.model.Reply;
//
//@RunWith(MockitoJUnitRunner.class)
//@Transactional
//public class ReplyServiceTest {
//
//	@Mock
//	private Reply reply; // Mock 객체 설정
//	
//	@Mock
//	private ReplyMapper replyMapper; // Mock 객체 설정
//
//	@InjectMocks
//	private ReplyServiceImpl replyService; // 구현체 사용
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
//    public void testInsertReply() {
//    	// Given: SecurityContext에 관리자 사용자 등록
//        SecurityContext context = SecurityContextHolder.createEmptyContext();
//        Authentication auth = new UsernamePasswordAuthenticationToken("admin", "{bcrypt}$2a$10$xFP4Nsk0kAag4QsQ1FnMzeh3TyJMjf96q5VKNg5fKv410DRnUtj1e", 
//                Arrays.asList(new SimpleGrantedAuthority("ROLE_ADMIN")));
//        context.setAuthentication(auth);
//        SecurityContextHolder.setContext(context);
//    	
//    	// Given: 댓글 객체를 생성
//        reply = Reply.builder()
//        		.repliesId(100)
//        		.originArticleId(2)
//        		.authorId(0)
//        		.content("테스트 댓글")
//        		.createDate(new Timestamp(System.currentTimeMillis()))
//        		.updateDate(new Timestamp(System.currentTimeMillis()))
//        		.status(0)
//        		.build();
//
//        System.out.println(reply.getContent());
//        
//        when(replyMapper.insertReply(any(Reply.class))).thenReturn(1);
//        
//        // When: 댓글을 삽입
//        int result = replyService.insertReply(reply);
//        
//        System.out.println(result);
//
//        // Then: 정상적으로 삽입되었는지 검증(1이상 이어야 함)
//        assertThat(result).isGreaterThanOrEqualTo(1);
//        
//        // Verify: insertReply가 실제로 호출되었는지 확인
//        verify(replyMapper, times(1)).insertReply(any(Reply.class));
//    
//    }
//	
//	
//}
