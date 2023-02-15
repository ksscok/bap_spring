package com.KoreaIT.project.BAP.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.CancelRepository;

@Service
public class CancelService {

	public CancelRepository cancelRepository;
	
	@Autowired
	public CancelService(CancelRepository cancelRepository) {
		this.cancelRepository = cancelRepository;
	}
	
	public void doWrite(int booking_id, String title, String body, String transactionKey, int lastTotalAmount,
			int pay_point, int paidRealAmount) {
		
		cancelRepository.doWrite(booking_id, title, body, transactionKey, lastTotalAmount, pay_point, paidRealAmount);
	}

}
