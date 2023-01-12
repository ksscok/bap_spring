package com.KoreaIT.project.BAP.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.CompanyRepository;
import com.KoreaIT.project.BAP.vo.Company;

@Service
public class CompanyService {
	
	CompanyRepository companyRepository;
	
	CompanyService(CompanyRepository companyRepository) {
		this.companyRepository = companyRepository;
	}

	public int register(String name, String address, String accommodationType, int host_id) {
		companyRepository.register(name, address, accommodationType, host_id);
		return companyRepository.getLastInsertId();
	}
	
	public List<Company> getForPrintCompanies(String searchKeyword, String order_by, String motelType, String hotelType, String pensionType, String geusthouseType, int low_price, int high_price) {
		return companyRepository.getForPrintCompanies(searchKeyword, order_by, motelType, hotelType, pensionType, geusthouseType, low_price, high_price);
	}
	
}
