<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약" />
<%@ include file="../common/head.jspf"%>

<!-- 토스페이먼츠 -->
<script src="https://js.tosspayments.com/v1/payment"></script>
<!-- book css -->
<link rel="stylesheet" href="/resource/book.css" />

<section class="">
	<form id="writeForm" onsubmit="chkNull(event);" action="doBook" >
		<input id=comp_id type="hidden" name="comp_id" value="${comp_id }" />
		<input id=prod_id type="hidden" name="prod_id" value="${prod_id }" />
		<input id=amount type="hidden" name="amount" value="${product.fee }" />
		<input id="orderId" type="hidden" name="orderId" value="${orderId }" />
		<input id="start_date" type="hidden" name="start_date" value="${start_date }" />
		<input id="end_date" type="hidden" name="end_date" value="${end_date }" />
		<input id="countOfAdult" type="hidden" name="countOfAdult" value="${countOfAdult }" />
		<input id="countOfChild" type="hidden" name="countOfChild" value="${countOfChild }" />
		<input id="DateAndDayOfTheWeekOfChkin" type="hidden" name="DateAndDayOfTheWeekOfChkin" value="${DateAndDayOfTheWeekOfChkin }" />
		<input id="DateAndDayOfTheWeekOfChkout" type="hidden" name="DateAndDayOfTheWeekOfChkout" value="${DateAndDayOfTheWeekOfChkout }" />
		<input id="orderName" type="hidden" name="orderName" value="${company.name }/${product.roomType } " />
		<input id="isWrite" type="hidden" name="isWrite" value="${isWrite } " />
		<div class="con-3 flex flex-row mx-auto px-3">
			<div class="left left_book mr-14">
				<div class="guestInfor">
					<div class="font-bold my-8">예약자 정보</div>
					<div class="info_chkin mb-2 font-semibold">예약자 이름</div>
					<input id="customerName" name="customerName" type="text" onkeypress="chkCharCodeName(event);" class="input input-bordered w-full" placeholder="체크인시 필요한 정보입니다." maxlength="20" />
					<div class="mt-9 info_chkin mb-2 font-semibold">휴대폰 번호</div>
					<div class="info_chkin text-xs mb-8">개인 정보 보호를 위해 안심번호로 숙소에 전송됩니다.</div>
	<!-- 				<form id="cellphoneNumConfirm"> -->
						<div class="cellphoneNo-box mb-16 w-full">
	<!-- 				로그인시 고객의 번호를 가져오는 칸 -->
							<input id="cellphoneNo" name="cellphoneNo" onkeypress="chkCharCodeNum(event);" type="text" oninput="autoHyphen(this)" class="input input-bordered input-md" style="width:440px;" placeholder="체크인시 필요한 정보입니다." maxlength="13" onblur="requiredData(this);"/>
	<!-- 				휴대폰번호 11자리 입력 안하면 활성화 안되게 막아놓음/앞자리가 0으로 시작 안해도 활성화 안되게 막아놓음 -->
	<!-- 						<button type="submit" class="text-center btn btn-active btn-secondary">인증번호 전송</button> -->
							<button class="text-center btn btn-active btn-secondary">인증번호 전송</button>
							<div class="required-msg text-sm mt-2 h-5 text-red-500"></div>
						</div>
	<!-- 				</form> -->
					<c:if test="${rq.getLoginedMemberId() == 0}">
						<div class="guest_login text-center w-full h-28 flex justify-center items-center">
							<a href="${rq.loginUri}" >
								로그인 후 예약하시면
								<br />
								할인 쿠폰과 추가 혜택을 받을 수 있어요
								<br />
								<span class="text-sm">로그인&nbsp;></span>
							</a>
						</div>
					</c:if>
				</div>
			</div>
			
			<div class="right right_side_bar ml-14">
				<div class="accomInfor border-bt-gray">
					<div class="bookingInfor">
						<div class="info_chkin mb-2 mt-16">숙소이름</div>
						<div class="text-xl font-bold mb-7">${company.name }</div>
						<div class="info_chkin mb-2">객실타입/기간</div>
						<div class="text-xl font-bold mb-7">${product.roomType }/${diff }박</div>
						<div class="info_chkin mb-2">체크인</div>
						<div class="text-xl font-bold mb-7">${DateAndDayOfTheWeekOfChkin }  ${company.timeChkin }</div>
						<div class="info_chkin mb-2">체크아웃</div>
						<div class="text-xl font-bold mb-9">${DateAndDayOfTheWeekOfChkout } ${company.timeChkout }</div>
					</div>
				</div>
				<div class="payment">
					<div class="font-extrabold mt-9">총 결제 금액</div>
					<div class="my-4 text-2xl font-extrabold text-red-600">${price }원</div>
					<ul>
						<li>
							<a href="#">
								결제완료 후
								<span class="text-red-600">예약자 이름</span> 
								으로 바로
								<span class="text-red-600">체크인</span> 
								하시면 됩니다
							</a>
						</li>
					</ul>
					<button class="text-center btn btn-active btn-secondary w-full mt-4">결제하기</button>
				</div>
			</div>
		</div>
	</form>
</section>

<script>
// 예약자 이름칸에 숫자, 한글, 영어, 스페이스, 백스페이스만 사용 가능하도록 하는 함수 시작(입력키 제한)
	// 추후에 스페이스 횟수 제한 찾아보기
	function chkCharCodeName(event) {
		  const keyCode = event.keyCode;
		  const isValidKey = (
		    (keyCode >= 48 && keyCode <= 57) || // Numbers
		    (keyCode >= 97 && keyCode <= 122) || // Numbers, Keypad
		    (keyCode >= 65 && keyCode <= 90) || // Alphabet
		    (keyCode === 32) || // Space
		    (keyCode === 8) || // BackSpace
		    (keyCode === 189) // Dash
		  );
		  if (!isValidKey) {
		    event.preventDefault();
		    return false;
		  }
		};
// 예약자 이름칸에 숫자, 한글, 영어, 스페이스, 백스페이스만 사용 가능하도록 하는 함수 끝

// 전화번호칸에 숫자만 사용 가능하도록 하는 함수 시작(입력키 제한)
	function chkCharCodeNum(event) {
		  const keyCode = event.keyCode;
		  const isValidKey = (keyCode >= 48 && keyCode <= 57);
		  if (!isValidKey) {
		    event.preventDefault();
		    return false;
		  }
		};
// 전화번호칸에 숫자만 사용 가능하도록 하는 함수 끝

// 전화번호칸에 숫자를 적어 나아가면 자동으로 하이픈 붙여주는 함수 시작
	const autoHyphen = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
// 전화번호칸에 숫자를 적어 나아가면 자동으로 하이픈 붙여주는 함수 끝

// 휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 시작
	function requiredData(el) {
		$(".required-msg").empty();
		const form = $(el).closest('form').get(0);
		
		if (form.cellphoneNo.value.length <= 8) {
			$(".required-msg").html('휴대폰 번호를 확인해주세요.');
			}
		};
// 휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 끝
		
		let $orderId = document.getElementById('orderId').value;
		let $amount = document.getElementById('amount').value;
		let $orderName = document.getElementById('orderName').value;
		let $customerName = document.getElementById('customerName').value;
		
// write에 보내기전에 입력 내용 체크하고, localStorage에 customerName 저장하기 위한 함수
	function chkNull(event){
		
		if(document.getElementById('customerName').value.trim().length == 0){
		    alert('예약자 이름을 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
		if(document.getElementById('cellphoneNo').value.trim().length == 0){
		    alert('전화번호를 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
		if(document.getElementById('cellphoneNo').value.trim().length <= 10 && document.getElementById('cellphoneNo').value.trim().length != 0){
		    alert('전화번호를 정확히 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
		// 결제성공창에서 customerName을 확인시켜주기 위한 작업
	    if(document.getElementById('customerName').value.trim().length != 0){
		    sessionStorage.setItem('customerName', document.getElementById('customerName').value);
	    }
	}
	
</script>

<%@ include file="../common/foot.jspf"%>