package com.KoreaIT.project.BAP.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.KoreaIT.project.BAP.service.BookingService;
import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.service.MemberService;
import com.KoreaIT.project.BAP.service.ProductService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Member;
import com.KoreaIT.project.BAP.vo.Product;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrBookingController {
	
	private BookingService bookingService;
	private ProductService productService;
	private CompanyService companyService;
	private MemberService memberService;
	private Rq rq;
	
	@Autowired
	public UsrBookingController(BookingService bookingService, ProductService productService, CompanyService companyService, MemberService memberService, Rq rq) {
		this.bookingService = bookingService;
		this.productService = productService;
		this.companyService = companyService;
		this.memberService = memberService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/booking/book")
	public String showBook(Model model, int comp_id, int prod_id, String start_date, String end_date,
			@RequestParam(defaultValue="-1") String accommodationTypeCode) {
		
		// 오늘 날짜(예약을 실행한 날짜) - 주문번호를 위한 날짜정보
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
		Date now = new Date();
		String today = format.format(now);
		
		// 예약번호
		int resev_id =  (bookingService.getLastInsertId() + 1);
		
		// 주문번호 = 예약날짜 + 숙박타입코드 + comp_id + prod_id + 예약번호
		String orderId = today + "a" + accommodationTypeCode + "c" + comp_id + "p" + prod_id + resev_id;
		
		Company company = companyService.getCompanyByComp_id(comp_id);
		
		Product product = productService.getForPrintproduct(prod_id);
		
		// 금액 3자리마다 콤마(,) 붙여주기 위한 코드 시작
		DecimalFormat formatter = new DecimalFormat("###,###");
		String price = formatter.format(product.getFee());
		// 금액 3자리마다 콤마(,) 붙여주기 위한 코드 끝
		
		Member member = null;
		
		if(rq.getLoginedMemberId() != 0) {
			member = memberService.getMemberById(rq.getLoginedMemberId());
		}
		
		// 예약페이지에서 체크인, 체크아웃에 요일 보여주기 위한 날짜방식
		String DateAndDayOfTheWeekOfChkin = Ut.getDateAndDayOfTheWeek(start_date);
		String DateAndDayOfTheWeekOfChkout = Ut.getDateAndDayOfTheWeek(end_date);
		
		// 예약페이지에서 몇박인지 보여주기 위한 (체크인-체크아웃)값 불러오는 코드
		int diff = bookingService.getDiffBetweenChkinChkout(start_date, end_date);
        
		model.addAttribute("comp_id", comp_id);
		model.addAttribute("orderId", orderId);
		model.addAttribute("company", company);
		model.addAttribute("product", product);
		model.addAttribute("price", price);
		model.addAttribute("member", member);
		model.addAttribute("DateAndDayOfTheWeekOfChkin", DateAndDayOfTheWeekOfChkin);
		model.addAttribute("DateAndDayOfTheWeekOfChkout", DateAndDayOfTheWeekOfChkout);
		model.addAttribute("diff", diff);
		
		return "usr/booking/book";
	}

}
