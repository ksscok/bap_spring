package com.KoreaIT.project.BAP.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.KoreaIT.project.BAP.service.BookingService;
import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.service.ProductService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Booking;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Product;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrManagementController {
	
	private CompanyService companyService;
	private ProductService productService;
	private BookingService bookingService;
	private Rq rq;
	
	@Autowired
	public UsrManagementController(CompanyService companyService, ProductService productService, BookingService bookingService, Rq rq) {
		this.companyService = companyService;
		this.productService = productService;
		this.bookingService = bookingService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/management/companyList")
	public String showCompanyList(Model model) {
		
		int hostId = rq.getLoginedMemberId();
		
		List<Company> companies = companyService.getCompanyByHostId(hostId);
		
		model.addAttribute("companies", companies);
		
		return "usr/management/companyList";
	}
	
	@RequestMapping("/usr/management/companyDetail")
	public String showManagementDetail(Model model, int id) {
		
		Company company = companyService.getCompanyByComp_id(id);
		
		model.addAttribute("company", company);
		
		return "usr/management/companyDetail";
	}
	
	@RequestMapping("/usr/management/productList")
	public String showproductList(Model model, @RequestParam(defaultValue = "") int id) {
		
		List<Product> products = productService.getProductsByCompId(id);
		
		model.addAttribute("products", products);
		
		return "usr/management/productList";
	}
	
	@RequestMapping("/usr/management/bookingList")
	public String showBookingList(Model model, int comp_id) {
		
		if(Ut.empty(comp_id)) {
			return rq.jsHistoryBack("사업장 번호를 입력해주세요.");
		}
		
		List<Booking> bookings = bookingService.getBookingsByComp_id(comp_id);
		
		int bookingsCount = bookingService.getBookingsCountByComp_id(comp_id);
		
		model.addAttribute("comp_id", comp_id);
		model.addAttribute("bookings", bookings);
		model.addAttribute("bookingsCount", bookingsCount);
		
		return "usr/management/bookingList";
	}

}

