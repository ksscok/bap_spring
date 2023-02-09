package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class cancellationApplication {
	private int id;
	private String regDate;
	private String updateDate;
	private int booking_id;
	private String title;
	private String body;
	private int cancelAmount;
	
	
}

