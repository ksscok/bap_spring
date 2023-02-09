package com.KoreaIT.project.BAP.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.CancelReasonRepository;
import com.KoreaIT.project.BAP.vo.CancelReason;

@Service
public class CancelReasonService {
	
public CancelReasonRepository cancelReasonRepository;
	
	@Autowired
	public CancelReasonService(CancelReasonRepository cancelReasonRepository) {
		this.cancelReasonRepository = cancelReasonRepository;
	}

	public void doWrite(int booking_id, String memberType, String title, String body, String extra__prodFee) {
		
		int cancelAmount = Integer.parseInt(extra__prodFee);
		
		cancelReasonRepository.doWrite(booking_id, memberType, title, body, cancelAmount);
	}

	public CancelReason getCancelReasonByBooking_id(int Booking_id) {
		return cancelReasonRepository.getCancelReasonByBooking_id(Booking_id);
	}
}
