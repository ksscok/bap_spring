package com.KoreaIT.project.BAP.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.service.ProductService;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Product;

@Controller
public class UsrProductController {
	
	private ProductService productService;
	private CompanyService companyService;
	
	@Autowired
	public UsrProductController(ProductService productService, CompanyService companyService) {
		this.productService = productService;
		this.companyService = companyService;
	}
	
	@RequestMapping("/usr/product/detail")
	public String showDetail(Model model, String compId,
			@RequestParam(defaultValue="") String countOfRoom,
			@RequestParam(defaultValue="") String start_date,
			@RequestParam(defaultValue="") String end_date,
			@RequestParam(defaultValue="") String countOfAdult,
			@RequestParam(defaultValue="") String countOfChild,
			@RequestParam(defaultValue="") String withoutMealsType,
			@RequestParam(defaultValue="") String withBreakfastType,
			@RequestParam(defaultValue="") String withDinnerType,
			@RequestParam(defaultValue="") String withBreakfastAndDinnerType,
			@RequestParam(defaultValue="") String smokingType,
			@RequestParam(defaultValue="1") int low_price,
			@RequestParam(defaultValue="999999999") int high_price) {
		
		int comp_id = Integer.parseInt(compId);
		
		// 파라미터 입력용 테스트 데이터 - 나중에 리스트에서부터 받아오거나 리스트에서 안할 경우를 생각해서 디폴트 값으로 그냥 넣어도 될듯(대신 이때는 Ut클래스에 생성해야 할 듯)
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
		// 여기까지
		
		Company company = companyService.getCompanyByComp_id(comp_id);
		
		List<Product> products = productService.getProductsByCompanyId(comp_id, countOfRoom, countOfAdult, countOfChild, withoutMealsType, withBreakfastType, withDinnerType, withBreakfastAndDinnerType, smokingType, low_price, high_price);
		
		// 예약페이지에서 orderId를 만들 때 필요한 숙박타입 코드를 넘겨주기 위한 부분 시작
		String accommodationTypeCode = "-1";
		if(company.getAccommodationType().equals("motel")) {
			accommodationTypeCode = "1";
		}else if(company.getAccommodationType().equals("hotel")) {
			accommodationTypeCode = "2";
		}else if(company.getAccommodationType().equals("pension")) {
			accommodationTypeCode = "3";
		}else if(company.getAccommodationType().equals("guesthouse")) {
			accommodationTypeCode = "4";
		}
		// 예약페이지에서 orderId를 만들 때 필요한 숙박타입 코드를 넘겨주기 위한 부분 끝
		
		model.addAttribute("comp_id", comp_id);
		model.addAttribute("countOfRoom", countOfRoom);
		model.addAttribute("countOfAdult", countOfAdult);
		model.addAttribute("countOfChild", countOfChild);
		model.addAttribute("withoutMealsType", withoutMealsType);
		model.addAttribute("withBreakfastType", withBreakfastType);
		model.addAttribute("withDinnerType", withDinnerType);
		model.addAttribute("withBreakfastAndDinnerType", withBreakfastAndDinnerType);
		model.addAttribute("smokingType", smokingType);
		model.addAttribute("low_price", low_price);
		model.addAttribute("high_price", high_price);
		model.addAttribute("company", company);
		model.addAttribute("products", products);
		model.addAttribute("accommodationTypeCode", accommodationTypeCode);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		
		return "usr/product/detail";
	}
	
}
