package com.KoreaIT.project.BAP.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.project.BAP.service.ReviewService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrReviewController {
	
	private ReviewService reviewService;
	private Rq rq;
	
	@Autowired
	public UsrReviewController(ReviewService reviewService, Rq rq) {
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
//	@RequestMapping("/usr/wish/doDeleteAtWishList")
//	@ResponseBody
//	public String doDeleteAtWishList(int memberId, int comp_id) {
//		
//		return Ut.jsReplace("해당 숙소를 찜 목록에서 삭제했습니다.", Ut.f("/usr/wish/list?memberId=%d", memberId));
//	}
}

