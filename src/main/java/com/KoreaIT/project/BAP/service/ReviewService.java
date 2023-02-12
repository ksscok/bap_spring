package com.KoreaIT.project.BAP.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.ReviewRepository;
import com.KoreaIT.project.BAP.vo.Member;
import com.KoreaIT.project.BAP.vo.Review;

@Service
public class ReviewService {

	public ReviewRepository reviewRepository;
	private MemberService memberService;
	private BookingService bookingService;

	
	@Autowired
	public ReviewService(ReviewRepository reviewRepository, MemberService memberService, BookingService bookingService) {
		this.reviewRepository = reviewRepository;
		this.memberService = memberService;
		this.bookingService = bookingService;
	}


	public List<Review> getReviewByComp_id(int comp_id) {
		List<Review> reviews = reviewRepository.getReviewByComp_id(comp_id);
				
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		
		String formatedNow = format.format(now);
		System.out.println("formatedNow : " + formatedNow + "=============");
		
		for(Review review : reviews) {
			review.setExtra__beforeDays(bookingService.getDiffBetweenChkinChkout(review.getRegDate(), formatedNow));
		}
		
		return reviews; 
	}


	public Review getReviewByBooking_id(int booking_id) {
		return reviewRepository.getReviewByBooking_id(booking_id);
	}


	public void doWrite(int memberId, int comp_id, int booking_id, int rating, String body) {
		reviewRepository.doWrite(memberId, comp_id, booking_id, rating, body);
	}


	public Review getReviewById(int id) {
		return reviewRepository.getReviewById(id);
	}


	public void doModify(int id, int rating, String body) {
		reviewRepository.doModify(id, rating, body);
	}


}
