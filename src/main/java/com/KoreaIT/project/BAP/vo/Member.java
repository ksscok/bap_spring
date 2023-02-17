package com.KoreaIT.project.BAP.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private long id;
	private String regDate;
	private String updateDate;
	private String memberType;
	private String loginId;
	private String loginPw;
	private int authLevel;
	private String name;
	private String cellphoneNo;
	private String email;
	private int m_point;
	private boolean delStatus;
	private String delDate;
}
