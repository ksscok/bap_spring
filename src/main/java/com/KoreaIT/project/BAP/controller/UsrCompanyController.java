package com.KoreaIT.project.BAP.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.service.GenFileService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrCompanyController {
	
	private CompanyService companyService;
	private GenFileService genFileService;
	private Rq rq;
	
	UsrCompanyController(CompanyService companyService, GenFileService genFileService, Rq rq) {
		this.companyService = companyService;
		this.genFileService = genFileService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/company/register")
	public String showRegister() {
		
		return "usr/company/register";
	}
	
	@RequestMapping("/usr/company/doRegister")
	@ResponseBody
	public String doRegister(String name, String cellphoneNo, String address, String area, String timeChkin, String timeChkout, String accommodationType, 
			int host_id, MultipartRequest multipartRequest) {
		
		if(Ut.empty(name)) {
			return rq.jsHistoryBack("상호를 등록해주세요.");
		}
		if(Ut.empty(cellphoneNo)) {
			return rq.jsHistoryBack("사업장 전화번호를 등록해주세요.");
		}
		if(Ut.empty(address)) {
			return rq.jsHistoryBack("사업장 주소를 등록해주세요.");
		}
		if(Ut.empty(area)) {
			return rq.jsHistoryBack("사업장 지역을 선택해주세요.");
		}
		if(Ut.empty(timeChkin)) {
			return rq.jsHistoryBack("체크인 시간을 등록해주세요.");
		}
		if(Ut.empty(timeChkout)) {
			return rq.jsHistoryBack("체크아웃 시간을 등록해주세요.");
		}
		if(Ut.empty(accommodationType)) {
			return rq.jsHistoryBack("시설 유형을 선택해주세요.");
		}
		if(Ut.empty(multipartRequest)) {
			return rq.jsHistoryBack("사업장 프로필 이미지를 등록해주세요.");
		}
		
		int newCompanyId = companyService.register(name, cellphoneNo, address, area, timeChkin, timeChkout, accommodationType, host_id);
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
            MultipartFile multipartFile = fileMap.get(fileInputName);
            if ( multipartFile.isEmpty() == false ) {
                genFileService.save(multipartFile, newCompanyId);
            }
        }
		
		return rq.jsReplace(Ut.f("%d번 사업장이 등록되었습니다.", newCompanyId), "/");
	}
	
	@RequestMapping("/usr/company/list")
	public String showList(Model model,
			@RequestParam(defaultValue="") String searchKeyword,
			@RequestParam(defaultValue="") String order_by,
			@RequestParam(defaultValue="") String motelType,
			@RequestParam(defaultValue="") String hotelType,
			@RequestParam(defaultValue="") String pensionType,
			@RequestParam(defaultValue="") String guesthouseType,
			@RequestParam(defaultValue="1") int low_price,
			@RequestParam(defaultValue="999999999") int high_price) {
		
		List<Company> companies = companyService.getForPrintCompanies(searchKeyword, order_by, motelType, hotelType, pensionType, guesthouseType, low_price, high_price);
		int companiesCount = companyService.getCompainesCount(searchKeyword, motelType, hotelType, pensionType, guesthouseType, low_price, high_price);
		
		model.addAttribute("companiesCount", companiesCount);
		model.addAttribute("companies", companies);
		
		return "usr/company/list";
	}
	
	@RequestMapping("/usr/company/hotel")
	public String showHotel(Model model,
			@RequestParam(defaultValue="51") String area,
			@RequestParam(defaultValue="") String start_date,
			@RequestParam(defaultValue="") String end_date,
			@RequestParam(defaultValue="1") String countOfRooms,
			@RequestParam(defaultValue="2") String countOfAdult,
			@RequestParam(defaultValue="0") String countOfChild,
			@RequestParam(defaultValue="") String order_by,
			@RequestParam(defaultValue="0") int low_price,
			@RequestParam(defaultValue="999999999") int high_price) {
		
		String areaInput = rq.getAreaMap(area);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		
		if(start_date.equals("")) {
			start_date = format.format(now);
		}
		
		if(end_date.equals("")) {
			try {
				Date date = format.parse(start_date);
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				
				cal.add(Calendar.DATE, 1); // 다음날(1일 후)
				
				end_date = format.format(cal.getTime());
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		List<Company> hotels = companyService.getForPrintHotels(area, order_by, low_price, high_price);
		int hotelsCount = companyService.getHotelsCount(area, low_price, high_price);
		
		model.addAttribute("areaInput", areaInput);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("countOfRooms", countOfRooms);
		model.addAttribute("countOfAdult", countOfAdult);
		model.addAttribute("countOfChild", countOfChild);
		model.addAttribute("hotelsCount", hotelsCount);
		model.addAttribute("hotels", hotels);
		
		return "usr/company/hotel";
	}
}

