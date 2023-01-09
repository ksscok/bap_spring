package com.KoreaIT.project.BAP.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KoreaIT.project.BAP.service.HostService;

@Controller
public class UsrHostController {
	
	HostService hostService;
	
	UsrHostController(HostService hostService) {
		this.hostService = hostService;
	}
	
	@RequestMapping("/usr/host/join")
	public String showJoin() {
		return "usr/host/join";
	}
}

