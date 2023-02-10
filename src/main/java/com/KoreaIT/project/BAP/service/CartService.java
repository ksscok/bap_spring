package com.KoreaIT.project.BAP.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.CartRepository;
import com.KoreaIT.project.BAP.vo.Cart;

@Service
public class CartService {

public CartRepository cartRepository;
	
	@Autowired
	public CartService(CartRepository cartRepository) {
		this.cartRepository = cartRepository;
	}

	public Cart getCartByMemberIdAndComp_id(int memberId, int comp_id) {
		return cartRepository.getCartByMemberIdAndComp_id(memberId, comp_id);
	}
	
	public void doWrite(int memberId, int comp_id) {
		cartRepository.doWrite(memberId, comp_id);
	}


	public void doDelete(int memberId, int comp_id) {
		cartRepository.doDelete(memberId, comp_id);
	}
}
