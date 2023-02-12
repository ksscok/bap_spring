package com.KoreaIT.project.BAP.vo;

import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

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

	private String extra__writerName;
	private boolean actorCanChangeData;

	public String getForPrintBody() {
		return this.body.replaceAll("\n", "<br />");
	}

	public int getForPrintBeforeDays() {

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();

		String formatedNow = format.format(now);

		// 체크인 날짜를 localDateTime 타입화 시작
		String[] strin = this.regDate.replaceAll(" ", "-").split("-");
		int[] chkin = { Integer.parseInt(strin[0]), Integer.parseInt(strin[1]), Integer.parseInt(strin[2]) };

		LocalDate startDate = LocalDate.of(chkin[0], chkin[1], chkin[2]);
		LocalDateTime date1 = startDate.atStartOfDay();
		// 체크인 날짜를 localDateTime 타입화 끝

		// 체크아웃 날짜를 localDateTime 타입화 시작
		String[] strout = formatedNow.replaceAll(" ", "-").split("-");
		int[] chkout = { Integer.parseInt(strout[0]), Integer.parseInt(strout[1]), Integer.parseInt(strout[2]) };

		LocalDate endDate = LocalDate.of(chkout[0], chkout[1], chkout[2]);
		LocalDateTime date2 = endDate.atStartOfDay();
		// 체크아웃 날짜를 localDateTime 타입화 끝

		int betweenDays = (int) Duration.between(date1, date2).toDays();

		return betweenDays;
	}
}
