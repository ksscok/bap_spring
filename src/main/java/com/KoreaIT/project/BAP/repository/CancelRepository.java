package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CancelRepository {

	@Insert("""
			INSERT INTO cancel
				SET regDate = NOW(),
					updateDate = NOW(),
					booking_id = #{booking_id},
					title = #{title},
					`body` = #{body},
					transactionKey = #{transactionKey},
					lastTotalAmount = #{lastTotalAmount},
					pay_point = #{pay_point},
					paidRealAmount = #{paidRealAmount}
			""")
	void doWrite(int booking_id, String title, String body, String transactionKey, int lastTotalAmount,
			int pay_point, int paidRealAmount);
	
}
