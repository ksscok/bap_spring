package com.KoreaIT.project.BAP.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.ProductRepository;
import com.KoreaIT.project.BAP.vo.Product;

@Service
public class ProductService {
	
	ProductRepository productRepository;
	
	ProductService(ProductRepository productRepository) {
		this.productRepository = productRepository;
	}

	public List<Product> getForPrintProducts(String searchKeyword, String order_by, String motelType, String hotelType, String pensionType, String geusthouseType, int low_price, int high_price) {
		return productRepository.getForPrintProducts(searchKeyword, order_by, motelType, hotelType, pensionType, geusthouseType, low_price, high_price);
	}
	
	public Product getForPrintproduct(int id) {
		return productRepository.getForPrintproduct(id);
	}

	public List<Product> getProductsByCompanyId(int companyId) {
		return productRepository.getProductsByCompanyId(companyId);
	}
}
