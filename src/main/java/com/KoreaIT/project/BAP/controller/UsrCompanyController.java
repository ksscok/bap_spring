package com.KoreaIT.project.BAP.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.service.GenFileService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.ResultData;
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
	public String doRegister(String name, String address, MultipartRequest multipartRequest) {
		
		if(Ut.empty(name)) {
			return rq.jsHistoryBack("상호를 등록해주세요.");
		}
		if(Ut.empty(address)) {
			return rq.jsHistoryBack("사업장 주소를 등록해주세요.");
		}
		
		int newCompanyId = companyService.register(name, address);
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
            MultipartFile multipartFile = fileMap.get(fileInputName);
            if ( multipartFile.isEmpty() == false ) {
                genFileService.save(multipartFile, newCompanyId);
            }
        }
		
		return rq.jsReplace(Ut.f("%d번 사업장이 등록되었습니다.", newCompanyId), "/");
	}
}

