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
	public String showDetail(Model model, int comp_id,
			@RequestParam(defaultValue="") String searchKeyword,
			@RequestParam(defaultValue="") String order_by,
			@RequestParam(defaultValue="1") int low_price,
			@RequestParam(defaultValue="999999999") int high_price) {
		
		// 파라미터 입력용 테스트 데이터 - 나중에 리스트에서부터 받아오거나 리스트에서 안할 경우를 생각해서 디폴트 값으로 그냥 넣어도 될듯(대신 이때는 Ut클래스에 생성해야 할 듯)
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String start_date = format.format(now);
		String end_date = "";
		
		try {
			Date date = format.parse(start_date);
			 Calendar cal = Calendar.getInstance();
		        cal.setTime(date);
		       
		        cal.add(Calendar.DATE, 1); // 다음날(1일 후)
		        
		        end_date = format.format(cal.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		// 여기까지
		
		Company company = companyService.getCompanyByComp_id(comp_id);
		
		List<Product> products = productService.getProductsByCompanyId(comp_id);
		
		model.addAttribute("company", company);
		model.addAttribute("products", products);
		
		return "usr/product/detail";
	}
	
	@RequestMapping("/usr/payment/complete")
	public String showComplete() {
		return "usr/payment/complete";
	}
	
}
