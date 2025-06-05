package com.library.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TokenMapper {

	int addToken(int membersId);
	
}
