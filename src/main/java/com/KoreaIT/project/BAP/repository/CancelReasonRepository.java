package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.CancelReason;

@Mapper
public interface CancelReasonRepository {
	
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
				FROM cancelReason
				WHERE booking_id = #{booking_id}
			""")
	CancelReason getCancelReasonByBooking_id(int booking_id);
}
