package com.KoreaIT.project.BAP.service;

import org.springframework.stereotype.Service;

import com.KoreaIT.project.BAP.repository.MemberRepository;
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
	public void join(String loginId, String loginPw, String name, String email, String cellphoneNo) {
		memberRepository.join(loginId, loginPw, name, email, cellphoneNo);
		
	}
	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}
	public void modify(int id, String loginPw, String email, String cellphoneNo) {
		memberRepository.modify(id, loginPw, email, cellphoneNo);
		
	}
}
