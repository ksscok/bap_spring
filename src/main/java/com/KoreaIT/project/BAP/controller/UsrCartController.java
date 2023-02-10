package com.KoreaIT.project.BAP.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.project.BAP.service.CartService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Cart;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrCartController {
	
	private CartService cartService;
	private Rq rq;
	
	@Autowired
	public UsrCartController(CartService cartService, Rq rq) {
		this.cartService = cartService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/cart/write")
	public String showMain(Model model,			
			@RequestParam(defaultValue="") String start_date,
			@RequestParam(defaultValue="") String end_date) 		{
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		
		if(start_date.equals("")) {
			start_date = format.format(now);
		}
		
		if(end_date.equals("")) {
			try {
				Date date = format.parse(start_date);
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				
				cal.add(Calendar.DATE, 1); // 다음날(1일 후)
				
				end_date = format.format(cal.getTime());
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		
		return "usr/cart/write";
	}
	
	@RequestMapping("usr/cart/doWriteOrDelete")
	@ResponseBody()
	public String doWriteOrDelete(int memberId, int comp_id) {
		
		if(Ut.empty(comp_id)) {
			return rq.jsHistoryBack("사업장 번호를 입력해주세요.");
		}
		
		Cart cart = cartService.getCartByMemberIdAndComp_id(memberId, comp_id);
		
		if(cart == null) {
			cartService.doWrite(memberId, comp_id);
		} else {
			cartService.doDelete(memberId, comp_id);
		}
		
		return "10";
	}
	
}

