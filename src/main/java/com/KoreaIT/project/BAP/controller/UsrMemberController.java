package com.KoreaIT.project.BAP.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.project.BAP.service.MemberService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Member;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrMemberController {
	
	private MemberService memberService;
	private Rq rq;
	
	UsrMemberController(MemberService memberService, Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "usr/member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		
		if(Ut.empty(loginId)) {
			return rq.jsHistoryBack("아이디를 입력해주세요.");
		}
		
		if(Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요.");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member == null) {
			return rq.jsHistoryBack("존재하지 않는 아이디입니다.");
		}
		
		if(member.getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}
		
		rq.login(member);
		
		String msg = Ut.f("%s님 환영합니다.", member.getName());
		
		return rq.jsReplace(msg, "/");
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {
		
		if(rq.isLogined() == false) {
			return rq.jsHistoryBack("로그인 되어있지 않습니다.");
		}
		
		rq.logout();
		
		return rq.jsReplace("로그아웃 되었습니다.", "/");
	}
	
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String loginPwConfirm, String name, String email, String cellphoneNo) {
		
		if(Ut.empty(loginId)) {
			return rq.jsHistoryBack("아이디를 입력해주세요.");
		}
		if(Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요.");
		}
		if(Ut.empty(loginPwConfirm)) {
			return rq.jsHistoryBack("비밀번호 확인을 입력해주세요.");
		}
		if(Ut.empty(name)) {
			return rq.jsHistoryBack("이름을 입력해주세요.");
		}
		if(Ut.empty(email)) {
			return rq.jsHistoryBack("이메일을 입력해주세요.");
		}
		if(Ut.empty(cellphoneNo)) {
			return rq.jsHistoryBack("핸드폰 번호를 입력해주세요.");
		}
		
		memberService.join(loginId, loginPw, name, email, cellphoneNo);
		
		return rq.jsReplace("회원가입이 완료되었습니다. 로그인 후 이용해주세요.", "/");
	}
	
	@RequestMapping("/usr/member/myPage")
	public String showMyPage() {
		return "usr/member/myPage";
	}
	
	@RequestMapping("/usr/member/checkPassword")
	public String showCheckPassword() {
		return "usr/member/checkPassword";
	}
	
	@RequestMapping("/usr/member/doCheckPassword")
	@ResponseBody
	public String doCheckPassword(String loginPw) {
		
		if(Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요.");
		}
		if(rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}
		
		return rq.jsReplace("", "../member/modify");
	}
	
	@RequestMapping("/usr/member/modify")
	public String showModify() {
		return "usr/member/modify";
	}
	
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(int id, String loginPw, String loginPwConfirm, String email, String cellphoneNo) {
		
		if(Ut.empty(loginPw)) {
			loginPw = null;
		}
		if(Ut.empty(email)) {
			return rq.jsHistoryBack("이메일을 입력해주세요.");
		}
		if(Ut.empty(cellphoneNo)) {
			return rq.jsHistoryBack("핸드폰 번호를 입력해주세요.");
		}
		
		memberService.modify(id, loginPw, email, cellphoneNo);
		
		return rq.jsReplace("회원정보가 수정되었습니다.", "../member/myPage");
	}
}
