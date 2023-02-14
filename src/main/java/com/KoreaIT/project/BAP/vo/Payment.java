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
	private int payMBId; // 은행 번호인데 은행 부분 어떻게 해야할 지 아직 몰라서 고민중
	private String requestedAt;
	private String approvedAt;
	private String type;
	private String cancels;
	private String lastTransactionKey;
	private int totalAmount;
	private int balanceAmount;
	private int suppliedAmount;
	private int vat;
	
	
}

