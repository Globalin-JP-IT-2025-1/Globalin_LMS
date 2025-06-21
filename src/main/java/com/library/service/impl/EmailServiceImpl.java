package com.library.service.impl;

import javax.annotation.PostConstruct;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.library.model.Member;
import com.library.service.EmailService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("emailService")
/* @AllArgsConstructor */
public class EmailServiceImpl implements EmailService {
	private JavaMailSender mailSender;
	
	@Value("${spring.mail.username}")
    private String FROM_EMAIL;
	
	@PostConstruct
    public void init() {
		/* System.out.println("✅ 로드된 이메일 주소: " + FROM_EMAIL); */
    }
	
	private MimeMessageHelper createMessage(String to, String subject, String body) throws MessagingException {
	    MimeMessage message = mailSender.createMimeMessage();
	    MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
	    helper.setFrom(FROM_EMAIL);
	    helper.setTo(to);
	    helper.setSubject(subject);
	    helper.setText(body);
	    return helper;
	}
	
	// 회원 가입 여부 성공 메일 보내기
	@Override
	public void sendRegisterMember(Member member) {
	    try {
	        String subject = "[글로벌인 도서관] 회원가입 완료 안내";
	        String body = "안녕하세요. " + member.getName() + "님! 글로벌인 도서관 입니다.\n\n" +
	                      "회원 가입 축하드립니다. 확인 차 내용 보내드립니다.\n" +
	                      "- 아이디 : " + member.getUsername() + "\n" +
	                      "- 회원 카드 번호 : (도서관 방문 후 이용이 가능합니다)" +
	                      "\n\n좋은 하루 되세요!";

	        MimeMessageHelper helper = createMessage(member.getEmail(), subject, body);
	        mailSender.send(helper.getMimeMessage());
	        log.info("메일 전송 성공: {}", member.getEmail());
	        
	    } catch (Exception e) {
	        log.error("메일 전송 실패: {}", e.getMessage());
	        
	    }
	}

	
	// 아이디 찾기 메일 보내기
	@Override
	public void sendFindUsername(Member member) {
		try {
			String subject = "[글로벌인 도서관] 아이디 찾기 안내";
			String body = "안녕하세요. " + member.getName()  + "님! 글로벌인 도서관 입니다.\n\n" + 
            		"아이디 찾기와 관련하여 회원님의 아이디를 보내드립니다.\n" +
            		"- 아이디 : " + member.getUsername() + "\n\n" +
            		"좋은 하루 되세요!";

			MimeMessageHelper helper = createMessage(member.getEmail(), subject, body);
	        mailSender.send(helper.getMimeMessage());
	        log.info("메일 전송 성공: {}", member.getEmail());
	        
	    } catch (Exception e) {
	        log.error("메일 전송 실패: {}", e.getMessage());
	        
	    }
	}
	
	// 비밀번호 재발급 메일 보내기
	@Override
	public void sendResetPassword(Member member, String randomPassword) {
		try {
			String subject = "[글로벌인 도서관] 비밀번호 재발급 안내";
			String body = "안녕하세요. " + member.getName()  + "님! 글로벌인 도서관 입니다.\n\n" + 
            		"비밀번호 재설정을 위한 임시 비밀번호를 보내드립니다.\n" +
            		"- 임시 비밀번호 : " + randomPassword + "\n\n" +
            		"반드시 비밀번호를 재설정하시기 바랍니다.\n\n" +
            		"좋은 하루 되세요!"; // 내용

			MimeMessageHelper helper = createMessage(member.getEmail(), subject, body);
	        mailSender.send(helper.getMimeMessage());
	        log.info("메일 전송 성공: {}", member.getEmail());
	        
	    } catch (Exception e) {
	        log.error("메일 전송 실패: {}", e.getMessage());
	        
	    }
	}

}
