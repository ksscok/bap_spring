package com.KoreaIT.project.BAP.controller;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
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
	
	@RequestMapping("/success")
	public String showPaymentSuccess(Model model, String paymentKey, String orderId, String amount) throws IOException, InterruptedException {
		
		HttpRequest request = HttpRequest.newBuilder()
			    .uri(URI.create("https://api.tosspayments.com/v1/payments/confirm"))
			    .header("Authorization", "Basic dGVzdF9za19xTGxESmFZbmdyb0xqZ0Q5R214OGV6R2RScFh4Og==")
			    .header("Content-Type", "application/json")
			    .method("POST", HttpRequest.BodyPublishers.ofString("{\"paymentKey\":\"" + paymentKey + "\",\"amount\":\"" + amount + "\",\"orderId\":\"" + orderId + "\"}"))
			    .build();
			HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
			System.out.println(response.body());
		
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("orderId", orderId);
		model.addAttribute("amount", amount);
	
		return "/usr/payment/success";
	}
	
	@RequestMapping("/fail")
	public String showPaymentFail() {
		return "/usr/payment/fail";
	}
	
}

