package com.KoreaIT.project.BAP.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String showList(Model model, 
			@RequestParam(defaultValue="") String start_date,
			@RequestParam(defaultValue="") String end_date, 
			@RequestParam(defaultValue = "allPoint") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "1") int page) {
		
		if(!rq.isLogined()) {
			return rq.historyBackJsOnView("로그인 후 이용해주세요.");
		}
		
		if (page <= 0) {
			return rq.historyBackJsOnView("페이지번호가 올바르지 않습니다");
		}
		
		int pointsCount = pointService.getPointsCount(rq.getLoginedMemberId(), start_date, end_date, searchKeywordTypeCode);
		
		int itemsInAPage = 10;
		
		int pagesCount = (int) Math.ceil((double) pointsCount / itemsInAPage);
		
		List<Point> points = pointService.getPointsByMemberId(rq.getLoginedMemberId(), start_date, end_date, searchKeywordTypeCode, itemsInAPage, page);
		
		model.addAttribute("points", points);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("pointsCount", pointsCount);
		model.addAttribute("page", page);
		model.addAttribute("itemsInAPage", itemsInAPage);
		model.addAttribute("pagesCount", pagesCount);
		
		return "usr/point/list";
	}
	
	
}

