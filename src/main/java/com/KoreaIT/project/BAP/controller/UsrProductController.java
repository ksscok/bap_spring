package com.KoreaIT.project.BAP.controller;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.KoreaIT.project.BAP.service.CompanyService;
import com.KoreaIT.project.BAP.service.GenFileService;
import com.KoreaIT.project.BAP.service.ProductService;
import com.KoreaIT.project.BAP.service.ReviewService;
import com.KoreaIT.project.BAP.service.WishService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Product;
import com.KoreaIT.project.BAP.vo.Review;
import com.KoreaIT.project.BAP.vo.Rq;
import com.KoreaIT.project.BAP.vo.Wish;

@Controller
public class UsrProductController {
	
	private ProductService productService;
	private CompanyService companyService;
	GenFileService genFileService;
	private WishService wishService;
	private ReviewService reviewService;
	private Rq rq;
	
	@Autowired
	public UsrProductController(ProductService productService, CompanyService companyService, GenFileService genFileService, WishService wishService, ReviewService reviewService, Rq rq) {
		this.productService = productService;
		this.companyService = companyService;
		this.genFileService = genFileService;
		this.wishService = wishService;
		this.reviewService = reviewService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/product/detail")
	public String showDetail(Model model, int comp_id,
			@RequestParam(defaultValue="") String start_date,
			@RequestParam(defaultValue="") String end_date,
			@RequestParam(defaultValue="1") String countOfRoom,
			@RequestParam(defaultValue="2") String countOfAdult,
			@RequestParam(defaultValue="0") String countOfChild,
			@RequestParam(defaultValue="") String withoutMealsType,
			@RequestParam(defaultValue="") String withBreakfastType,
			@RequestParam(defaultValue="") String withDinnerType,
			@RequestParam(defaultValue="") String withBreakfastAndDinnerType,
			@RequestParam(defaultValue="") String smokingType,
			@RequestParam(defaultValue="1") int low_price,
			@RequestParam(defaultValue="999999999") int high_price) {
		
		if(Ut.empty(comp_id)) {
			return rq.historyBackJsOnView("사업장번호를 입력해주세요.");
		}
		
		// 파라미터 입력용 테스트 데이터 - 나중에 리스트에서부터 받아오거나 리스트에서 안할 경우를 생각해서 디폴트 값으로 그냥 넣어도 될듯(대신 이때는 Ut클래스에 생성해야 할 듯)
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
		// 여기까지
		
		Company company = companyService.getCompanyByComp_id(comp_id);
		
		List<Product> products = productService.getProductsByCompanyId(comp_id, countOfRoom, countOfAdult, countOfChild, withoutMealsType, withBreakfastType, withDinnerType, withBreakfastAndDinnerType, smokingType, low_price, high_price);
		
		// 예약페이지에서 orderId를 만들 때 필요한 숙박타입 코드를 넘겨주기 위한 부분 시작
		String accommodationTypeCode = "-1";
		if(company.getAccommodationType().equals("motel")) {
			accommodationTypeCode = "1";
		}else if(company.getAccommodationType().equals("hotel")) {
			accommodationTypeCode = "2";
		}else if(company.getAccommodationType().equals("pension")) {
			accommodationTypeCode = "3";
		}else if(company.getAccommodationType().equals("guesthouse")) {
			accommodationTypeCode = "4";
		}
		// 예약페이지에서 orderId를 만들 때 필요한 숙박타입 코드를 넘겨주기 위한 부분 끝
		
		Wish wish = null;
		
		if(rq.isLogined()) {
			wish = wishService.getWishByMemberIdAndComp_id(rq.getLoginedMemberId(), comp_id);
		}
		
		List<Review> reviews = reviewService.getForPrintReviews(rq.getLoginedMemberId(), comp_id);
		
		//평균 평점 구하기 시작
		int totalRating = 0;
		
		for(Review review : reviews) {
			totalRating += review.getRating();
		}
		
		// 실수를 소수점 첫째자리까지 자르기 위한 함수
		DecimalFormat df = new DecimalFormat("0.0"); 
		
		String avg = "";
		int avgStarCount = 0;
				
		if(reviews.size() != 0) {
			avg = df.format(totalRating/ (double) reviews.size());
			avgStarCount = (int) Math.floor(totalRating/reviews.size());
		}
		//평균 평점 구하기 끝
		
		// 평점 옵션 시작
		Map<Integer, String> ratingOptions = new HashMap<>();
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
		// 평점 옵션 시작 끝
		model.addAttribute("ratingOptions", ratingOptions);
		
		model.addAttribute("comp_id", comp_id);
		model.addAttribute("countOfRoom", countOfRoom);
		model.addAttribute("countOfAdult", countOfAdult);
		model.addAttribute("countOfChild", countOfChild);
		model.addAttribute("withoutMealsType", withoutMealsType);
		model.addAttribute("withBreakfastType", withBreakfastType);
		model.addAttribute("withDinnerType", withDinnerType);
		model.addAttribute("withBreakfastAndDinnerType", withBreakfastAndDinnerType);
		model.addAttribute("smokingType", smokingType);
		model.addAttribute("low_price", low_price);
		model.addAttribute("high_price", high_price);
		model.addAttribute("company", company);
		model.addAttribute("products", products);
		model.addAttribute("accommodationTypeCode", accommodationTypeCode);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("wish", wish);
		model.addAttribute("reviews", reviews);
		model.addAttribute("avg", avg);
		model.addAttribute("avgStarCount", avgStarCount);
		
		return "usr/product/detail";
	}
	
	@RequestMapping("/usr/product/register")
	public String showRegister() {
		
		return "usr/product/register";
	}
	
	@RequestMapping("/usr/product/doRegister")
	@ResponseBody
	public String doRegister(int comp_id, String roomType, int numberOfRooms, int fee, String countOfRoom, 
			String countOfAdult, String countOfChild, String includeMeals, 
			String smokingType, MultipartRequest multipartRequest) {
		
		if(Ut.empty(roomType)) {
			return rq.jsHistoryBack("객실 이름을 입력해주세요.");
		}
		if(Ut.empty(numberOfRooms)) {
			return rq.jsHistoryBack("객실 개수를 입력해주세요.");
		}
		if(Ut.empty(fee)) {
			return rq.jsHistoryBack("객실 요금을 입력해주세요.");
		}
		if(Ut.empty(countOfRoom)) {
			return rq.jsHistoryBack("countOfRoom을 입력해주세요.");
		}
		if(Ut.empty(countOfAdult)) {
			return rq.jsHistoryBack("성인 인원을 입력해주세요.");
		}
		if(Ut.empty(countOfChild)) {
			return rq.jsHistoryBack("아동 인원을 입력해주세요.");
		}
		if(Ut.empty(includeMeals)) {
			return rq.jsHistoryBack("식사 정보를 입력해주세요.");
		}
		if(Ut.empty(smokingType)) {
			return rq.jsHistoryBack("흡연 가능 여부를 입력해주세요.");
		}
		
		int newProductId = productService.register(comp_id, roomType, numberOfRooms, fee, countOfRoom, countOfAdult, countOfChild, includeMeals, smokingType);
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
            MultipartFile multipartFile = fileMap.get(fileInputName);
            if ( multipartFile.isEmpty() == false ) {
                genFileService.save(multipartFile, newProductId);
            }
        }
		
		return rq.jsReplace("객실이 등록되었습니다.", "../management/productList?id=" + comp_id);
	}
}
