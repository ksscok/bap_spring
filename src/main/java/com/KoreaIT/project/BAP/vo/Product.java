package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
	private int id;
	private String regDate;
	private String updateDate;
	private int companyId;
	private String roomType;
	private int numberOfRooms;
	private int hostId;
	private int fee;
	
	private String comName;
	private String comAddr;
	private int extra__minFee;
}

