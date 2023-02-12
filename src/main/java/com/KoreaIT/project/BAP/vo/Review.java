package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int comp_id;
	private int booking_id;
	private int rating;
	private String body;
	
	private int extra__beforeDays;
	private String extra__writerName;
	private boolean actorCanChangeData;
	
	public String getForPrintBody() {
		return this.body.replaceAll("\n", "<br />");
	}
}

