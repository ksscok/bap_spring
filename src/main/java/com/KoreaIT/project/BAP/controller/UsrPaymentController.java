package com.KoreaIT.project.BAP.controller;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrPaymentController {
	
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
		
//		System.out.println("orderName : " + orderName);
//		System.out.println("customerName : " + customerName);
			
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("orderId", orderId);
		model.addAttribute("amount", amount);
//		model.addAttribute("orderName", orderName);
//		model.addAttribute("customerName", customerName);
	
		return "/usr/payment/success";
	}
	
	@RequestMapping("/fail")
	public String showPaymentFail() {
		return "/usr/payment/fail";
	}
	
	@RequestMapping("/payment/detail")
	@ResponseBody
	public String showDetail(String paymentKey) throws IOException, InterruptedException {
		
		HttpRequest request = HttpRequest.newBuilder()
			    .uri(URI.create("https://api.tosspayments.com/v1/payments/5R6k3cy8XhGjakmbPt1Vr"))
			    .header("Authorization", "Basic dGVzdF9za196WExrS0V5cE5BcldtbzUwblgzbG1lYXhZRzVSOg==")
			    .method("GET", HttpRequest.BodyPublishers.noBody())
			    .build();
			HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
			System.out.println(response.body());
		
		return response.body();
	}

	
}

