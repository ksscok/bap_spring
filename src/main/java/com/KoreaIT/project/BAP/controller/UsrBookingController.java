package com.KoreaIT.project.BAP.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KoreaIT.project.BAP.service.BookingService;
import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.service.ProductService;

@Controller
public class UsrBookingController {
	
	private BookingService bookingService;
	private ProductService productService;
	private CompanyService companyService;
	
	@Autowired
	public UsrBookingController(BookingService bookingService, ProductService productService, CompanyService companyService) {
		this.bookingService = bookingService;
		this.productService = productService;
		this.companyService = companyService;
	}
	
	@RequestMapping("/usr/booking/book")
	public String showBook() {
		return "usr/booking/book";
	}
	
}
