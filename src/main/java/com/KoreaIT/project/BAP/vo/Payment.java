package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
	private int id;
	private String regDate;
	private String updateDate;
	private String paymentKey;
	private int booking_id;
	private String status;
	private String method;
	private int payMBId;
	private String requestedAt;
	private String approvedAt;
	private String type;
	private String cancels;
	private String lastTransactionKey;
	private int totalAmount;
	private int balanceAmount;
	private int pay_point;
	private int suppliedAmount;
	private int vat;
	
	
}

