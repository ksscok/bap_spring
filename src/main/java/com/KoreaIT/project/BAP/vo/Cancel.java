package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cancel {
	private int id;
	private String regDate;
	private String updateDate;
	private int booking_id;
	private String title;
	private String body;
	private String transactionKey;
	private int lastTotalAmount;
	private int pay_point;
	private int paidRealAmount;
	
}

