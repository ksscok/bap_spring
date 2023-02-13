package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Point {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int payment_id;
	private int p_point;
	
	private String extra__compName;
	private int extra__balanceAmount;
	
}

