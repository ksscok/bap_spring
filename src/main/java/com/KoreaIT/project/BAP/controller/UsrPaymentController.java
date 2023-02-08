package com.KoreaIT.project.BAP.controller;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.project.BAP.service.BookingService;
import com.KoreaIT.project.BAP.service.CancelService;
import com.KoreaIT.project.BAP.service.CancellationApplicationService;
import com.KoreaIT.project.BAP.service.PaymentService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Booking;
import com.KoreaIT.project.BAP.vo.Payment;

@Controller
public class UsrPaymentController {
	
	private PaymentService paymentService;
	private BookingService bookingService;
	private CancellationApplicationService cancellationApplicationService;
	private CancelService cancelService;
	
	@Autowired
	public UsrPaymentController(PaymentService paymentService, BookingService bookingService, CancellationApplicationService cancellationApplicationService, CancelService cancelService) {
		this.paymentService = paymentService;
		this.bookingService = bookingService;
		this.cancellationApplicationService = cancellationApplicationService;
		this.cancelService = cancelService;
	}
	
	@RequestMapping("/usr/payment/doWrite")
	@ResponseBody
	public String doWrite(Model model, String paymentKey, String orderId, String amount, String orderName, String customerName, 
			String status, String method, Object easyPay, String requestedAt, String approvedAt, String type, Object cancels, 
			String lastTransactionKey, String totalAmount, String balanceAmount, String suppliedAmount, String vat) {
		
		if(Ut.empty(paymentKey)) {
			return Ut.jsHistoryBack("결제 키를 입력해주세요");
		}
		
		if(Ut.empty(orderId)) {
			return Ut.jsHistoryBack("주문번호를 입력해주세요");
		}
		
		if(Ut.empty(amount)) {
			return Ut.jsHistoryBack("가격을 입력해주세요");
		}
		
		if(Ut.empty(orderName)) {
			return Ut.jsHistoryBack("주문명을 입력해주세요");
		}
		
		if(Ut.empty(customerName)) {
			return Ut.jsHistoryBack("예약자 이름을 입력해주세요");
		}
		
		if(Ut.empty(status)) {
			return Ut.jsHistoryBack("결제 처리 상태를 입력해주세요");
		}
		
		if(Ut.empty(method)) {
			return Ut.jsHistoryBack("결제 수단을 입력해주세요");
		}
		
		// 어떻게 해야할 지 고민
//		if(Ut.empty(easyPay)) {
//			return Ut.jsHistoryBack(" 입력해주세요");
//		}
		
		if(Ut.empty(requestedAt)) {
			return Ut.jsHistoryBack("결제가 일어난 날짜, 시간을 입력해주세요");
		}
		
		if(Ut.empty(approvedAt)) {
			return Ut.jsHistoryBack("결제 승인 날짜, 시간을 입력해주세요");
		}
		
		if(Ut.empty(type)) {
			return Ut.jsHistoryBack("결제 타입 정보를 입력해주세요");
		}
		
		if(Ut.empty(lastTransactionKey)) {
			return Ut.jsHistoryBack("마지막 거래의 키 값을 입력해주세요");
		}
		
		if(Ut.empty(totalAmount)) {
			return Ut.jsHistoryBack("총 결제 금액을 입력해주세요");
		}
		
		if(Ut.empty(balanceAmount)) {
			return Ut.jsHistoryBack("취소할 수 있는 금액(잔고)을 입력해주세요");
		}
		
		if(Ut.empty(suppliedAmount)) {
			return Ut.jsHistoryBack("공급가액을 입력해주세요");
		}
		
		if(Ut.empty(vat)) {
			return Ut.jsHistoryBack("부가세를 입력해주세요");
		}
		
		Booking booking = bookingService.getBookingByOrderId(orderId);
		int bookingId = booking.getId();
		
		String bank = "토스페이";
		
		int totalA = Integer.parseInt(totalAmount);
		int balanceA = Integer.parseInt(balanceAmount);
		int suppliedA = Integer.parseInt(suppliedAmount);
		int vatA = Integer.parseInt(vat);
		
		paymentService.doWrite(paymentKey, bookingId, status, method, bank, requestedAt, approvedAt, type, lastTransactionKey, totalA, balanceA, suppliedA, vatA);
		
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("orderId", orderId);
		model.addAttribute("amount", amount);
		model.addAttribute("orderName", orderName);
		model.addAttribute("customerName", customerName);
		model.addAttribute("requestedAt", requestedAt);
		
		return Ut.jsReplace("", Ut.f("/usr/booking/detail?orderId=%s", orderId));
	}
	
	@RequestMapping("/usr/payment/cancel")
	public String showCancel(Model model, int booking_id) throws IOException, InterruptedException {
		
		if(Ut.empty(booking_id)) {
			return Ut.jsHistoryBack("예약번호를 입력해주세요");
		}
		
		Booking booking = bookingService.getBookingById(booking_id);
		Payment payment = paymentService.getPaymentByBooking_id(booking_id);
		
		String paymentKey = payment.getPaymentKey();
		
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("booking", booking);
		model.addAttribute("booking.id", booking.getId());
		model.addAttribute("payment", payment);
		
		return "/usr/payment/cancel";
	}
	
	@RequestMapping("/usr/payment/doApply")
	@ResponseBody
	public String doApply(Model model, int booking_id, String title, String body) throws IOException, InterruptedException, ParseException {
		
		if(Ut.empty(booking_id)) {
			return Ut.jsHistoryBack("예약번호를 입력해주세요");
		}
		
		if(Ut.empty(title)) {
			return Ut.jsHistoryBack("취소 사유를 입력해주세요");
		}
		
		if(Ut.empty(body)) {
			return Ut.jsHistoryBack("취소 상세 사유를 입력해주세요");
		}
		
		Booking booking = bookingService.getBookingById(booking_id);
		
		cancellationApplicationService.doWrite(booking_id, title, body, booking.getExtra__prodFee());
		
		return Ut.jsReplace(Ut.f("예약번호 %d번 예약 취소를 신청했습니다.", booking_id), Ut.f("/usr/booking/list?cellphoneNo=%s", booking.getCellphoneNo()));
	}
	
	@RequestMapping("/usr/payment/doCancel")
	@ResponseBody
	public String doCancel(Model model, int booking_id, String title, String body) throws IOException, InterruptedException, ParseException {
		
		if(Ut.empty(booking_id)) {
			return Ut.jsHistoryBack("예약번호를 입력해주세요");
		}
		
		if(Ut.empty(title)) {
			return Ut.jsHistoryBack("취소 사유를 입력해주세요");
		}
		
		if(Ut.empty(body)) {
			return Ut.jsHistoryBack("취소 상세 사유를 입력해주세요");
		}
		
		Booking booking = bookingService.getBookingById(booking_id);
		Payment payment = paymentService.getPaymentByBooking_id(booking_id);
		
		String paymentKey = payment.getPaymentKey();
		
		HttpRequest request = HttpRequest.newBuilder()
				.uri(URI.create("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel"))
				.header("Authorization", "Basic dGVzdF9za19xTGxESmFZbmdyb0xqZ0Q5R214OGV6R2RScFh4Og==")
				.header("Content-Type", "application/json")
				.method("POST", HttpRequest.BodyPublishers.ofString("{\"cancelReason\":\"" + body + "\"}"))
				.build();
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		System.out.println(response.body());
		
		// json 파싱
		JSONParser jsonParser = new JSONParser();
		
		JSONObject jsonObj = (JSONObject) jsonParser.parse(response.body());
		System.out.println("=====================" + jsonObj);
		
		// 복잡한(다중) json의 일부 배열을 때옴
		JSONArray cancels = (JSONArray) jsonObj.get("cancels");
		
		// 때어온 json의 겉에 대괄호를 벗겨내어 단일 json으로 만듦
		JSONObject cancelsObject = (JSONObject) cancels.get(0);
		
		String transactionKey = (String) cancelsObject.get("transactionKey"); // 거래의 키 값 (결제 승인 거래와 취소 거래 구분하는 데 사용)
		Object taxExemptionAmount = (Object) cancelsObject.get("taxExemptionAmount"); // 결제 금액 중 과세 제외 금액(컵 보증금 등)
		Object easyPayDiscountAmount = (Object) cancelsObject.get("easyPayDiscountAmount"); // 간편결제 서비스의 포인트, 쿠폰, 즉시할인과 같은 적립식 결제 수단에서 취소된 금액
		Object cancelAmount = (Object) cancelsObject.get("cancelAmount"); // 취소할 금액
		Object taxFreeAmount = (Object) cancelsObject.get("taxFreeAmount"); // 결제 금액 중 면세 금액
		Object refundableAmount = (Object) cancelsObject.get("refundableAmount"); // 현재 환불 가능한 금액
		
		cancelService.doWrite(booking_id, title, body, transactionKey, taxExemptionAmount, easyPayDiscountAmount, cancelAmount, taxFreeAmount, refundableAmount);
		
		paymentService.doModify(payment.getId());
		
		return Ut.jsReplace(Ut.f("예약번호 %d번 결제가 취소 되었습니다.", booking_id), Ut.f("/usr/booking/list?cellphoneNo=%s", booking.getCellphoneNo()));
	}
	
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
	      
	    String mId = (String) jsonObj.get("mId"); // "tosspayments", 가맹점 ID (쓸 지 안쓸 지 모르겠지만 일단 해놓음)
	    System.out.println("=====================" + mId);
	    String orderName = (String) jsonObj.get("orderName"); // 상품명 (comp_name/prod_name)
	    String status = (String) jsonObj.get("status"); // "DONE", 결제 처리 상태
	    String method = (String) jsonObj.get("method"); // "간편결제", 결제수단 {카드, 가상계좌, 간편결제, 휴대폰, 계좌이체, 상품권(문화상품권, 도서문화상품권, 게임문화상품권)} 
	    Object easyPay = (Object) jsonObj.get("easyPay"); // 간편결제 정보 (provider = 간편결제사 코드, amount = 결제한 금액, discountAmount = 간편결제 서비스의 적립 포인트나 쿠폰 등 사용으로 인한 할인된 금액-아마 이건 카드사의 포인트인듯) 
	    String requestedAt = (String) jsonObj.get("requestedAt"); // 결제가 일어난 날짜, 시간
	    String approvedAt = (String) jsonObj.get("approvedAt"); // 결제 승인 날짜, 시간
	    String type = (String) jsonObj.get("type"); // "NORMAL", 결제 타입 정보 (NORMAL : 일반결제, BILLING : 자동결제, BRANDPAY : 브랜드페이)
	    String cancels = (String) jsonObj.get("cancels"); // "null", 결제 취소 상태
	    String lastTransactionKey = (String) jsonObj.get("lastTransactionKey"); // 마지막 거래의 키 값 (결제 승인 거래와 취소 거래 구분하는 데 사용)
	    Object totalAmount =  (Object) jsonObj.get("totalAmount"); // 총 결제 금액
	    Object balanceAmount = (Object) jsonObj.get("balanceAmount"); // 취소할 수 있는 금액(잔고)
	    Object suppliedAmount = (Object) jsonObj.get("suppliedAmount"); // 공급가액
	    Object vat = (Object) jsonObj.get("vat"); // 부가세 {결제 금액(amount) - 면세 금액(taxFreeAmount)//11후 소수점 첫째 자리에서 반올림
		
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("orderId", orderId);
		model.addAttribute("amount", amount);
		model.addAttribute("orderName", orderName);
		model.addAttribute("status", status);
		model.addAttribute("method", method);
		model.addAttribute("easyPay", easyPay);
		model.addAttribute("requestedAt", requestedAt);
		model.addAttribute("approvedAt", approvedAt);
		model.addAttribute("type", type);
		model.addAttribute("cancels", cancels);
		model.addAttribute("lastTransactionKey", lastTransactionKey);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("balanceAmount", balanceAmount);
		model.addAttribute("suppliedAmount", suppliedAmount);
		model.addAttribute("vat", vat);
	
		return "/usr/payment/success";
	}
	
	@RequestMapping("/fail")
	public String showPaymentFail(Model model, String code, String message, String orderId) {
		return "/usr/payment/fail";
	}
	
}

