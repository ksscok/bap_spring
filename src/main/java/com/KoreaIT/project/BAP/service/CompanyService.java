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

	public int register(String name, String address, String timeChkin, String timeChkout, String accommodationType, int host_id) {
		companyRepository.register(name, address, timeChkin, timeChkout, accommodationType, host_id);
		return companyRepository.getLastInsertId();
	}
	
	public List<Company> getForPrintCompanies(String searchKeyword, String order_by, 
			String motelType, String hotelType, String pensionType, String geusthouseType, int low_price, int high_price) {
		
		String[] searchKeywordBits = searchKeyword.split(" ");
		String searchKeyword1 = "";
		String searchKeyword2 = "";
		String searchKeyword3 = "";
		String searchKeyword4 = "";
		String searchKeyword5 = "";
		String searchKeyword6 = "";
		
		if(searchKeywordBits.length == 1) {
			searchKeyword1 = searchKeywordBits[0];
		}
		
		if(searchKeywordBits.length == 2) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
		}
		
		if(searchKeywordBits.length == 3) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
			searchKeyword3 = searchKeywordBits[2];
		}
		
		if(searchKeywordBits.length == 4) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
			searchKeyword3 = searchKeywordBits[2];
			searchKeyword4 = searchKeywordBits[3];
		}
		
		if(searchKeywordBits.length == 5) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
			searchKeyword3 = searchKeywordBits[2];
			searchKeyword4 = searchKeywordBits[3];
			searchKeyword5 = searchKeywordBits[4];
		}
		
		if(searchKeywordBits.length == 6) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
			searchKeyword3 = searchKeywordBits[2];
			searchKeyword4 = searchKeywordBits[3];
			searchKeyword5 = searchKeywordBits[4];
			searchKeyword6 = searchKeywordBits[5];
		}
		
		return companyRepository.getForPrintCompanies(searchKeyword1, searchKeyword2, searchKeyword3, searchKeyword4, searchKeyword5, searchKeyword6, order_by, motelType, hotelType, pensionType, geusthouseType, low_price, high_price);
	}

	public Company getCompanyByComp_id(int comp_id) {
		return companyRepository.getCompanyByComp_id(comp_id);
	}

	public int getCompainesCount(String searchKeyword, String motelType, String hotelType,
			String pensionType, String geusthouseType, int low_price, int high_price) {
		
		String[] searchKeywordBits = searchKeyword.split(" ");
		String searchKeyword1 = "";
		String searchKeyword2 = "";
		String searchKeyword3 = "";
		String searchKeyword4 = "";
		String searchKeyword5 = "";
		String searchKeyword6 = "";
		
		if(searchKeywordBits.length == 1) {
			searchKeyword1 = searchKeywordBits[0];
		}
		
		if(searchKeywordBits.length == 2) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
		}
		
		if(searchKeywordBits.length == 3) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
			searchKeyword3 = searchKeywordBits[2];
		}
		
		if(searchKeywordBits.length == 4) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
			searchKeyword3 = searchKeywordBits[2];
			searchKeyword4 = searchKeywordBits[3];
		}
		
		if(searchKeywordBits.length == 5) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
			searchKeyword3 = searchKeywordBits[2];
			searchKeyword4 = searchKeywordBits[3];
			searchKeyword5 = searchKeywordBits[4];
		}
		
		if(searchKeywordBits.length == 6) {
			searchKeyword1 = searchKeywordBits[0];
			searchKeyword2 = searchKeywordBits[1];
			searchKeyword3 = searchKeywordBits[2];
			searchKeyword4 = searchKeywordBits[3];
			searchKeyword5 = searchKeywordBits[4];
			searchKeyword6 = searchKeywordBits[5];
		}
		
		return companyRepository.getCompainesCount(searchKeyword1, searchKeyword2, searchKeyword3, searchKeyword4, searchKeyword5, searchKeyword6, motelType, hotelType, pensionType, geusthouseType, low_price, high_price);
	}


	
}
