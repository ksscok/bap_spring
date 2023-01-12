package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Company {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private String address;
	private String accommodationType;
	private int host_id;
	
	private int extra__productFee;
	private int extra__minFee;
}
