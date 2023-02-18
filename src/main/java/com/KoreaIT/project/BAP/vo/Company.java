package com.KoreaIT.project.BAP.vo;

import java.text.DecimalFormat;

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
	private String cellphoneNo;
	private String address;
	private String area;
	private String timeChkin;
	private String timeChkout;
	private String accommodationType;
	private long host_id;
	
	private int extra__productFee;
	private int extra__minFee;
	private String extra__avg;
	private int extra__avgStarCount;
	private int extra__reviewCount;
	private double extra__reviewRating;
	
	public String getForPrintRegDate() {
		return regDate.substring(2, 10);
	}

	public String getForPrintUpdateDate() {
		return regDate.substring(2, 8);
	}
	
	public String getForPrintReviewRating() {
		double value = extra__reviewRating;
		DecimalFormat df = new DecimalFormat("0.0");
		return df.format(value);
	}
	
	public String getForPrintAccommodationType() {
		
		switch(accommodationType) {
		case "hotel": 
			accommodationType = "호텔" ;
			break;
		case "motel": 
			accommodationType = "모텔" ;
			break;
		case "pension": 
			accommodationType = "펜션" ;
			break;
		case "guesthouse": 
			accommodationType = "게스트하우스" ;
			break;
		}
		
		return accommodationType;
	}
}
