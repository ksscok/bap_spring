package com.KoreaIT.project.BAP.service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.BookingRepository;

@Service
public class BookingService {
	
	BookingRepository bookingRepository;
	
	@Autowired
	public BookingService(BookingRepository bookingRepository) {
		this.bookingRepository = bookingRepository;
	}

	public int getLastInsertId() {
		return bookingRepository.getLastInsertId();
	}

	public int getDiffBetweenChkinChkout(String start_date, String end_date) {
		// 체크인 날짜를 localDateTime 타입화 시작
		String[] strin = start_date.split("-");
		int[] chkin = {Integer.parseInt(strin[0]), Integer.parseInt(strin[1]), Integer.parseInt(strin[2])};
		
		LocalDate startDate = LocalDate.of(chkin[0],chkin[1],chkin[2]);
		LocalDateTime date1 = startDate.atStartOfDay();
		// 체크인 날짜를 localDateTime 타입화 끝
		
		// 체크아웃 날짜를 localDateTime 타입화 시작
		String[] strout = end_date.split("-");
		int[] chkout = {Integer.parseInt(strout[0]), Integer.parseInt(strout[1]), Integer.parseInt(strout[2])};
		
		LocalDate endDate = LocalDate.of(chkout[0],chkout[1],chkout[2]);
		LocalDateTime date2 = endDate.atStartOfDay();
		// 체크아웃 날짜를 localDateTime 타입화 끝
		
		int betweenDays = (int) Duration.between(date1, date2).toDays();
		  
		return betweenDays;
	}

	public Long getBookingByorderId(String orderId) {
		return bookingRepository.getBookingByorderId(orderId);
	}

	public void doWrite(String orderId, int comp_id, int prod_id, String customerName, String start_date, String end_date, int countOfAdult, int countOfChild) {
		bookingRepository.doWrite(orderId, comp_id, prod_id, customerName, start_date, end_date, countOfAdult, countOfChild);
	}
}
