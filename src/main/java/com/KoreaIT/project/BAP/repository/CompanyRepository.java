package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CompanyRepository {

	@Insert("""
			INSERT into company
			SET regDate = NOW(),
			updateDate = NOW(),
			`name` = #{name},
			address = #{address}
			""")
	void register(String name, String address);

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();

}
