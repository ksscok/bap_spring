package com.KoreaIT.project.BAP.service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.BookingRepository;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Booking;

@Service
public class BookingService {
	
	public BookingRepository bookingRepository;
	
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

	public void doWrite(String orderId, int comp_id, int prod_id, String customerName, String cellphoneNo, String start_date, String end_date, int diff, int countOfAdult, int countOfChild) {
		bookingRepository.doWrite(orderId, comp_id, prod_id, customerName, cellphoneNo, start_date, end_date, diff, countOfAdult, countOfChild);
	}

	public Booking getBookingByOrderId(String orderId) {
		
		Booking booking = bookingRepository.getBookingByOrderId(orderId);
		
		if(booking.getStatus().equals("apply")) {
			booking.setExtra__status("예약 신청");
		} 
		else if(booking.getStatus().equals("authorization")) {
			booking.setExtra__status("예약 승인");
		}
		else if(booking.getStatus().equals("done")) {
			booking.setExtra__status("예약 완료");
		}
		else if(booking.getStatus().equals("cancel_apply")) {
			booking.setExtra__status("예약 취소 신청");
		}
		else {
			booking.setExtra__status("예약 취소 완료");
		}
		
		return booking;
	}

	public Booking getBookingByCellphoneNo(String cellphoneNo) {
		return bookingRepository.getBookingByCellphoneNo(cellphoneNo);
	}

	public List<Booking> getForPrintBookingsByCellphoneNo(String cellphoneNo, String searchKeywordTypeCode, String searchKeyword) {
		
		List<Booking> bookings = bookingRepository.getForPrintBookingsByCellphoneNo(cellphoneNo, searchKeywordTypeCode, searchKeyword);
		
		for (Booking booking : bookings) {
			// 예약 리스트 페이지에서 체크인, 체크아웃에 요일 보여주기 위한 날짜방식
			booking.setExtra__dateAndDayOfTheWeekOfChkin(Ut.getDateAndDayOfTheWeek(booking.getStart_date()));
			booking.setExtra__dateAndDayOfTheWeekOfChkout(Ut.getDateAndDayOfTheWeek(booking.getEnd_date()));
			
			if(booking.getStatus().equals("apply")) {
				booking.setExtra__status("예약 신청");
			} 
			else if(booking.getStatus().equals("authorization")) {
				booking.setExtra__status("예약 승인");
			}
			else if(booking.getStatus().equals("done")) {
				booking.setExtra__status("예약 완료");
			}
			else if(booking.getStatus().equals("cancel_apply")) {
				booking.setExtra__status("예약 취소 신청");
			}
			else {
				booking.setExtra__status("예약 취소 완료");
			}
		}
		
		return bookings;
	}

	public Booking getBookingById(int id) {
		return bookingRepository.getBookingById(id);
	}

	public int getBookingsCount(String cellphoneNo, String searchKeywordTypeCode, String searchKeyword) {
		return bookingRepository.getBookingsCount(cellphoneNo, searchKeywordTypeCode, searchKeyword);
	}

}
