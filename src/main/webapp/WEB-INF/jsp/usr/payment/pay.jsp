<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="결제" />
<%@ include file="../common/head.jspf"%>

<c:set var="paymentKey" value="${paymentKey}" />
<c:set var="orderId" value="${orderId}" />
<c:set var="amount" value="${amount}" />
<c:set var="orderName" value="${orderName}" />
<c:set var="customerName" value="${customerName}" />

<script src="https://js.tosspayments.com/v1/payment"></script>

<section class="my-20">
		<div class="con-3 mx-auto px-3">
			<input id="orderId" type="hidden" name="orderId" value="${orderId }" />
			<input id="amount" type="hidden" name=amount value="${amount }" />
			<input id="start_date" type="hidden" name=start_date value="${start_date }" />
			<input id="end_date" type="hidden" name=end_date value="${end_date }" />
			<input id="countOfAdult" type="hidden" name=countOfAdult value="${countOfAdult }" />
			<input id="countOfChild" type="hidden" name=countOfChild value="${countOfChild }" />
			<input id="orderName" type="hidden" name="orderName" value="${orderName } " />
			<input id="customerName" type="hidden" name="customerName" value="${customerName } " />
			<input id="DateAndDayOfTheWeekOfChkin" type="hidden" name="DateAndDayOfTheWeekOfChkin" value="${DateAndDayOfTheWeekOfChkin } " />
			<input id="DateAndDayOfTheWeekOfChkout" type="hidden" name="DateAndDayOfTheWeekOfChkout" value="${DateAndDayOfTheWeekOfChkout } " />
			<input id="bookingId" type="hidden" name="bookingId" value="${bookingId } " />
			<div class="text-3xl font-extrabold"> 예약 내역 </div>
			<table class="text-xl">
				<colgroup>
					<col width="100"/>
				</colgroup>
					
				<tr>
					<th height="90">예약 번호 : </th>
					<td>
						<div class="-mb-5">${bookingId}</div>
						<div class="bookingId-msg text-sm h-5 text-red-500 -mb-6 mt-6"></div>
					</td>
				</tr>
				<tr>
					<th>상품명 : </th>
					<td>${orderName}</td>
				</tr>			
				<tr>
					<th>가격 : </th>
					<td><fmt:formatNumber value="${amount}" pattern="#,###"/> 원</td>
				</tr>				
					<tr>
					<th>체크인 : </th>
					<td>${DateAndDayOfTheWeekOfChkin}</td>
				</tr>				
				<tr>
					<th>체크아웃 : </th>
					<td>${DateAndDayOfTheWeekOfChkout}</td>
				</tr>				
					<tr>
					<th>성인 : </th>
					<td>${countOfAdult} 명</td>
					</tr>				
				<tr>
					<th>아동 : </th>
					<td>${countOfChild} 명</td>
				</tr>				
				<tr>
					<th>예약자명 : </th>
					<td>${customerName}</td>
				</tr>
				<tr>
					<th colspan="2"><button id="payment-button" class="text-center btn btn-active btn-secondary mt-4">결제하기</button></th>
				</tr>				
			</table>
		</div>
</section>

<script>
	//	토스페이먼츠 결제창 불러오는 함수 시작
	var clientKey = 'test_ck_Lex6BJGQOVDyvaadL5nrW4w2zNbg'
	var tossPayments = TossPayments(clientKey)
	
	var button = document.getElementById('payment-button') // 결제하기 버튼
	
	let $orderId = document.getElementById('orderId').value;
	let $amount = document.getElementById('amount').value;
	let $orderName = document.getElementById('orderName').value;
	let $customerName = document.getElementById('customerName').value;
	
	// 해당 페이지 열리면 바로 실행하도록 하는 함수 - $(document).ready(function () {})
	$(document).ready(function () {
	  tossPayments.requestPayment('카드', {
	    amount: $amount,
	    orderId: $orderId,
	    orderName: $orderName,
	    customerName: $customerName,
	    successUrl: 'http://localhost:8082/success',
	    failUrl: 'http://localhost:8082/fail'
	  })
	})
	
	// 결제창 취소 눌렀을 때 다시 결제할 수 있도록
	   button.addEventListener('click', function () {
	     tossPayments.requestPayment('카드', {
	       amount: $amount,
	       orderId: $orderId,
	       orderName: $orderName,
	       customerName: $customerName,
	       successUrl: 'http://localhost:8082/success',
	       failUrl: 'http://localhost:8082/fail'
	     })
	   })
	   
	   // 새로고침 막는 코드 시작 (예약 내역 페이지에서 새로고침할 때마다 doWrite하는 것을 막기 위해)
	   function NotReload(){
		    if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode == 116) ) {
		        event.keyCode = 0;
		        event.cancelBubble = true;
		        event.returnValue = false;
		    } 
		}
		document.onkeydown = NotReload;
	   // 새로고침 막는 코드 끝
	   
	   $(document).ready(function bookingId_msg() {
			$(".bookingId-msg").empty().html('예약확인시 필요한 정보입니다.');
		})
		
		
</script>





<%@ include file="../common/foot.jspf"%>