package com.KoreaIT.project.BAP.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
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

	// 하루에 한번씩 갱신되도록
	// 만약 예약 상태가 예약 완료(done)인데 체크아웃날짜(end_date)가 오늘 날짜보다 전 날짜가 된다면 해당 예약테이블의 예약 상태를 예약 만료(expired)로 변경
	@Scheduled(fixedDelay = 86400000, initialDelay = 1000)
	public void changeStatus_ifEnd_dateIsPastDate() throws ParseException {
		
		List<Booking> bookings = getAllBookings();
		
		for(Booking booking : bookings) {
			// 현재 날짜가 해당 예약의 체크아웃 날짜를 지남
			if(booking.getStatus().equals("done")) {
				SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
			    Date today = new Date();
				Date end = format.parse(booking.getEnd_date());
				
				if(today.compareTo(end) == 1) {
					bookingRepository.doModifyStatus(booking.getId(), "expired");
					// status 한글 번역화
					modifyExtra__status(booking);
				}
			// 예약 페이지에서 결제하기 버튼 누르고 결제 취소했을 때 생긴 예약테이블 지우기 위한 로직
			}else if(booking.getStatus().equals("await")) {
				bookingRepository.doDelete(booking.getId());
			}
		}
		   
	}
	
	private List<Booking> getAllBookings() {
		return bookingRepository.getAllBookings();
	}

	public int getLastInsertId() {
		return bookingRepository.getLastInsertId();
	}

	public void doWrite(String orderId, int comp_id, int prod_id, String customerName, String cellphoneNo, String start_date, String end_date, int diff, int countOfAdult, int countOfChild, int lastTotalAmount, int p_point, int paidRealAmount) {
		bookingRepository.doWrite(orderId, comp_id, prod_id, customerName, cellphoneNo, start_date, end_date, diff, countOfAdult, countOfChild, lastTotalAmount, p_point, paidRealAmount);
	}

	public Booking getBookingByOrderId(String orderId) {
		
		Booking booking = bookingRepository.getBookingByOrderId(orderId);
		
		// status 한글 번역화
		modifyExtra__status(booking);
		
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
			
			// status 한글 번역화
			modifyExtra__status(booking);
		}
		
		return bookings;
	}

	public Booking getBookingById(int id) {
		return bookingRepository.getBookingById(id);
	}

	public int getBookingsCount(String cellphoneNo, String searchKeywordTypeCode, String searchKeyword) {
		return bookingRepository.getBookingsCount(cellphoneNo, searchKeywordTypeCode, searchKeyword);
	}

	public List<Booking> getBookingsByComp_id(int comp_id) {
		List<Booking> bookings = bookingRepository.getBookingsByComp_id(comp_id);
		
		for (Booking booking : bookings) {
			// 예약 리스트 페이지에서 체크인, 체크아웃에 요일 보여주기 위한 날짜방식
			booking.setExtra__dateAndDayOfTheWeekOfChkin(Ut.getDateAndDayOfTheWeek(booking.getStart_date()));
			booking.setExtra__dateAndDayOfTheWeekOfChkout(Ut.getDateAndDayOfTheWeek(booking.getEnd_date()));
			
			// status 한글 번역화
			modifyExtra__status(booking);
		}
		
		return bookings;
	}

	public int getBookingsCountByComp_id(int comp_id) {
		return  bookingRepository.getBookingsCountByComp_id(comp_id);
	}

	public void doModifyStatus(int id, String status) {
		bookingRepository.doModifyStatus(id, status);
	}

	private void modifyExtra__status(Booking booking) {
		
		if(booking.getStatus().equals("done")) {
			booking.setExtra__status("예약 완료");
		}
		else if(booking.getStatus().equals("expired")) {
			booking.setExtra__status("예약 만료");
		}
		else if(booking.getStatus().equals("cancel_apply")) {
			booking.setExtra__status("예약 취소 신청");
		}
		else if(booking.getStatus().equals("cancel")) {
			booking.setExtra__status("예약 취소 완료");
		}
	}
	
}
