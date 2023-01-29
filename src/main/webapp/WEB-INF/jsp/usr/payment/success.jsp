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

<script>
	if(sessionStorage.getItem('customerName')){
	 var customerName = sessionStorage.getItem('customerName')
	}
	
</script>


<!-- 결제에 대한 정보를 결제 테이블에 넘겨줘야 함 -->
<section class="my-20">
		<div class="con-3 mx-auto px-3">
<!-- 			결제 테이블로 값을 넘길 수 있을까? -->
			<form>
				<h1> 결제 성공! </h1>
				
				<table>
					<tr>
						<th>결제 키 : </th>
						<td>${paymentKey}</td>
					</tr>				
					<tr>
						<th>주문번호 : </th>
						<td>${orderId}</td>
					</tr>				
					<tr>
						<th>가격 : </th>
						<td>${amount}</td>
					</tr>				
					<tr>
						<th>상품명 : </th>
						<td>${orderName}</td>
					</tr>				
					<tr>
						<th>예약자명 : </th>
						<td><div id="customerName"></div></td>
					</tr>				
				</table>
				
			</form>
			<div>
				<a href="../usr/booking/detail?orderId=${orderId }">예약 확인</a>
			</div>
		</div>
</section>

<script>

	if(sessionStorage.getItem('customerName') != 0){
		// div에 글자를 추가할 때
	 document.getElementById('customerName').append(customerName);
	}
	
</script>




<%@ include file="../common/foot.jspf"%>