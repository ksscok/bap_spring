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
	
	private PointService pointService;
	private Rq rq;
	
	@Autowired
	public UsrPointController(PointService pointService, Rq rq) {
		this.pointService = pointService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/point/list")
	public String showList(Model model) {
		
		if(!rq.isLogined()) {
			return rq.historyBackJsOnView("로그인 후 이용해주세요.");
		}
		
		List<Point> points = pointService.getPointsByMemberId(rq.getLoginedMemberId());
		
		model.addAttribute("points", points);
		
		return "usr/point/list";
	}
	
	
}

