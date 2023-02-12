package com.KoreaIT.project.BAP.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.ReviewRepository;
import com.KoreaIT.project.BAP.vo.Review;

@Service
public class ReviewService {

	public ReviewRepository reviewRepository;
	private BookingService bookingService;

	
	@Autowired
	public ReviewService(ReviewRepository reviewRepository, BookingService bookingService) {
		this.reviewRepository = reviewRepository;
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


}
