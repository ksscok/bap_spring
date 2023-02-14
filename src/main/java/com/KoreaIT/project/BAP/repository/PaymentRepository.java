package com.KoreaIT.project.BAP.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.KoreaIT.project.BAP.vo.Payment;

@Mapper
public interface PaymentRepository {

	@Insert("""
			INSERT INTO payment
				SET regDate = NOW(),
					updateDate = NOW(),
					paymentKey = #{paymentKey},
					booking_id = #{bookingId},
					`status` = #{status},
					method = #{method},
					bank = #{bank},
					requestedAt = #{requestedAt},
					approvedAt = #{approvedAt},
					`type` = #{type},
					lastTransactionKey = #{lastTransactionKey},
					totalAmount = #{totalA},
					balanceAmount = #{balanceA},
					suppliedAmount = #{suppliedA},
					vat = #{vatA}
			""")
	void doWrite(String paymentKey, int bookingId, String status, String method, String bank, String requestedAt,
			String approvedAt, String type, String lastTransactionKey, int totalA, int balanceA, int suppliedA,
			int vatA);

	@Select("""
			SELECT *
				FROM payment
				WHERE booking_id = #{booking_id}
			""")
	Payment getPaymentByBooking_id(int booking_id);

	@Update("""
			UPDATE payment
				SET updateDate = NOW(), 
				`status` = 'CANCELED'
				WHERE id = #{id}
			""")
	void doModify(int id);

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();

}
