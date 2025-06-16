package com.library.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.library.model.CardnumSerial;

@Mapper
public interface CardnumSerialMapper {
	// 회원카드 관련
	CardnumSerial getCardnumSerial(); // 마지막 시리얼 조회
	int updateCardnumSerial(CardnumSerial cardnumSerial); // 업데이트

}