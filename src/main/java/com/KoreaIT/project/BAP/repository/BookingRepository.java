package com.KoreaIT.project.BAP.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.KoreaIT.project.BAP.vo.Booking;

@Mapper
public interface BookingRepository {

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();

	@Insert("""
			INSERT INTO booking
				SET regDate = NOW(),
				updateDate = NOW(),
				orderId = #{orderId},
				comp_id = #{comp_id},
				prod_id = #{prod_id},
				customerName = #{customerName},
				cellphoneNo = #{cellphoneNo},
				start_date = #{start_date},
				end_date = #{end_date},
				countOfAdult = #{countOfAdult},
				countOfChild = #{countOfChild}
			""")
	void doWrite(String orderId, int comp_id, int prod_id, String customerName, String cellphoneNo, String start_date, String end_date, int countOfAdult, int countOfChild);

	
	@Select("""
			SELECT *
				FROM booking
				WHERE orderId = #{orderId}
			""")
	Booking getBookingByOrderId(String orderId);

	@Select("""
			SELECT *
				FROM booking
				WHERE cellphoneNo = #{cellphoneNo}
			""")
	Booking getBookingByCellphoneNo(String cellphoneNo);

	@Select("""
			SELECT b.*, 
				c.name AS extra__compName,
				p.roomType AS extra__prodRoomType,
				p.fee AS extra__prodFee
				FROM booking AS b
				LEFT JOIN company AS c
				ON b.comp_id = c.id
				LEFT JOIN product AS p
				ON b.prod_id = p.id
				WHERE b.cellphoneNo = #{cellphoneNo}
				GROUP BY b.id
			""")
	List<Booking> getForPrintBookingsByCellphoneNo(String cellphoneNo);
}
