<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../common/head.jspf" %>
<link rel="stylesheet" href="/resource/login.css" />

<section class="mt-48">
	<div class="con-1 mx-auto px-3">
		<div class="flex justify-center mb-5">
			<a href="../home/main">
				<img class="logo" src="/img/GABOJAGO_logo5.png" alt="gabojaGo" />
			</a>
		</div>
		<form class="flex justify-center" method="POST" action="../member/doLogin" onsubmit="memberLogin__form(this); return false;">
		<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
			<table>
				<colgroup>
					<col width="300"/>
				</colgroup>
				<tbody>
					<tr>
						<td>
							<div class="input-form input input-bordered">
								<div>🤵</div>
								<input id="input-id" name="loginId" type="text" placeholder="아이디"/>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="input-form input input-bordered mt-1">
								<div>🔒</div>
								<input id="input-pw" name="loginPw" type="password" placeholder="비밀번호"/>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<button type="submit" class="btn btn-primary w-full mt-3" >로그인</button>
							<a href="https://kauth.kakao.com/oauth/authorize?client_id=d3e1f4dc1c1bc3f9aea2cc4f0a53c27d&redirect_uri=http://localhost:8082/usr/member/kakaoLogin&response_type=code">
								<img id="kakaoImg" class="mt-1" src ="/img/kakao_login_medium_wide.png">
							</a>
						</td>
					</tr>
					<tr>
						<td class="flex justify-around items-center text-sm font-semibold mt-3">
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
	
// 	아이디&비밀번호 입력 노드 포커스 효과 시작
	let inputId = document.getElementById("input-id");
	
	inputId.onfocus = function(e) {
		let pnode = e.target.parentNode;
		pnode.className = 'input-focus input-form input input-bordered';
	}
	
	inputId.onblur = function(e) {
		let pnode = e.target.parentNode;
		pnode.className = 'input-form input input-bordered';
	}
	
	let inputPw = document.getElementById("input-pw");
	
	inputPw.onfocus = function(e) {
		let pnode = e.target.parentNode;
		pnode.className = 'input-focus input-form input input-bordered mt-1';
	}
	
	inputPw.onblur = function(e) {
		let pnode = e.target.parentNode;
		pnode.className = 'input-form input input-bordered mt-1';
	}
// 	아이디&비밀번호 입력 노드 포커스 효과 끝
</script>

<%@ include file="../common/foot.jspf" %>