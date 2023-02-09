package com.KoreaIT.project.BAP.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.CancellationApplicationRepository;
import com.KoreaIT.project.BAP.vo.CancellationApplication;

@Service
public class CancellationApplicationService {
	
public CancellationApplicationRepository cancellationApplicationRepository;
	
	@Autowired
	public CancellationApplicationService(CancellationApplicationRepository cancellationApplicationRepository) {
		this.cancellationApplicationRepository = cancellationApplicationRepository;
	}

	public void doWrite(int booking_id, String memberType, String title, String body, String extra__prodFee) {
		
		int cancelAmount = Integer.parseInt(extra__prodFee);
		
		cancellationApplicationRepository.doWrite(booking_id, memberType, title, body, cancelAmount);
	}

	public CancellationApplication getCancellationApplicationServiceByBooking_id(int Booking_id) {
		return cancellationApplicationRepository.getCancellationApplicationServiceByBooking_id(Booking_id);
	}
}
