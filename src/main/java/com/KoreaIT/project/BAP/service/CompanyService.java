package com.KoreaIT.project.BAP.service;

import java.util.ArrayList;
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

	public int register(String name, String cellphoneNo, String address, String area, String timeChkin, String timeChkout, String accommodationType, int host_id) {
		companyRepository.register(name, cellphoneNo, address, area, timeChkin, timeChkout, accommodationType, host_id);
		return companyRepository.getLastInsertId();
	}
	
	public List<Company> getForPrintCompanies(String searchKeyword, String order_by, 
			String motelType, String hotelType, String pensionType, String guesthouseType, int low_price, int high_price) {
		
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
		
		return companyRepository.getForPrintCompanies(searchKeyword1, searchKeyword2, searchKeyword3, searchKeyword4, searchKeyword5, searchKeyword6, order_by, motelType, hotelType, pensionType, guesthouseType, low_price, high_price);
	}

	public Company getCompanyByComp_id(int comp_id) {
		return companyRepository.getCompanyByComp_id(comp_id);
	}

	public int getCompainesCount(String searchKeyword, String motelType, String hotelType,
			String pensionType, String guesthouseType, int low_price, int high_price) {
		
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
		
		return companyRepository.getCompainesCount(searchKeyword1, searchKeyword2, searchKeyword3, searchKeyword4, searchKeyword5, searchKeyword6, motelType, hotelType, pensionType, guesthouseType, low_price, high_price);
	}

	public List<Company> getForPrintHotels(String area, String order_by, int low_price, int high_price) {
		return companyRepository.getForPrintHotels(area, order_by, low_price, high_price);
	}

	public int getHotelsCount(String area, int low_price, int high_price) {
		return companyRepository.getHotelsCount(area, low_price, high_price);
	}
	
	public List<Company> getCompanyByHostId(int hostId) {
		return companyRepository.getCompanyByHostId(hostId);
	}

	// 찜 목록 불러오는 함수1
	public List<Company> getCompaniesByIds(int[] comp_ids, String searchKeywordTypeCode, String searchKeyword) {
		
		List<Company> companies = new ArrayList<>();
		
		for(int i = 0; i < comp_ids.length; i++) {
			// 만약 getCompanyByComp_idForWish(comp_ids[i], searchKeywordTypeCode, searchKeyword)의 값이 없을 때 없는 값으로 companies에 add를 해버려서 빈칸이 나와버림
			if(getCompanyByComp_idForWish(comp_ids[i], searchKeywordTypeCode, searchKeyword) != null) {
				companies.add(getCompanyByComp_idForWish(comp_ids[i], searchKeywordTypeCode, searchKeyword));
			}
		}
		
		return companies;
	}

	// 찜 목록 불러오는 함수2
	private Company getCompanyByComp_idForWish(int id, String searchKeywordTypeCode, String searchKeyword) {
		return companyRepository.getCompanyByComp_idForWish(id, searchKeywordTypeCode, searchKeyword);
	}

}
