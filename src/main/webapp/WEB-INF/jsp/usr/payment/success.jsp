<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="결제 성공" />
<%@ include file="../common/head.jspf"%>

<c:set var="paymentKey" value="${paymentKey}" />
<c:set var="orderId" value="${orderId}" />
<c:set var="amount" value="${amount}" />
<%-- <c:set var="orderName" value="${orderName}" /> --%>
<c:set var="customerName" value="${customerName}" />

<script src="https://js.tosspayments.com/v1/payment"></script>

<!-- success css -->
<link rel="stylesheet" href="/resource/success.css" />

<script>
	if(sessionStorage.getItem('customerName')){
	 var customerName = sessionStorage.getItem('customerName');
	}
	
</script>


<!-- 결제에 대한 정보를 결제 테이블에 넘겨줘야 함 -->
<section class="mt-40">
		<div class="con-3 mx-auto px-3">
			<form name="sendForm" action="usr/payment/doWrite">
				<input type="hidden" name="paymentKey" value="${paymentKey}"/>
				<input type="hidden" name="orderId" value="${orderId}"/>
				<input type="hidden" name="amount" value="${amount}"/>
				<input type="hidden" name="orderName" value="${orderName}"/>
				<input type="hidden" name="customerName" value="${customerName}"/>
				<input type="hidden" name="status" value="${status }"/>
				<input type="hidden" name="method" value="${method }"/>
				<input type="hidden" name="easyPay" value="${easyPay }"/>
				<input type="hidden" name="requestedAt" value="${requestedAt }"/>
				<input type="hidden" name="approvedAt" value="${approvedAt }"/>
				<input type="hidden" name="type" value="${type }"/>
				<input type="hidden" name="cancels" value="${cancels }"/>
				<input type="hidden" name="lastTransactionKey" value="${lastTransactionKey }"/>
				<input type="hidden" name="totalAmount" value="${totalAmount }"/>
				<input type="hidden" name="balanceAmount" value="${balanceAmount }"/>
				<input type="hidden" name="suppliedAmount" value="${suppliedAmount }"/>
				<input type="hidden" name="vat" value="${vat }"/>
				<div class="text-center font-extrabold text-4xl">
					<div class="mb-2">
						<span id="regular" class="regular"><i class="fa-regular fa-circle-check"></i></span>
						<span id="solid" class="solid"><i class="fa-solid fa-circle-check"></i></span>
					</div>
					<h1> 결제가 완료 되었습니다. </h1>
				</div>	
			</form>
		</div>
</section>

<script>

	if(sessionStorage.getItem('customerName') != 0){
		// 결제 DB에 넣을 값을 보내주기 위해
	 $('input[name=customerName]').attr('value', customerName);
	}
	
	
	setTimeout(function() {
		// 결제페이지에서 서클-체크가 시간(1초)이 지나서 바뀌도록 하는 함수
		document.getElementById('regular').innerHTML= '<i class="fa-solid fa-circle-check">';
	}, 1000)
	
		// 결제페이지에서 시간(2초)지나면 페이지가 자동으로 넘어가도록 하는 함수
	setTimeout(function() {
		document.sendForm.submit()
	}, 2000);

// 	 $(document).ready(function chgcircle() {
// 		 document.getElementById('regular').style.display = 'none';
// 		 document.getElementById('solid').style.display = 'block';
// 		})
		
	
</script>




<%@ include file="../common/foot.jspf"%>