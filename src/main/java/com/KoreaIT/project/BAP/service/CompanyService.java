package com.KoreaIT.project.BAP.service;

import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.CompanyRepository;

@Service
public class CompanyService {
	
	CompanyRepository companyRepository;
	
	CompanyService(CompanyRepository companyRepository) {
		this.companyRepository = companyRepository;
	}

	public int register(String name, String address) {
		companyRepository.register(name, address);
		return companyRepository.getLastInsertId();
	}
	
}
