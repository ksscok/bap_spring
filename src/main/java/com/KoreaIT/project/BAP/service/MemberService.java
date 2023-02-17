package com.KoreaIT.project.BAP.service;

import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.MemberRepository;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Member;

@Service
public class MemberService {
	
	MemberRepository memberRepository;
	MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	
	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}
	
	public void join(String memberType, String loginId, String loginPw, String name, String email, String cellphoneNo) {
		
		loginPw = Ut.sha256(loginPw);
		
		memberRepository.join(memberType, loginId, loginPw, name, email, cellphoneNo);
	}
	
	public void kakaoJoin(long id, String name, String email) {

		memberRepository.kakaoJoin(id, name, email);

	}
	
	public Member getMemberById(long id) {
		return memberRepository.getMemberById(id);
	}
	
	public void modify(long id, String loginPw, String email, String cellphoneNo) {
		
		loginPw = Ut.sha256(loginPw);
		
		memberRepository.modify(id, loginPw, email, cellphoneNo);
	}
	public void doModifyPoint(long id, int pay_point, int savePoint) {
		memberRepository.doModifyPoint(id, pay_point, savePoint);
	}
	public Member getMemberByCellphoneNo(String cellphoneNo) {
		return memberRepository.getMemberByCellphoneNo(cellphoneNo);
	}
}
