package com.KoreaIT.project.BAP.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.project.BAP.service.WishService;
import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Wish;
import com.KoreaIT.project.BAP.vo.Booking;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrWishController {
	
	private CompanyService companyService;
	private WishService wishService;
	private Rq rq;
	
	@Autowired
	public UsrWishController(CompanyService companyService, WishService wishService, Rq rq) {
		this.companyService = companyService;
		this.wishService = wishService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/wish/list")
	public String showList(Model model, int memberId,
			@RequestParam(defaultValue = "name") String searchKeywordTypeCode,
			@RequestParam(defaultValue="") String searchKeyword) {
		
		int[] comp_ids = wishService.getComp_idByMemberId(memberId);
		
		List<Company> companies = companyService.getCompaniesByIds(comp_ids, searchKeywordTypeCode, searchKeyword);
		
		int wishesCount = wishService.getWishesCountByIds(memberId, searchKeywordTypeCode, searchKeyword);
		
		model.addAttribute("companies", companies);
		model.addAttribute("wishesCount", wishesCount);
		
		return "usr/wish/list";
	}
	
	@RequestMapping("usr/wish/doWriteOrDelete")
	@ResponseBody()
	public String doWriteOrDelete(int memberId, int comp_id) {
		
		if(Ut.empty(memberId)) {
			return rq.jsHistoryBack("사업장 번호를 입력해주세요.");
		}
		
		if(Ut.empty(comp_id)) {
			return rq.jsHistoryBack("사업장 번호를 입력해주세요.");
		}
		
		Wish wish = wishService.getWishByMemberIdAndComp_id(memberId, comp_id);
		
		if(wish == null) {
			wishService.doWrite(memberId, comp_id);
		} else {
			wishService.doDelete(memberId, comp_id);
		}
		
		// 혹시 몰라서 임시로 넣어둠. 나중에 필요 없으면 공백으로 리턴 or void 타입으로 변경.
		return "10";
	}
	
	
	@RequestMapping("/usr/wish/doDeleteAtWishList")
	@ResponseBody
	public String doDeleteAtWishList(int memberId, int comp_id) {
		
		if(Ut.empty(memberId)) {
			return Ut.jsHistoryBack("회원번호를 입력해주세요");
		}
		
		if(Ut.empty(comp_id)) {
			return Ut.jsHistoryBack("사업장 번호를 입력해주세요");
		}
		
		wishService.doDelete(memberId, comp_id);
		
		return Ut.jsReplace("해당 숙소를 찜 목록에서 삭제했습니다.", Ut.f("/usr/wish/list?memberId=%d", memberId));
	}
}

