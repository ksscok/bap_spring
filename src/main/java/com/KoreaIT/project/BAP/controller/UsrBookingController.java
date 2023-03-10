package com.KoreaIT.project.BAP.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.project.BAP.service.BookingService;
import com.KoreaIT.project.BAP.service.CancelReasonService;
import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.service.MemberService;
import com.KoreaIT.project.BAP.service.PaymentService;
import com.KoreaIT.project.BAP.service.ProductService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Booking;
import com.KoreaIT.project.BAP.vo.CancelReason;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Member;
import com.KoreaIT.project.BAP.vo.Payment;
import com.KoreaIT.project.BAP.vo.Product;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrBookingController {
	
	private MemberService memberService;
	private CompanyService companyService;
	private ProductService productService;
	private BookingService bookingService;
	private PaymentService paymentService;
	private CancelReasonService cancelReasonService;
	private Rq rq;
	
	@Autowired
	public UsrBookingController(MemberService memberService, CompanyService companyService, ProductService productService, BookingService bookingService, PaymentService paymentService, CancelReasonService cancelReasonService, Rq rq) {
		this.memberService = memberService;
		this.companyService = companyService;
		this.productService = productService;
		this.bookingService = bookingService;
		this.paymentService = paymentService;
		this.cancelReasonService = cancelReasonService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/booking/book")
	public String showBook(Model model, int comp_id, int prod_id, String start_date, String end_date,
			@RequestParam(defaultValue="2") String countOfAdult, 
			@RequestParam(defaultValue="0") String countOfChild,
			@RequestParam(defaultValue="-1") String accommodationTypeCode) {
		
		if(Ut.empty(comp_id)) {
			return rq.historyBackJsOnView("사업장번호를 입력해주세요.");
		}
		
		if(Ut.empty(prod_id)) {
			return rq.historyBackJsOnView("상품번호를 입력해주세요.");
		}
		
		if(Ut.empty(start_date)) {
			return rq.historyBackJsOnView("체크인 날짜를 선택해주세요.");
		}
		
		if(Ut.empty(end_date)) {
			return rq.historyBackJsOnView("체크아웃 날짜를 선택해주세요.");
		}
		
		// 오늘 날짜(예약을 실행한 날짜) - 주문번호를 위한 날짜정보
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmss");
		Date now = new Date();
		String today = format.format(now);
		
		// 예약번호
		int resev_id =  (bookingService.getLastInsertId() + 1);
		
		// 주문번호 = 예약날짜 + 숙박타입코드 + comp_id + prod_id + 예약번호
		String orderId = today + "a" + accommodationTypeCode + "c" + comp_id + "p" + prod_id + resev_id;
		
		Company company = companyService.getCompanyByComp_id(comp_id);
		
		Product product = productService.getForPrintproduct(prod_id);
		
		Member member = null;
		
		if(rq.getLoginedMemberId() != 0) {
			member = memberService.getMemberById(rq.getLoginedMemberId());
		}
		
		// 예약페이지에서 체크인, 체크아웃에 요일 보여주기 위한 날짜방식
		String DateAndDayOfTheWeekOfChkin = Ut.getDateAndDayOfTheWeek(start_date);
		String DateAndDayOfTheWeekOfChkout = Ut.getDateAndDayOfTheWeek(end_date);
		
		// 예약페이지에서 몇박인지 보여주기 위한 (체크인-체크아웃)값 불러오는 코드
		int diff = Ut.getDiffBetweenDate1AndDate2(start_date, end_date);
		
		// 금액 3자리마다 콤마(,) 붙여주기 위한 코드 시작
		DecimalFormat formatter = new DecimalFormat("###,###");
		String price = formatter.format(product.getFee() * diff);
		// 금액 3자리마다 콤마(,) 붙여주기 위한 코드 끝
				
        
		model.addAttribute("comp_id", comp_id);
		model.addAttribute("prod_id", prod_id);
		model.addAttribute("orderId", orderId);
		model.addAttribute("company", company);
		model.addAttribute("product", product);
		model.addAttribute("price", price);
		model.addAttribute("member", member);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("countOfAdult", countOfAdult);
		model.addAttribute("countOfChild", countOfChild);
		model.addAttribute("DateAndDayOfTheWeekOfChkin", DateAndDayOfTheWeekOfChkin);
		model.addAttribute("DateAndDayOfTheWeekOfChkout", DateAndDayOfTheWeekOfChkout);
		model.addAttribute("diff", diff);
		
		return "usr/booking/book";
	}

	@RequestMapping("/usr/booking/doBook")
	@ResponseBody
	public String doBook(String orderId, int comp_id, int prod_id, String customerName, String cellphoneNo, String start_date, String end_date, 
			int countOfAdult, @RequestParam(defaultValue="0") int countOfChild, String DateAndDayOfTheWeekOfChkin, String DateAndDayOfTheWeekOfChkout, String amount, @RequestParam(defaultValue="0") String pay_point, String realAmount, String orderName, int diff) {
		
		if(Ut.empty(comp_id)) {
			return Ut.jsHistoryBack("사업장번호를 입력해주세요.");
		}
		
		if(Ut.empty(prod_id)) {
			return Ut.jsHistoryBack("상품번호를 입력해주세요.");
		}
		
		if(Ut.empty(customerName)) {
			return Ut.jsHistoryBack("예약자 이름을 입력해주세요.");
		}
		
		if(Ut.empty(cellphoneNo)) {
			return Ut.jsHistoryBack("전화번호를 입력해주세요.");
		}
		
		if(Ut.empty(start_date)) {
			return Ut.jsHistoryBack("체크인 날짜를 입력해주세요.");
		}
		
		if(Ut.empty(end_date)) {
			return Ut.jsHistoryBack("체크아웃 날짜를 입력해주세요.");
		}
		
		if(Ut.empty(countOfAdult)) {
			return Ut.jsHistoryBack("성인 인원 수를 입력해주세요.");
		}
		
		if(Ut.empty(DateAndDayOfTheWeekOfChkin)) {
			return Ut.jsHistoryBack("체크인 요일을 입력해주세요.");
		}
		
		if(Ut.empty(DateAndDayOfTheWeekOfChkout)) {
			return Ut.jsHistoryBack("체크아웃 요일을 입력해주세요.");
		}
		
		if(Ut.empty(amount)) {
			return Ut.jsHistoryBack("총 결제 금액을 입력해주세요.");
		}
		
		if(Ut.empty(realAmount)) {
			return Ut.jsHistoryBack("실제 결제 금액을 입력해주세요.");
		}
		
		if(Ut.empty(orderName)) {
			return Ut.jsHistoryBack("숙소명과 방 타입을 입력해주세요.");
		}
		
		if(Ut.empty(diff)) {
			return Ut.jsHistoryBack("숙박 일수를 입력해주세요.");
		}
		
		int lastTotalAmount = Integer.parseInt(amount);
		int p_point = Integer.parseInt(pay_point.replace(",", "").trim());
		int paidRealAmount = Integer.parseInt(realAmount.replace(",", "").trim());
		
		System.out.println("====customerName : " + customerName + " ====");
		
		// 예약 내역(pay.jsp)페이지에서 새로고침 할 때마다 doWrite 일어나는거 막기 (실패)
		bookingService.doWrite(orderId, comp_id, prod_id, customerName, cellphoneNo, start_date, end_date, diff, countOfAdult, countOfChild, lastTotalAmount, p_point, paidRealAmount);
		
		// 예약번호 확인 시켜주기 위해서
		int bookingId = bookingService.getLastInsertId();
		
		Booking booking = bookingService.getBookingById(bookingId);
		booking.setExtra__status("결제 대기중");
		
		String book_id = ("" + bookingId).trim(); // int 타입을 string 타입으로 변환
		
		return book_id;
	}
	
	@RequestMapping("/usr/booking/list")
	public String showList(Model model, String cellphoneNo,
			@RequestParam(defaultValue = "booking_id") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {
		
		if(Ut.empty(cellphoneNo)) {
			return rq.historyBackJsOnView("전화번호를 입력해주세요.");
		}
		
		List<Booking> bookings = bookingService.getForPrintBookingsByCellphoneNo(cellphoneNo, searchKeywordTypeCode, searchKeyword);
		
		int bookingsCount = bookingService.getBookingsCount(cellphoneNo, searchKeywordTypeCode, searchKeyword);
		
		model.addAttribute("bookings", bookings);
		model.addAttribute("cellphoneNo", cellphoneNo);
		model.addAttribute("bookingsCount", bookingsCount);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "/usr/booking/list";
	}
	
	@RequestMapping("/usr/booking/detailConfirm")
	public String showDetailConfirm() {
		return "/usr/booking/detailConfirm";
	}
	
	@RequestMapping("/usr/booking/doDetailComfirm")
	@ResponseBody
	public String doDetailComfirm(Model model, String cellphoneNo, String searchKeyword) {
		
		if(Ut.empty(cellphoneNo)) {
			return Ut.jsHistoryBack("전화번호를 입력해주세요");
		}
		
		// booking/detail에서 bookingId를 searchKeyword로 받기 때문에
		if(Ut.empty(searchKeyword)) {
			return Ut.jsHistoryBack("예약번호를 입력해주세요");
		}
		
		int id = Integer.parseInt(searchKeyword);
		
		Booking booking = bookingService.getBookingById(id);
		
		if(!booking.getCellphoneNo().equals(cellphoneNo)) {
			return Ut.jsReplace( Ut.f("입력하신 전화번호(%s)와 예약번호(%s)에 일치하는 예약이 존재하지 않습니다.", cellphoneNo, searchKeyword), "/usr/booking/detailConfirm");
		}
		
		
		return Ut.jsReplace("", Ut.f("/usr/booking/detail?orderId=%s", booking.getOrderId()));
	}
	
	@RequestMapping("/usr/booking/detail")
	public String showDetail(Model model, String orderId) {
		
		if(Ut.empty(orderId)) {
			return rq.historyBackJsOnView("주문번호를 입력해주세요.");
		}
		
		Booking booking = bookingService.getBookingByOrderId(orderId);
		String start_date = booking.getStart_date();
		String end_date = booking.getEnd_date();
		
		// 예약 상세보기 페이지에서 체크인, 체크아웃에 요일 보여주기 위한 날짜방식
		String dateAndDayOfTheWeekOfChkin = Ut.getDateAndDayOfTheWeek(start_date);
		String dateAndDayOfTheWeekOfChkout = Ut.getDateAndDayOfTheWeek(end_date);
		
		Company company = companyService.getCompanyByComp_id(booking.getComp_id());
		String timeChkin = company.getTimeChkin();
		String timeChkout = company.getTimeChkout();
		
		Product product = productService.getForPrintproduct(booking.getProd_id());
		
		Payment payment = paymentService.getPaymentByBooking_id(booking.getId());
		
		String requestedAt = payment.getRequestedAt();
		
		LocalDateTime dateTime = LocalDateTime.from(Instant.from(DateTimeFormatter.ISO_DATE_TIME.parse(requestedAt)).atZone(ZoneId.of("Asia/Seoul")));
		
		model.addAttribute("booking", booking);
		model.addAttribute("payment", payment);
		model.addAttribute("dateAndDayOfTheWeekOfChkin", dateAndDayOfTheWeekOfChkin);
		model.addAttribute("dateAndDayOfTheWeekOfChkout", dateAndDayOfTheWeekOfChkout);
		model.addAttribute("company", company);
		model.addAttribute("timeChkin", timeChkin);
		model.addAttribute("timeChkout", timeChkout);
		model.addAttribute("product", product);
		model.addAttribute("requestedAt", requestedAt);
		model.addAttribute("dateTime", dateTime);
		
		return "/usr/booking/detail";
	}
	
	@RequestMapping("/usr/booking/cancelWrite")
	public String showCancelWrite(Model model, int booking_id) {
		
		if(Ut.empty(booking_id)) {
			return rq.historyBackJsOnView("예약번호를 입력해주세요");
		}
		
		Booking booking = bookingService.getBookingById(booking_id);
		Payment payment = paymentService.getPaymentByBooking_id(booking_id);
		
		String paymentKey = payment.getPaymentKey();
		
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("booking.id", booking.getId());
		model.addAttribute("booking", booking);
		model.addAttribute("payment", payment);
		
		return "/usr/booking/cancelWrite";
	}
	
	@RequestMapping("/usr/booking/doCancelWrite")
	@ResponseBody
	public String doCancelWrite(Model model, int booking_id, @RequestParam(defaultValue = "guest") String memberType, String title, String body) {
		
		if(Ut.empty(booking_id)) {
			return Ut.jsHistoryBack("예약번호를 입력해주세요");
		}
		
		if(Ut.empty(title)) {
			return Ut.jsHistoryBack("취소 사유를 입력해주세요");
		}
		
		if(Ut.empty(body)) {
			return Ut.jsHistoryBack("취소 상세 사유를 입력해주세요");
		}
		
		String status = "cancel_apply";
		
		// host의 사정으로 예약 신청을 취소할 때
		if(rq.getLoginedMember().getMemberType().equals("host")) {
			memberType = "host";
			status = "cancel";
		}
		
		Booking booking = bookingService.getBookingById(booking_id);
		
		cancelReasonService.doWrite(booking_id, memberType, title, body, booking.getPaidRealAmount());
		
		bookingService.doModifyStatus(booking.getId(), status);
		
		if(rq.getLoginedMember().getMemberType().equals("host")) {
			return Ut.jsReplace("", Ut.f("/usr/payment/doCancel?booking_id=%d&title=%s&body=%s", booking.getId(), title, body));
		}
		
		return Ut.jsReplace(Ut.f("예약번호 %d번 예약 취소를 신청했습니다.", booking_id), Ut.f("/usr/booking/detail?orderId=%s", booking.getOrderId()));
	}
	
	@RequestMapping("/usr/booking/cancelDetail")
	public String showCancelDetail(Model model, int booking_id) {
		
		if(Ut.empty(booking_id)) {
			return rq.historyBackJsOnView("예약번호를 입력해주세요");
		}
		
		Booking booking = bookingService.getBookingById(booking_id);
		Payment payment = paymentService.getPaymentByBooking_id(booking_id);
		
		CancelReason cancelReason = cancelReasonService.getCancelReasonByBooking_id(booking_id);
		
		model.addAttribute("booking_id", booking_id);
		model.addAttribute("booking", booking);
		model.addAttribute("payment", payment);
		model.addAttribute("cancelReason", cancelReason);
		
		return "/usr/booking/cancelDetail";
	}
	
	@RequestMapping("/usr/booking/cancelModify")
	public String showCancelModify(Model model, int booking_id) {
		
		if(Ut.empty(booking_id)) {
			return rq.historyBackJsOnView("예약번호를 입력해주세요");
		}
		
		Booking booking = bookingService.getBookingById(booking_id);
		Payment payment = paymentService.getPaymentByBooking_id(booking_id);
		
		CancelReason cancelReason = cancelReasonService.getCancelReasonByBooking_id(booking_id);
		
		model.addAttribute("booking_id", booking_id);
		model.addAttribute("booking", booking);
		model.addAttribute("payment", payment);
		model.addAttribute("cancelReason", cancelReason);
		
		return "/usr/booking/cancelModify";
	}
	
	@RequestMapping("/usr/booking/doCancelModify")
	@ResponseBody
	public String doCancelModify(Model model, int booking_id, String title, String body) {
		
		if(Ut.empty(booking_id)) {
			return Ut.jsHistoryBack("예약번호를 입력해주세요");
		}
		
		if(Ut.empty(title)) {
			return Ut.jsHistoryBack("취소 사유를 입력해주세요");
		}
		
		if(Ut.empty(body)) {
			return Ut.jsHistoryBack("취소 상세 사유를 입력해주세요");
		}
		
		cancelReasonService.doModify(booking_id, title, body);
		
		Booking booking = bookingService.getBookingById(booking_id);
		Payment payment = paymentService.getPaymentByBooking_id(booking_id);
		
		CancelReason cancelReason = cancelReasonService.getCancelReasonByBooking_id(booking_id);
		
		model.addAttribute("booking_id", booking_id);
		model.addAttribute("booking", booking);
		model.addAttribute("payment", payment);
		model.addAttribute("cancelReason", cancelReason);
		
		return Ut.jsReplace("취소 사유를 수정했습니다.", Ut.f("/usr/booking/cancelDetail?booking_id=%s", booking_id));
	}
	
	@RequestMapping("/usr/booking/cancelDelete")
	@ResponseBody
	public String doCancelDelete(Model model, int booking_id) {
		
		if(Ut.empty(booking_id)) {
			return Ut.jsHistoryBack("예약번호를 입력해주세요");
		}
		
		Booking booking = bookingService.getBookingById(booking_id);
		
		cancelReasonService.doDelete(booking_id);
		
		bookingService.doModifyStatus(booking_id, "done");
		
		return Ut.jsReplace("다시 예약이 되었습니다.", Ut.f("/usr/booking/detail?orderId=%s", booking.getOrderId()));
	}
	
}
