package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface BookingRepository {

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();
}
