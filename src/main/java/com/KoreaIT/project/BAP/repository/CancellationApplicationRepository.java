package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.CancellationApplication;

@Mapper
public interface CancellationApplicationRepository {
	
	@Insert("""
			INSERT INTO cancellationApplication
				SET regDate = NOW(),
					updateDate = NOW(),
					booking_id = #{booking_id},
					memberType = #{memberType},
					title = #{title},
					`body` = #{body},
					cancelAmount = #{cancelAmount}
			""")
	void doWrite(int booking_id, String memberType, String title, String body, int cancelAmount);

	@Select("""
			SELECT *
				FROM cancellationApplication
				WHERE booking_id = #{booking_id}
			""")
	CancellationApplication getCancellationApplicationServiceByBooking_id(int booking_id);
}
