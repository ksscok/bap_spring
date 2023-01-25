package com.KoreaIT.project.BAP.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrHomeController {
	
	private Rq rq;
	
	UsrHomeController(Rq rq) {
		this.rq = rq;
	}
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model,			
			@RequestParam(defaultValue="") String start_date,
			@RequestParam(defaultValue="") String end_date) 		{
		
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
		
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		
		return "usr/home/main";
	}
	
	@RequestMapping("usr/home/doSearch")
	@ResponseBody()
	public String doSearch(String start_date, String end_date, int persons, String searchKeyword) {
		
		if(Ut.empty(start_date)) {
			return rq.jsHistoryBack("체크인 날짜를 선택해주세요.");
		}
		if(Ut.empty(end_date)) {
			return rq.jsHistoryBack("체크아웃 날짜를 선택해주세요.");
		}
		if(Ut.empty(persons)) {
			return rq.jsHistoryBack("인원을 선택해주세요.");
		}
		if(Ut.empty(searchKeyword)) {
			return rq.jsHistoryBack("검색어를 입력해주세요.");
		}
		
		return rq.jsReplace("", rq.afterSearchUri(start_date, end_date, persons, searchKeyword));
	}
	
	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
	
}

