package com.KoreaIT.project.BAP.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.PaymentRepository;
import com.KoreaIT.project.BAP.vo.Payment;

@Service
public class PaymentService {
	
	public PaymentRepository paymentRepository;
	
	@Autowired
	public PaymentService(PaymentRepository paymentRepository) {
		this.paymentRepository = paymentRepository;
	}

	public void doWrite(String paymentKey, int bookingId, String status, String method, String bank, String requestedAt,
			String approvedAt, String type, String lastTransactionKey, int totalA, int balanceA, int suppliedA,
			int vatA) {
		paymentRepository.doWrite(paymentKey, bookingId, status, method, bank, requestedAt, approvedAt, type, lastTransactionKey, totalA, balanceA, suppliedA, vatA);
	}

	public Payment getPaymentByBooking_id(int booking_id) {
		return paymentRepository.getPaymentByBooking_id(booking_id);
	}

	public void doModify(int id) {
		paymentRepository.doModify(id);
	}

	public int getLastInsertId() {
		return paymentRepository.getLastInsertId();
	}

}
