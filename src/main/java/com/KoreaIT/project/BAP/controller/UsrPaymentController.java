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
import com.KoreaIT.project.BAP.service.MemberService;
import com.KoreaIT.project.BAP.service.PaymentService;
import com.KoreaIT.project.BAP.service.PointService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Booking;
import com.KoreaIT.project.BAP.vo.Member;
import com.KoreaIT.project.BAP.vo.Payment;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrPaymentController {
	
	private MemberService memberService;
	private PaymentService paymentService;
	private BookingService bookingService;
	private CancelService cancelService;
	private PointService pointService;
	private Rq rq;
	
	@Autowired
	public UsrPaymentController(MemberService memberService, PaymentService paymentService, BookingService bookingService, CancelService cancelService, PointService pointService, Rq rq) {
		this.memberService = memberService;
		this.paymentService = paymentService;
		this.bookingService = bookingService;
		this.cancelService = cancelService;
		this.pointService = pointService;
		this.rq = rq;
	}
	 
	@RequestMapping("/success")
	@ResponseBody
	public String showPaymentSuccess(Model model, String paymentKey, String orderId, String amount) throws IOException, InterruptedException, ParseException {
		
		if(Ut.empty(paymentKey)) {
			return rq.historyBackJsOnView("결제 키를 입력해주세요");
		}
		
		if(Ut.empty(orderId)) {
			return rq.historyBackJsOnView("주문 번호를 입력해주세요");
		}
		
		if(Ut.empty(amount)) {
			return rq.historyBackJsOnView("실제 결제 금액을 입력해주세요");
		}
		
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
	    // 카드사에 관련된 금액들 시작
	    Object totalAmount =  (Object) jsonObj.get("totalAmount"); // 총 결제 금액
	    Object balanceAmount = (Object) jsonObj.get("balanceAmount"); // 취소할 수 있는 금액(잔고)
	    Object suppliedAmount = (Object) jsonObj.get("suppliedAmount"); // 공급가액
	    Object vat = (Object) jsonObj.get("vat"); // 부가세 {결제 금액(amount) - 면세 금액(taxFreeAmount)//11후 소수점 첫째 자리에서 반올림
	    // 카드사에 관련된 금액들 끝
		
	    
	    Booking booking = bookingService.getBookingByOrderId(orderId);
		int bookingId = booking.getId();
		// 실제 이 프로젝트에 관련된 금액들 시작
		int lastTotalAmount = booking.getLastTotalAmount(); // 총 결제 금액
		int pay_point = booking.getPay_point(); // 사용한 포인트
		int paidRealAmount = booking.getPaidRealAmount(); // 실제 결제 금액(취소할 수 있는 금액) = 총 결제 금액 - 사용한 포인트
		// 실제 이 프로젝트에 관련된 금액들 끝
		
		String bank = "토스페이";
		
		paymentService.doWrite(paymentKey, bookingId, status, method, bank, requestedAt, approvedAt, type, lastTransactionKey, lastTotalAmount, pay_point, paidRealAmount);
		
		int savePoint = (int) (paidRealAmount/((double) 50)); // 결제시 적립 포인트 = 2%인 상태
		
		int payment_id = paymentService.getLastInsertId();
		
		String PointStatus = "done";
		
		if(rq.getLoginedMemberId() != 0) {
			
			pay_point = -pay_point;
			memberService.doModifyPoint(rq.getLoginedMemberId(), pay_point, savePoint);
			pointService.doWrite(rq.getLoginedMemberId(), payment_id, pay_point, PointStatus); // 결제에 사용한 포인트
			pointService.doWrite(rq.getLoginedMemberId(), payment_id, savePoint, PointStatus); // 결제로 인해 적립된 포인트
		}
	    
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
	
		if(rq.getLoginedMemberId() == 0) {
			return Ut.jsReplace("결제가 완료되었습니다.", Ut.f("/usr/booking/detail?orderId=%s", orderId));
		}
		
		return Ut.jsReplace(Ut.f("%d 포인트가 적립되었습니다.", savePoint), Ut.f("/usr/booking/detail?orderId=%s", orderId));
	}
	
	@RequestMapping("/fail")
	public String showPaymentFail(Model model, String code, String message) {
		
		if(Ut.empty(code)) {
			return rq.historyBackJsOnView("에러 코드를 입력해주세요");
		}
		
		if(Ut.empty(message)) {
			return rq.historyBackJsOnView("에러 메세지를 입력해주세요");
		}
		
		return "/usr/payment/fail";
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
		// 카드사에 관련된 금액들 시작
		Object taxExemptionAmount = (Object) cancelsObject.get("taxExemptionAmount"); // 결제 금액 중 과세 제외 금액(컵 보증금 등)
		Object easyPayDiscountAmount = (Object) cancelsObject.get("easyPayDiscountAmount"); // 간편결제 서비스의 포인트, 쿠폰, 즉시할인과 같은 적립식 결제 수단에서 취소된 금액
		Object cancelAmount = (Object) cancelsObject.get("cancelAmount"); // 취소할 금액
		Object taxFreeAmount = (Object) cancelsObject.get("taxFreeAmount"); // 결제 금액 중 면세 금액
		Object refundableAmount = (Object) cancelsObject.get("refundableAmount"); // 현재 환불 가능한 금액
		// 카드사에 관련된 금액들 끝
		
		// 실제 이 프로젝트에 관련된 금액들 시작
		int lastTotalAmount = booking.getLastTotalAmount(); // 총 결제 금액
		int pay_point = booking.getPay_point(); // 사용한 포인트
		int paidRealAmount = booking.getPaidRealAmount(); // 실제 결제 금액(취소할 수 있는 금액) = 총 결제 금액 - 사용한 포인트
		// 실제 이 프로젝트에 관련된 금액들 끝
		
		cancelService.doWrite(booking_id, title, body, transactionKey, lastTotalAmount, pay_point, paidRealAmount);
		
		paymentService.doModify(payment.getId());
		
		String status = "cancel";
		
		bookingService.doModifyStatus(booking.getId(), status);
		
		Member member = memberService.getMemberByCellphoneNo(booking.getCellphoneNo());
		
		if(member != null) {
			int savePoint = (int) (paidRealAmount/((double) 50)); // 결제시 적립 포인트 = 2%인 상태
			savePoint = -savePoint;
			
			// 여기서 login한 회원은 예약(결제)를 행한 게스트가 아니라 호스트이고 그 호스트가 예약(결제)를 취소하기 때문에 해당 memberId를 가지고 write를 하는 것
			memberService.doModifyPoint(member.getId(), pay_point, savePoint);
			pointService.doWrite(member.getId(), payment.getId(), pay_point, status); // 결제에 사용한 포인트
			pointService.doWrite(member.getId(), payment.getId(), savePoint, status); // 결제로 인해 적립된 포인트
		}
		
		return Ut.jsReplace(Ut.f("예약번호 %d번 결제가 취소 되었습니다.", booking_id), Ut.f("/usr/booking/detail?orderId=%s", booking.getOrderId()));
	}
	
}

