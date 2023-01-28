package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface BookingRepository {

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();

	@Select("""
			SELECT *
				FROM booking
				WHERE orderId = #{orderId}
			""")
	Long getBookingByorderId(String orderId);

	@Insert("""
			INSERT INTO booking
				SET regDate = NOW(),
				updateDate = NOW(),
				orderId = #{orderId},
				comp_id = #{comp_id},
				prod_id = #{prod_id},
				customerName = #{customerName},
				start_date = #{start_date},
				end_date = #{end_date},
				countOfAdult = #{countOfAdult},
				countOfChild = #{countOfChild}
			""")
	void doWrite(String orderId, int comp_id, int prod_id, String customerName, String start_date, String end_date, int countOfAdult, int countOfChild);
}
