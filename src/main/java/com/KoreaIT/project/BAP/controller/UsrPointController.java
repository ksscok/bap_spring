package com.KoreaIT.project.BAP.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KoreaIT.project.BAP.service.BookingService;
import com.KoreaIT.project.BAP.service.CancelService;
import com.KoreaIT.project.BAP.service.MemberService;
import com.KoreaIT.project.BAP.service.PaymentService;
import com.KoreaIT.project.BAP.service.PointService;
import com.KoreaIT.project.BAP.vo.Point;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrPointController {
	
	private MemberService memberService;
	private BookingService bookingService;
	private PaymentService paymentService;
	private CancelService cancelService;
	private PointService pointService;
	private Rq rq;
	
	@Autowired
	public UsrPointController(MemberService memberService, BookingService bookingService, PaymentService paymentService, CancelService cancelService, PointService pointService, Rq rq) {
		this.memberService = memberService;
		this.bookingService = bookingService;
		this.paymentService = paymentService;
		this.cancelService = cancelService;
		this.pointService = pointService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/point/list")
	public String showList(Model model) {
		
		if(!rq.isLogined()) {
			return rq.jsHistoryBack("로그인 후 이용해주세요.");
		}
		
		List<Point> points = pointService.getPointsByMemberId(rq.getLoginedMemberId());
		
		model.addAttribute("points", points);
		
		return "usr/point/list";
	}
	
	
}

