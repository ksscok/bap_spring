<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약 상세보기" />
<%@ include file="../common/head.jspf"%>

<!-- 토스페이먼츠 -->
<script src="https://js.tosspayments.com/v1/payment"></script>
<!-- book css -->
<link rel="stylesheet" href="/resource/book.css" />

<section class="">
	<input id="orderId" type="hidden" name="orderId" value="${orderId }" />
	<div class="con-3 flex flex-row mx-auto px-3">
		<div>예약 상세보기</div>
	</div>
</section>

<script>
// 예약자 이름칸에 숫자, 한글, 영어, 스페이스, 백스페이스만 사용 가능하도록 하는 함수 시작(입력키 제한)
	// 추후에 스페이스 횟수 제한 찾아보기
	function chkCharCode(event) {
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

// 휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 시작
	function requiredData(el) {
		$(".required-msg").empty();
		const form = $(el).closest('form').get(0);
		
		if (form.guestCellphoneNum.value.length <= 8) {
			$(".required-msg").html('휴대폰 번호를 확인해주세요.');
			}
		};
// 휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 끝
		
		let $orderId = document.getElementById('orderId').value;
		let $fee = document.getElementById('fee').value;
		let $orderName = document.getElementById('orderName').value;
		let $customerName = document.getElementById('customerName').value;
		
// 	토스페이먼츠 결제창 불러오는 함수 시작
		var clientKey = 'test_ck_Lex6BJGQOVDyvaadL5nrW4w2zNbg'
	    var tossPayments = TossPayments(clientKey)

	    var button = document.getElementById('payment-button') // 결제하기 버튼
	    button.addEventListener('click', function () {
	    	
	    	if(document.getElementById('customerName').value.length == 0){
		    	alert('예약자 이름을 입력해주세요');
		    	return;
	    	}
	    	
	    	if(document.getElementById('customerName').value.length != 0){
		    	alert(document.getElementById('customerName').value);
		    	sessionStorage.setItem('customerName', document.getElementById('customerName').value);
	    	}
	    	
// 	    	var form = document.getElementById('customerName').value;
// 			form.action = "/success";
// 			form.submit();
	    	
	      tossPayments.requestPayment('카드', {
	        amount: $fee,
	        orderId: $orderId,
	        orderName: $orderName,
	        customerName: $customerName,
	        successUrl: 'http://localhost:8082/success',
	        failUrl: 'http://localhost:8082/fail'
	      })
	    })
// 	토스페이먼츠 결제창 불러오는 함수 끝
</script>

<%@ include file="../common/foot.jspf"%>