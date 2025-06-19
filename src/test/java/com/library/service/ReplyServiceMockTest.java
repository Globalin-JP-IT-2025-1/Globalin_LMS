//package com.library.service;
//
//import static org.assertj.core.api.Assertions.assertThat;
//import static org.mockito.ArgumentMatchers.any;
//import static org.mockito.Mockito.times;
//import static org.mockito.Mockito.verify;
//import static org.mockito.Mockito.when;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import org.junit.After;
//import org.junit.Before;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//import org.mockito.junit.MockitoJUnitRunner;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.library.mapper.ReplyMapper;
//import com.library.model.Reply;
//import com.library.service.impl.ReplyServiceImpl;
//
//@RunWith(MockitoJUnitRunner.class)
//@Transactional
//public class ReplyServiceMockTest {
//	
//	@Mock
//	private ReplyMapper mockReplyMapper; // Mock 객체 설정
//
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
//    	// Given: 댓글 객체를 생성
//        Reply reply = Reply.builder()
//        		.repliesId(100)
//        		.originArticleId(2)
//        		.authorId(0)
//        		.content("테스트 댓글")
//        		.build();
//
//        System.out.println("ServiceTest: " +
//					reply.getRepliesId() + ", " +
//		            reply.getOriginArticleId() + ", " +
//		            reply.getAuthorId() + ", " +
//		            reply.getContent() + ", " +
//		            reply.getCreateDate() + ", " +
//		            reply.getUpdateDate() + ", " +
//		            reply.getStatus()
//			);
//        
//        when(mockReplyMapper.insertReply(any(Reply.class))).thenReturn(1);
//        
//        // When: 댓글을 삽입
//        int result = replyService.insertReply(reply);
//        
//        System.out.println(result);
//
//        // Then: 정상적으로 삽입되었는지 검증(1이상 이어야 함)
//        assertThat(result).isGreaterThanOrEqualTo(1);
//    
//    }
//    
//    @Test
//    public void testGetAllRepliesByArticlesId() {
//    	List<Reply> mockList = new ArrayList<>();
//    	mockList.add(new Reply()); // 또는 Reply.builder().content("테스트").build();
//
//    	when(mockReplyMapper.getAllRepliesByArticlesId(2)).thenReturn(mockList);
//
//		
//		// Call the method under test
//		List<Reply> replyList = replyService.getAllRepliesByArticlesId(2);
//		
//		// Assert the result
//		assertThat(replyList.size()).isGreaterThanOrEqualTo(1);
//    
//    }
//	
//	
//}
