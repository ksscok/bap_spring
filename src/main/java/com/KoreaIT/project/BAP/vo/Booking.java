package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booking {
	private int id;
	private String regDate;
	private String updateDate;
	private String orderId;
	private int comp_id;
	private int prod_id;
	private String customerName;
	private String cellphoneNo;
	private String start_date;
	private String end_date;
	
}

