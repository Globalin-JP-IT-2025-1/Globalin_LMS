package com.library.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CardnumSerial {
	
	private int cardnumSerialId;
	private Timestamp currentDate; // 이전 등록날짜
	private int serial; // 이전 등록날짜 기준 마지막 번호 

}
