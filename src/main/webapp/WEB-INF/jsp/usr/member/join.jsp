<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../common/head.jspf" %>

<section class="mt-14">
	<div class="con-2 mx-auto px-3">
		<div class="text-xl">회원가입</div>
		<form class="table-box-type-2 flex justify-center flex-col mt-5 text-sm" method="POST" action="../member/doJoin" onsubmit="memberJoin__submit(this); return false;">
			<table>
				<colgroup>
					<col width="200"/>
					<col width="700"/>
				</colgroup>
				<tbody>
					<tr>
						<th>회원 구분</th>
						<td>
							<div class="flex">
								<label class="cursor-pointer flex items-center">
							    <input type="radio" name="memberType" value="guest" checked/>
							    <span class="text-sm ml-2">일반회원</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="memberType" value="host"/>
							    <span class="text-sm ml-2">사업자</span> 
							  </label>
							</div>
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<div>
								<input name="loginId" type="text" class="input input-bordered w-64" placeholder="아이디를 입력해주세요." onblur="checkLoginIdDup(this);"/>
								<div class="loginId-msg mt-2 h-5 text-red-500"></div>
							</div>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input name="loginPw" type="password" class="input input-bordered w-64" placeholder="비밀번호를 입력해주세요."/>
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input name="loginPwConfirm" type="password" class="input input-bordered w-64" placeholder="비밀번호를 다시 한번 입력해주세요."/>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input name="name" type="text" class="input input-bordered w-64" placeholder="이름을 입력해주세요."/>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input name="email" type="text" class="input input-bordered w-64" placeholder="이메일을 입력해주세요."/>
						</td>
					</tr>
					<tr>
						<th>핸드폰 번호</th>
						<td>
							<input name="cellphoneNo" type="text" class="input input-bordered w-64" placeholder="핸드폰 번호를 입력해주세요."/>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="mt-5 text-center">
				<button type="submit" class="btn btn-active w-36 h-11">확인</button>
				<button class="btn btn-active btn-ghost w-36 h-11">취소</button>
			</div>
		</form>
	</div>
</section>

<script>

	let validLoginId = '';

	function memberJoin__submit(form) {
		
		form.memberType.value = form.memberType.value.trim();
		if(form.memberType.value.length == 0) {
			alert('회원 구분을 선택해주세요');
			form.memberType.focus();
			
			return;
		}
		
		form.loginId.value = form.loginId.value.trim();
		if(form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			
			return;
		}
		
		if(form.loginId.value != validLoginId) {
			alert(form.loginId.value + '은(는) 사용할 수 없는 아이디입니다.');
			form.loginId.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if(form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			
			return;
		}
		
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if(form.loginPwConfirm.value.length == 0) {
			alert('비밀번호 확인을 입력해주세요');
			form.loginPwConfirm.focus();
			
			return;
		}
		
		if(form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호를 다시 확인해주세요.');
			form.loginPw.focus();
			
			return;
		}
		
		form.name.value = form.name.value.trim();
		if(form.name.value.length == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			
			return;
		}
		
		form.email.value = form.email.value.trim();
		if(form.email.value.length == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			
			return;
		}
		
		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if(form.cellphoneNo.value.length == 0) {
			alert('핸드폰 번호를 입력해주세요');
			form.cellphoneNo.focus();
			
			return;
		}
		
		form.submit();
	}
	

	function checkLoginIdDup(el) {
		$(".loginId-msg").empty();
		const form = $(el).closest('form').get(0);
		
		if (form.loginId.value.length == 0) {
			return;
		}
		
		$.get('getLoginIdDup', {
			loginId : form.loginId.value,
			ajaxMode : 'Y'
		}, function(data){
			console.log(data);
			$(".loginId-msg").html(data.data1 + '은(는) ' + data.msg);
			if (data.success) {
				validLoginId = data.data1;
			}else {
				validLoginId = '';
			}
		}, 'json');
	}
	
	function requiredData(el) {
		$(".required-msg").empty();
		const form = $(el).closest('form').get(0);
		
		if (form.loginPw.value.length == 0) {
			$(".required-msg").html('필수 정보 입니다');
		}
	}
</script>


<%@ include file="../common/foot.jspf" %>