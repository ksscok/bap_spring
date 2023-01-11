package com.KoreaIT.project.BAP.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.KoreaIT.project.BAP.service.GenFileService;
import com.KoreaIT.project.BAP.service.HostService;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrHostController {
	
	private HostService hostService;
	private GenFileService genFileService;
	private Rq rq;
	
	UsrHostController(HostService hostService, GenFileService genFileService, Rq rq) {
		this.hostService = hostService;
		this.genFileService = genFileService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/host/register")
	public String showRegister() {
		return "usr/host/register";
	}
	
	@RequestMapping("/usr/host/doRegister")
	@ResponseBody
	public String doRegister(MultipartRequest multipartRequest) {
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
            MultipartFile multipartFile = fileMap.get(fileInputName);
            if ( multipartFile.isEmpty() == false ) {
                genFileService.save(multipartFile);
            }
        }
		
		return rq.jsReplace("상품 이미지가 등록되었습니다.", "/usr/host/register");
	}
}

