package com.KoreaIT.project.BAP.controller;

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
	public String showDetail(Model model, int comp_id,
			@RequestParam(defaultValue="") String searchKeyword,
			@RequestParam(defaultValue="") String order_by,
			@RequestParam(defaultValue="1") int low_price,
			@RequestParam(defaultValue="999999999") int high_price) {
		
		Company company = companyService.getCompanyByComp_id(comp_id);
		
		List<Product> products = productService.getProductsByCompanyId(comp_id);
		
		model.addAttribute("company", company);
		model.addAttribute("products", products);
		
		return "usr/product/detail";
	}
	
	@RequestMapping("/usr/product/book")
	public String showBook(Model model,
			@RequestParam(defaultValue="") String searchKeyword,
			@RequestParam(defaultValue="") String order_by,
			@RequestParam(defaultValue="1") int low_price,
			@RequestParam(defaultValue="999999999") int high_price) {
		
		return "usr/product/book";
	}
	
}
