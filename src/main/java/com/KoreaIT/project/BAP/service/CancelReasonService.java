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

	public void doModify(int booking_id, String title, String body) {
		cancelReasonRepository.doModify(booking_id, title, body);
	}

	public void doDelete(int booking_id) {
		cancelReasonRepository.doDelete(booking_id);
	}

}
