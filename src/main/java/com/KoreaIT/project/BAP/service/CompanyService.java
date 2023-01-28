package com.KoreaIT.project.BAP.service;

import java.util.HashMap;
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
	
	public String getAreaMap(String area) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("1", "서울 > 강남/역삼/삼성/신사/청담");
		map.put("2", "서울 > 서초/교대");
		map.put("3", "서울 > 잠실/송파/왕십리/강동");
		map.put("4", "서울 > 을지로/시청/명동");
		map.put("5", "서울 > 종로/인사동/동대문/강북");
		map.put("6", "서울 > 서울역/이태원/용");
		map.put("7", "서울 > 마포/홍대/신촌/서대문");
		map.put("8", "서울 > 영등포/여의도/김포공항");
		map.put("9", "서울 > 구로/금천/관악/동작");
		map.put("10", "부산 > 해운대작");
		map.put("11", "부산 > 광안리");
		map.put("12", "부산 > 부산역/남포/자갈치");
		map.put("13", "부산 > 서면/동래/연제/남구");
		map.put("14", "부산 > 기장/김해공항");
		map.put("15", "부산 > 영도/송도해수욕장");
		map.put("16", "제주 > 제주시/제주국제공항");
		map.put("17", "제주 > 애월/협재/한림");
		map.put("18", "제주 > 조천/함덕/김녕");
		map.put("19", "제주 > 서귀포시");
		map.put("20", "제주 > 중문");
		map.put("21", "제주 > 성산/표선");
		map.put("22", "강원 > 강릉/동해/삼척");
		map.put("23", "강원 > 속초/고성");
		map.put("24", "강원 > 양양/홍천/인제/철원");
		map.put("25", "강원 > 평창/정선/횡성");
		map.put("26", "강원 > 춘천/원주/영월/태백");
		map.put("27", "경기 > 수원/성남/판교");
		map.put("28", "경기 > 가평/양평/포천");
		map.put("29", "경기 > 용인/평택/여주/이천");
		map.put("30", "경기 > 화성/동탄/안산/부천/안양");
		map.put("31", "경기 > 고양/의정부/파주/김포");
		map.put("32", "경기 > 시흥/군포/광명");
		map.put("33", "경기 > 남양주시/구리/하남");
		map.put("34", "인천 > 송도/남동구/옹진군");
		map.put("35", "인천 > 인천국제공항(중구)");
		map.put("36", "인천 > 부평/계양/서구/미추홀구/강화");
		map.put("37", "경상 > 경주");
		map.put("38", "경상 > 거제/고성");
		map.put("39", "경상 > 포항/청송/영덕/울진");
		map.put("40", "경상 > 통영/창녕");
		map.put("41", "경상 > 대구/구미/문경/안동");
		map.put("42", "경상 > 창원/양산/김해/울산");
		map.put("43", "경상 > 사천/남해/진주/하동");
		map.put("44", "전라 > 여수");
		map.put("45", "전라 > 전주");
		map.put("46", "전라 > 광주");
		map.put("47", "전라 > 순천/광양");
		map.put("48", "전라 > 군산/익산/부안/진안/무주");
		map.put("49", "전라 > 화순/남원/구례");
		map.put("50", "전라 > 목포/나주/완도/해남/영암");
		map.put("51", "충청 > 대전");
		map.put("52", "충청 > 천안/아산/예산/당진");
		map.put("53", "충청 > 보령(대천)/태안(안면도)/서산/부여");
		map.put("54", "충청 > 충주/제천/단양");
		map.put("55", "충청 > 청주/세종");
		
		return map.get(area);
	}
}
