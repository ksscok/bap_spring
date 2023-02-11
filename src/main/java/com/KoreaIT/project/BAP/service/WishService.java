package com.KoreaIT.project.BAP.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.WishRepository;
import com.KoreaIT.project.BAP.vo.Company;
import com.KoreaIT.project.BAP.vo.Wish;

@Service
public class WishService {

	public WishRepository wishRepository;

	
	@Autowired
	public WishService(WishRepository wishRepository) {
		this.wishRepository = wishRepository;
	}

	public Wish getWishByMemberIdAndComp_id(int memberId, int comp_id) {
		return wishRepository.getWishByMemberIdAndComp_id(memberId, comp_id);
	}
	
	public void doWrite(int memberId, int comp_id) {
		wishRepository.doWrite(memberId, comp_id);
	}


	public void doDelete(int memberId, int comp_id) {
		wishRepository.doDelete(memberId, comp_id);
	}

	public int[] getComp_idByMemberId(int memberId) {
		return wishRepository.getComp_idByMemberId(memberId);
	}

	public int getWishesCountByIds(int memberId, String searchKeywordTypeCode, String searchKeyword) {
		return wishRepository.getWishesCountByIds(memberId, searchKeywordTypeCode, searchKeyword);
	}

}
