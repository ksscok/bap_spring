package com.KoreaIT.project.BAP.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.KoreaIT.project.BAP.service.ProductService;
import com.KoreaIT.project.BAP.vo.Product;

@Controller
public class UsrProductController {
	
	ProductService productService;
	
	UsrProductController(ProductService productService) {
		this.productService = productService;
	}
	
	@RequestMapping("/usr/product/detail")
	public String showDetail(Model model, int companyId,
			@RequestParam(defaultValue="") String searchKeyword,
			@RequestParam(defaultValue="") String order_by,
			@RequestParam(defaultValue="1") int low_price,
			@RequestParam(defaultValue="999999999") int high_price) {
		
		Product product = productService.getForPrintproduct(companyId);
		
		List<Product> products = productService.getProductsByCompanyId(companyId);
		
		model.addAttribute("product", product);
		model.addAttribute("products", products);
		
		return "usr/product/detail";
	}
}
