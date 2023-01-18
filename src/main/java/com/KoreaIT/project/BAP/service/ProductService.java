package com.KoreaIT.project.BAP.service;

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

	public List<Product> getProductsByCompanyId(int comp_id, String countOfRoom, String countOfAdult, String countOfChild, String withoutMealsType, String withBreakfastType, String withDinnerType, String withBreakfastAndDinnerType, String smokingType, int low_price, int high_price) {
		return productRepository.getProductsByCompanyId(comp_id, countOfRoom, countOfAdult, countOfChild, withoutMealsType, withBreakfastType, withDinnerType, withBreakfastAndDinnerType, smokingType, low_price, high_price);
	}
}
