package com.KoreaIT.project.BAP.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KoreaIT.project.BAP.service.KakaoLoginService;
import com.KoreaIT.project.BAP.service.MemberService;
import com.KoreaIT.project.BAP.util.Ut;
import com.KoreaIT.project.BAP.vo.Member;
import com.KoreaIT.project.BAP.vo.ResultData;
import com.KoreaIT.project.BAP.vo.Rq;

@Controller
public class UsrMemberController {
	
	private MemberService memberService;
	private KakaoLoginService kakaoLoginService;
	private Rq rq;
	
	UsrMemberController(MemberService memberService, KakaoLoginService kakaoLoginService, Rq rq) {
		this.memberService = memberService;
		this.kakaoLoginService = kakaoLoginService;
		this.rq = rq;
	}
	
	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "usr/member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, @RequestParam(defaultValue = "/") String afterLoginUri) {
		
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
		
		if(member.getLoginPw().equals(Ut.sha256(loginPw)) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}
		
		rq.login(member);
		
		String msg = Ut.f("%s님 환영합니다.", member.getName());
		
		return rq.jsReplace(msg, afterLoginUri);
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue= "/") String afterLogoutUri) {
		
		rq.logout();
		
		return rq.jsReplace("로그아웃 되었습니다.", afterLogoutUri);
	}
	
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "usr/member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String memberType, String loginId, String loginPw, String loginPwConfirm, String name, String email, String cellphoneNo) {
		
		if(Ut.empty(memberType)) {
			return rq.jsHistoryBack("회원 구분을 선택해주세요.");
		}
		if(Ut.empty(loginId)) {
			return rq.jsHistoryBack("아이디를 입력해주세요.");
		}
		if(Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호를 입력해주세요.");
		}
		if(Ut.empty(loginPwConfirm)) {
			return rq.jsHistoryBack("비밀번호 확인을 입력해주세요.");
		}
		if(loginPw != loginPwConfirm) {
			return rq.jsHistoryBack("비밀번호를 다시 확인해주세요.");
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
		
		memberService.join(memberType, loginId, loginPw, name, email, cellphoneNo);
		
		return rq.jsReplace("회원가입이 완료되었습니다. 로그인 후 이용해주세요.", "/");
	}
	
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData<String> getLoginIdDup(String loginId) {
		
		if(Ut.empty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요.");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member != null) {
			return ResultData.from("F-2", "이미 사용중인 아이디입니다.", "loginId", loginId);
		}
		
		return ResultData.from("S-1", "사용 가능한 아이디입니다.", "loginId", loginId);
	}

	@RequestMapping("/usr/member/kakaoLogin")
	@ResponseBody
	public String kakaoLogin(@RequestParam("code") String code)
			throws IOException {
		// 토큰 발급 받기
		String access_Token = kakaoLoginService.getAccessToken(code);

		// 사용자 정보 가지고 오기
		Member member = kakaoLoginService.userInfo(access_Token);
		
		System.out.println("accessToken: " + access_Token);
		System.out.println("code:" + code);
		System.out.println("Common Controller:" + member);
		System.out.println("id: " + member.getId());
		System.out.println("nickname: " + member.getName());
		System.out.println("email: " + member.getEmail());
		
		// DB에 회원 정보가 없을 경우 DB에 회원 정보 저장
		Member oldMember = memberService.getMemberById(member.getId());

		if (oldMember == null) {
			memberService.kakaoJoin(member.getId(), member.getName(), member.getEmail());
		}

		// 세션에 담기
		if (member.getEmail() != null) {
			rq.login(member);
		}
		
		String msg = Ut.f("%s님 환영합니다.", member.getName());
		
		return rq.jsReplace(msg, "/");
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
		if(rq.getLoginedMember().getLoginPw().equals(Ut.sha256(loginPw)) == false) {
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
	public String doModify(long id, String loginPw, String loginPwConfirm, String email, String cellphoneNo) {
		
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
