package com.KoreaIT.project.BAP.service;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.ProductRepository;
import com.KoreaIT.project.BAP.vo.Booking;
import com.KoreaIT.project.BAP.vo.Product;

@Service
public class ProductService {
	
	ProductRepository productRepository;
	private BookingService bookingService;
	
	@Autowired
	public ProductService(ProductRepository productRepository, BookingService bookingService) {
		this.productRepository = productRepository;
		this.bookingService = bookingService;
	}

	public Product getForPrintproduct(int id) {
		return productRepository.getForPrintproduct(id);
	}

	public List<Product> getProductsByCompanyId(int comp_id, String start_date, String end_date, String countOfRoom, String countOfAdult, String countOfChild, String withoutMealsType, String withBreakfastType, String withDinnerType, String withBreakfastAndDinnerType, String smokingType, int low_price, int high_price, int diff) throws ParseException {
		List<Product> products = productRepository.getProductsByCompanyId(comp_id, countOfRoom, countOfAdult, countOfChild, withoutMealsType, withBreakfastType, withDinnerType, withBreakfastAndDinnerType, smokingType, low_price, high_price);
		
		List<Product> products2 = new ArrayList<>();
		
		for(Product product : products) {
			
			 int booksCount = bookingService.getBookingCountByComp_idAndProd_id(comp_id, product.getId(), start_date, end_date);
			
			 // 테스트용 코드 - 조건문이 정확한가 확인하기 위해
//			 if(booksCount == 0) {
//				 products2.add(product);
//			 }
			 
			 // 테스트 확인용 출력문
			 System.out.println("--- product.getNumberOfRooms() 개수 = " + product.getNumberOfRooms() + "개 ---");
			 System.out.println("--- (product.getNumberOfRooms() - booksCount) = " + (product.getNumberOfRooms() - booksCount) + " ---");
			 // 실전용 코드 - 위 테스트용 코드 통과했다면 numberOfRooms에서 예약된 수만큼 뺐을 때 1 이상일 때만 리스트에 보여주도록
			 if((product.getNumberOfRooms() - booksCount > 0)) {
				 products2.add(product);
			 }
			 
			// 금액 3자리마다 콤마(,) 붙여주기 위한 코드 시작
			DecimalFormat formatter = new DecimalFormat("###,###");
			// 금액 3자리마다 콤마(,) 붙여주기 위한 코드 끝
			
			String price = "";
			
			if(diff == 0) {
				price = formatter.format(product.getFee());
			} else {
				price = formatter.format(product.getFee() * diff);
			}
			
			product.setExtra__showTotalFee(price); 
		}
		
		return products2;
	}

	public int register(int comp_id, String roomType, int numberOfRooms, int fee, String countOfRoom, String countOfAdult,
			String countOfChild, String includeMeals, String smokingType) {
		return productRepository.register(comp_id, roomType, numberOfRooms, fee, countOfRoom, countOfAdult,
				countOfChild, includeMeals, smokingType);
	}

	public List<Product> getProductsByCompId(int id) {
		return productRepository.getProductsByCompId(id);
	}
}
