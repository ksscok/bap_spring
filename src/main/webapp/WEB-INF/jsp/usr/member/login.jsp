<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../common/head.jspf" %>

<section class="mt-60">
	<div class="con-1 mx-auto px-3">
		<form class="flex justify-center" method="POST" action="../member/doLogin" onsubmit="memberLogin__form(this); return false;">
		<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
			<table>
				<colgroup>
					<col width="350"/>
				</colgroup>
				<tbody>
					<tr>
						<td>
							<div>
								<input name="loginId" type="text" class="input input-bordered w-full " placeholder="🤵  아이디"/>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<input name="loginPw" type="password" class="input input-bordered w-full mt-2" placeholder="🔒  비밀번호"/>
						</td>
					</tr>
					<tr>
						<td>
							<button type="submit" class="btn btn-primary w-full mt-4" >로그인</button>
							<a href="https://kauth.kakao.com/oauth/authorize?client_id=d3e1f4dc1c1bc3f9aea2cc4f0a53c27d&redirect_uri=http://localhost:8082/usr/member/kakaoLogin&response_type=code">
								<img src ="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg">
							</a>
						</td>
					</tr>
					<tr>
						<td class="flex justify-around items-center text-sm font-semibold mt-4">
							<a href="../member/findLoginId">아이디 찾기</a>
							<a href="../member/findLoginPw">비밀번호 찾기</a>
							<a href="../member/join">회원가입</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</section>

<script>
	function memberLogin__form(form) {
		form.loginId.value = form.loginId.value.trim();
		if(form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if(form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			
			return;
		}
		
		form.submit();
	}
</script>

<%@ include file="../common/foot.jspf" %>