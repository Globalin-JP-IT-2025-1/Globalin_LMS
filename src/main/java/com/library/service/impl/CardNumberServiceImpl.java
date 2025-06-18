package com.library.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Service;

import com.library.mapper.CardnumSerialMapper;
import com.library.model.CardnumSerial;
import com.library.service.CardNumberService;

import lombok.AllArgsConstructor;

@Service("cardNumberService")
@AllArgsConstructor
public class CardNumberServiceImpl implements CardNumberService {
	private final CardnumSerialMapper cardnumSerialMapper;

	// 회원카드 번호 생성기 (15자리)
	@Override
	public String generateCardNumber() {
		// 오늘 날짜 설정
		LocalDateTime currentDateReal = LocalDateTime.now();
		DateTimeFormatter formatDate = DateTimeFormatter.ofPattern("yyyyMMdd");
		String strCurrentDateReal = currentDateReal.format(formatDate);
		
		// DB상 마지막 날짜 가져오기
		CardnumSerial cardnumSerial = cardnumSerialMapper.getCardnumSerial();
		
		Timestamp currentDateDB = cardnumSerial.getCurrentDate();
		SimpleDateFormat formatTimestamp = new SimpleDateFormat("yyyyMMdd");
		String strCurrentDateDB = formatTimestamp.format(currentDateDB);

		String today = "";
		int serial = 0;
		
		// 오늘 날짜와 DB상 날짜가 일치하지 않는 경우 : DB에 오늘날짜 & 1로 변경
		if (!strCurrentDateReal.equals(strCurrentDateDB)) { 
			today = strCurrentDateReal;
			serial = 1;
			
			Timestamp tsCurrentDateReal = Timestamp.valueOf(currentDateReal);
			cardnumSerial.setCurrentDate(tsCurrentDateReal);
			cardnumSerial.setSerial(1);
			cardnumSerialMapper.updateCardnumSerial(cardnumSerial);
			
		// 오늘 날짜와 DB상 날짜가 일치하는 경우 : DB에 1증가하여 변경
		} else {
			today = strCurrentDateDB;
			serial = cardnumSerial.getSerial() + 1;
			
			cardnumSerial.setSerial(serial);
			cardnumSerialMapper.updateCardnumSerial(cardnumSerial);
		}
		
		// 카드발급날짜 8자리 - 000001
		String cardNum = today + "-" + String.format("%06d", serial); 

		return cardNum;
	}

}
