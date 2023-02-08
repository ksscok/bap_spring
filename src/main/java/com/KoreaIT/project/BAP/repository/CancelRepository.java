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
					taxExemptionAmount = #{taxExemptionAmount},
					easyPayDiscountAmount = #{easyPayDiscountAmount},
					cancelAmount = #{cancelAmount},
					taxFreeAmount = #{taxFreeAmount},
					refundableAmount = #{refundableAmount}
			""")
	void doWrite(int booking_id, String title, String body, String transactionKey, int taxExemptionAmount,
			int easyPayDiscountAmount, int cancelAmount, int taxFreeAmount, int refundableAmount);

}
