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
	
	public void doWrite(int booking_id, String title, String body, String transactionKey, Object taxExemptionAmount,
			Object easyPayDiscountAmount, Object cancelAmount, Object taxFreeAmount, Object refundableAmount) {
		
		int taxExemptionAmount_int = (int) taxExemptionAmount;
		int easyPayDiscountAmount_int = (int) easyPayDiscountAmount;
		int cancelAmountt_int = (int) cancelAmount;
		int taxFreeAmount_int = (int) taxFreeAmount;
		int refundableAmount_int = (int) refundableAmount;
		
		cancelRepository.doWrite(booking_id, title, body, transactionKey, taxExemptionAmount_int, easyPayDiscountAmount_int, cancelAmountt_int, taxFreeAmount_int, refundableAmount_int);
	}

}
