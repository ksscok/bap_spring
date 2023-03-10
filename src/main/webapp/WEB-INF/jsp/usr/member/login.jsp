<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="๋ฉ์ธ" />
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
								<div>๐คต</div>
								<input id="input-id" name="loginId" type="text" autocomplete="off" placeholder="์์ด๋"/>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="input-form input input-bordered mt-1">
								<div>๐</div>
								<input id="input-pw" name="loginPw" type="password" placeholder="๋น๋ฐ๋ฒํธ"/>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<button type="submit" class="btn btn-primary w-full mt-3" >๋ก๊ทธ์ธ</button>
							<a href="https://kauth.kakao.com/oauth/authorize?client_id=d3e1f4dc1c1bc3f9aea2cc4f0a53c27d&redirect_uri=http://localhost:8082/usr/member/kakaoLogin&response_type=code">
								<img id="kakaoImg" class="mt-1" src ="/img/kakao_login_medium_wide.png">
							</a>
						</td>
					</tr>
					<tr>
						<td class="flex justify-around items-center text-sm font-semibold mt-3">
							<a href="../member/findLoginId">์์ด๋ ์ฐพ๊ธฐ</a>
							<a href="../member/findLoginPw">๋น๋ฐ๋ฒํธ ์ฐพ๊ธฐ</a>
							<a href="../member/join">ํ์๊ฐ์</a>
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
			alert('์์ด๋๋ฅผ ์๋?ฅํด์ฃผ์ธ์');
			form.loginId.focus();
			
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if(form.loginPw.value.length == 0) {
			alert('๋น๋ฐ๋ฒํธ๋ฅผ ์๋?ฅํด์ฃผ์ธ์');
			form.loginPw.focus();
			
			return;
		}
		
		form.submit();
	}
	
// 	์์ด๋&๋น๋ฐ๋ฒํธ ์๋?ฅ ๋ธ๋ ํฌ์ปค์ค ํจ๊ณผ ์์
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
// 	์์ด๋&๋น๋ฐ๋ฒํธ ์๋?ฅ ๋ธ๋ ํฌ์ปค์ค ํจ๊ณผ ๋
</script>

<%@ include file="../common/foot.jspf" %>