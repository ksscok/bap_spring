package com.KoreaIT.project.BAP.controller;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrPaymentController {
	
	@RequestMapping("/success")
	public String showPaymentSuccess(Model model, String paymentKey, String orderId, String amount) throws IOException, InterruptedException, ParseException {
		
		HttpRequest request = HttpRequest.newBuilder()
			    .uri(URI.create("https://api.tosspayments.com/v1/payments/confirm"))
			    .header("Authorization", "Basic dGVzdF9za19xTGxESmFZbmdyb0xqZ0Q5R214OGV6R2RScFh4Og==")
			    .header("Content-Type", "application/json")
			    .method("POST", HttpRequest.BodyPublishers.ofString("{\"paymentKey\":\"" + paymentKey + "\",\"amount\":\"" + amount + "\",\"orderId\":\"" + orderId + "\"}"))
			    .build();
			HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
			System.out.println(response.body());
		
		// json 파싱
		JSONParser jsonParser = new JSONParser();
	      
	    JSONObject jsonObj = (JSONObject) jsonParser.parse(response.body());
	    System.out.println("=====================" + jsonObj);
	      
	    String orderName = (String) jsonObj.get("orderName");
	    System.out.println("=====================" + orderName);
		
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("orderId", orderId);
		model.addAttribute("amount", amount);
		model.addAttribute("orderName", orderName);
	
		return "/usr/payment/success";
	}
	
	@RequestMapping("/fail")
	public String showPaymentFail() {
		return "/usr/payment/fail";
	}
	
}

