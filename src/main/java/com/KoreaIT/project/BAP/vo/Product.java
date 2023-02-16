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
	private int comp_id;
	private String roomType;
	private int numberOfRooms;
	private int fee;
	private String countOfRoom;
	private String countOfAdult;
	private String countOfChild;
	private String includeMeals;
	private String smokingType;
	
	private String comName;
	private String comAddr;
	private int extra__minFee;
	private String extra__showTotalFee;
}

