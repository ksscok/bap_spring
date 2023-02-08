package com.KoreaIT.project.BAP.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.CancelRepository;

@Service
public class CancelService {

	public CancelRepository cancelRepository;
	
	@Autowired
	public CancelService( CancelRepository cancelRepository) {
		this.cancelRepository = cancelRepository;
	}
	
	public void doWrite(int booking_id, String title, String body, String transactionKey, Object taxExemptionAmount,
			Object easyPayDiscountAmount, Object cancelAmount, Object taxFreeAmount, Object refundableAmount) {
		cancelRepository.doWrite(booking_id, title, body, transactionKey, taxExemptionAmount, easyPayDiscountAmount, cancelAmount, taxFreeAmount, refundableAmount);
	}

}
