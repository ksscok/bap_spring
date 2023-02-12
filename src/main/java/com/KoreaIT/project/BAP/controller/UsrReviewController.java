package com.KoreaIT.project.BAP.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.KoreaIT.project.BAP.service.BookingService;
import com.KoreaIT.project.BAP.service.MemberService;
import com.KoreaIT.project.BAP.service.PaymentService;
import com.KoreaIT.project.BAP.service.ReviewService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Booking;
import com.KoreaIT.project.BAP.vo.Member;
import com.KoreaIT.project.BAP.vo.Payment;
import com.KoreaIT.project.BAP.vo.Review;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrReviewController {
	
	private MemberService memberService;
	private BookingService bookingService;
	private PaymentService paymentService;
	private ReviewService reviewService;
	private Rq rq;
	
	@Autowired
	public UsrReviewController(MemberService memberService, BookingService bookingService, PaymentService paymentService, ReviewService reviewService, Rq rq) {
		this.memberService = memberService;
		this.bookingService = bookingService;
		this.paymentService = paymentService;
		this.reviewService = reviewService;
		this.rq = rq;
	}
	
//	@RequestMapping("/usr/wish/list")
//	public String showList(Model model, int memberId,
//			@RequestParam(defaultValue = "name") String searchKeywordTypeCode,
//			@RequestParam(defaultValue="") String searchKeyword) {
//		
////		model.addAttribute("wishesCount", wishesCount);
//		
//		return "usr/wish/list";
//	}
//	
//	@RequestMapping("usr/wish/doWriteOrDelete")
//	@ResponseBody()
//	public String doWriteOrDelete(int memberId, int comp_id) {
//		
//		return "10";
//	}
//	
//	
	@RequestMapping("/usr/review/doWrite")
	@ResponseBody
	public String doWrite(int memberId, int comp_id, int booking_id, int rating, String body, @RequestParam(required = false) MultipartRequest multipartRequest) {
		
		// 이미 전에 작성한 예약번호가 있는지 유효성 검사 시작
		Review review = reviewService.getReviewByBooking_id(booking_id);
		
		if(review != null) {
			return rq.jsHistoryBack("이미 리뷰를 작성한 예약번호 입니다.");
		}
		// 이미 전에 작성한 예약번호가 있는지 유효성 검사 끝
		
		// 이거는 고민중(사실 비로그인상태에서의 예약이나 아이디를 빌려서 회원가입한 사람과는 다른 사람이 자기 번호로 예약하는 경우에는 이 방법은 쓰면 안됨)
		// 현재 로그인한 멤버와 입력된 예약번호에 저장되어있는 전화번호가 일치하는지(본인인증) 유효성 검사 시작
		Member member = memberService.getMemberById(memberId);
		
		Booking booking = bookingService.getBookingById(booking_id);
		
		if(!member.getCellphoneNo().equals(booking.getCellphoneNo())) {
			return rq.jsHistoryBack("리뷰 작성을 요청한 유저와 예약한 유저의 정보가 일치하지 않습니다.");
		}
		// 현재 로그인한 멤버와 입력된 예약번호에 저장되어있는 전화번호가 일치하는지(본인인증) 유효성 검사 끝
		
		// 리뷰를 남기려는 사업장 번호와 예약한 사업장 번호가 다를 경우 유효성 검사 시작 
		if(comp_id != booking.getComp_id()) {
			return rq.jsHistoryBack("리뷰를 작성하려는 사업장과 예약한 사업장의 정보가 일치하지 않습니다.");
		}
		// 리뷰를 남기려는 사업장 번호와 예약한 사업장 번호가 다를 경우 유효성 검사 끝 
		
		// 이 부분은 추후에 예약테이블과 결제테이블이 동시에 작성되도록 조절 할 생각이긴 함. 그러나 그렇게 해도 혹시 모르니 냅두는게 나을지도?
		// 예약번호만 하고 결제는 하지 않은 경우 유효성 검사 시작
		Payment payment = paymentService.getPaymentByBooking_id(booking_id);
		
		if(payment == null) {
			return rq.jsHistoryBack("결제가 이루어지지 않은 예약번호 입니다. 결제 후 이용해주세요.");
		}
		// 예약번호만 하고 결제는 하지 않은 경우 유효성 검사 끝
		
		reviewService.doWrite(memberId, comp_id, booking_id, rating, body);
		
		return Ut.jsReplace("리뷰가 등록되었습니다.", Ut.f("/usr/product/detail?comp_id=%d", comp_id));
	}
}

