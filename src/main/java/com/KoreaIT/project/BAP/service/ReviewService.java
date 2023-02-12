package com.KoreaIT.project.BAP.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.ReviewRepository;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Member;
import com.KoreaIT.project.BAP.vo.ResultData;
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

	public List<Review> getForPrintReviews(int loginedMemberId, int comp_id) {
		
		List<Review> reviews = reviewRepository.getForPrintReviews(comp_id);
		
		for (Review review : reviews) {
			actorCanChangeData(loginedMemberId, review);
		}
		
		return reviews;
	}
	
	private void actorCanChangeData(int loginedMemberId, Review review) {
		
		if(review == null) {
			return;
		}
		
		ResultData actorCanChangeDataRd = actorCanMD(loginedMemberId, review);
		review.setActorCanChangeData(actorCanChangeDataRd.isSuccess());
		
	}	
	
	public Review getReviewByBooking_id(int booking_id) {
		return reviewRepository.getReviewByBooking_id(booking_id);
	}

	public Review getReviewById(int id) {
		return reviewRepository.getReviewById(id);
	}

	public ResultData actorCanMD(int loginedMemberId, Review review) {
		
		if(review == null) {
			return ResultData.from("F-1", Ut.f("해당 리뷰는 존재하지 않습니다"));
		}
		
		if(loginedMemberId != review.getMemberId()) {
			return ResultData.from("F-B", "해당 리뷰에 대한 권한이 없습니다");
		}
		
		return ResultData.from("S-1", "가능");
	}

	public void doWrite(int memberId, int comp_id, int booking_id, int rating, String body) {
		reviewRepository.doWrite(memberId, comp_id, booking_id, rating, body);
	}

	public void doModify(int id, int rating, String body) {
		reviewRepository.doModify(id, rating, body);
	}

	public void doDelete(int id) {
		reviewRepository.doDelete(id);
	}


}
