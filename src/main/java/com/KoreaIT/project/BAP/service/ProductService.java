package com.KoreaIT.project.BAP.service;

import java.text.DecimalFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.ProductRepository;
import com.KoreaIT.project.BAP.vo.Product;

@Service
public class ProductService {
	
	ProductRepository productRepository;
	
	@Autowired
	public ProductService(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}

	public Product getForPrintproduct(int id) {
		return productRepository.getForPrintproduct(id);
	}

	public List<Product> getProductsByCompanyId(int comp_id, String countOfRoom, String countOfAdult, String countOfChild, String withoutMealsType, String withBreakfastType, String withDinnerType, String withBreakfastAndDinnerType, String smokingType, int low_price, int high_price, int diff) {
		List<Product> products = productRepository.getProductsByCompanyId(comp_id, countOfRoom, countOfAdult, countOfChild, withoutMealsType, withBreakfastType, withDinnerType, withBreakfastAndDinnerType, smokingType, low_price, high_price);
		
		for(Product product : products) {
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
		
		return products;
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
