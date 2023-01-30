package com.KoreaIT.project.BAP.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrManagementController {
	
	private CompanyService companyService;
	private Rq rq;
	
	UsrManagementController(CompanyService companyService, Rq rq) {
		this.companyService = companyService;
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
}

