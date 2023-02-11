package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Wish {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int comp_id;
	
}

