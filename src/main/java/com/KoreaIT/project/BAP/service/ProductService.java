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

	public List<Product> getProductsByCompanyId(int comp_id) {
		return productRepository.getProductsByCompanyId(comp_id);
	}
}
