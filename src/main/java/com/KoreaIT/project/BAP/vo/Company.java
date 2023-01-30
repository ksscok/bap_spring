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
	private String timeChkin;
	private String timeChkout;
	private String accommodationType;
	private int host_id;
	
	private int extra__productFee;
	private int extra__minFee;
	
	public String getForPrintRegDate() {
		return regDate.substring(2, 10);
	}

	public String getForPrintUpdateDate() {
		return regDate.substring(2, 8);
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
