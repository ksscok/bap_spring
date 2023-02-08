package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CancellationApplicationRepository {
	
	@Insert("""
			INSERT INTO cancel
				SET regDate = NOW(),
					updateDate = NOW(),
					booking_id = #{booking_id},
					title = #{title},
					`body` = #{body},
					cancelAmount = #{cancelAmount},
			""")
	void doWrite(int booking_id, String title, String body, int cancelAmount);
}
