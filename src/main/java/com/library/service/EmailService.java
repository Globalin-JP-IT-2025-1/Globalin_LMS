package com.library.service;

import javax.annotation.PostConstruct;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.library.model.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
/* @AllArgsConstructor */
public class EmailService {
	private JavaMailSender mailSender;
	
	@Value("${spring.mail.username}")
    private String FROM_EMAIL;
	
	@PostConstruct
    public void init() {
		/* System.out.println("✅ 로드된 이메일 주소: " + FROM_EMAIL); */
    }
	
	// 회원 가입 여부 성공 메일 보내기
	public void sendUsername(Member member) {
		try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

            messageHelper.setFrom(FROM_EMAIL); // 보내는 사람
            messageHelper.setTo(member.getEmail()); // 받는 사람
            messageHelper.setSubject("[글로벌인 도서관] 회원 가입 여부 확인"); // 제목
            messageHelper.setText("안녕하세요. " + member.getName()  + "님! 글로벌인 도서관 입니다.\n\n" + 
            		"회원 가입 여부 확인이 완료되어, 아이디와 회원 카드 번호를 보내드립니다.\n" +
            		"- 아이디 : " + member.getUsername() + "\n" + 
            		"- 회원 카드 번호 : " + member.getCardNum() + "\n\n" + 
            		"좋은 하루 되세요!"); // 내용

            mailSender.send(message);
            log.info("메일 전송 성공: {}", member.getEmail());
        } catch (Exception e) {
        	log.error("메일 전송 실패: {}", e.getMessage());
        }
	}
	
	// 비밀번호 초기화 메일 보내기
	public void sendResetPassword(Member member, String randomPassword) {
		try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

            messageHelper.setFrom(FROM_EMAIL); // 보내는 사람
            messageHelper.setTo(member.getEmail()); // 받는 사람
            messageHelper.setSubject("[글로벌인 도서관] 비밀번호 재발급"); // 제목
            messageHelper.setText("안녕하세요. " + member.getName()  + "님! 글로벌인 도서관 입니다.\n\n" + 
            		"비밀번호 재설정을 위한 랜덤 비밀번호를 보내드립니다.\n" +
            		randomPassword + "\n\n" + 
            		"반드시 비밀번호 재설정하시기 바랍니다.\n\n" +
            		"좋은 하루 되세요!"); // 내용

            mailSender.send(message);
            log.info("메일 전송 성공: {}", member.getEmail());
        } catch (Exception e) {
        	log.error("메일 전송 실패: {}", e.getMessage());
        }
	}

	// 회원 가입 축하 메일 보내기
	public void sendRegister(Member member) {
		try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

            messageHelper.setFrom(FROM_EMAIL); // 보내는 사람
            messageHelper.setTo(member.getEmail()); // 받는 사람
            messageHelper.setSubject("[글로벌인 도서관] 비밀번호 재발급"); // 제목
            messageHelper.setText("안녕하세요. " + member.getName()  + "님! 글로벌인 도서관 입니다.\n\n" + 
            		"회원가입을 축하드립니다!!\n" +
            		"좋은 하루 되세요!"); // 내용

            mailSender.send(message);
            log.info("메일 전송 성공: {}", member.getEmail());
        } catch (Exception e) {
        	log.error("메일 전송 실패: {}", e.getMessage());
        }
	}

}
