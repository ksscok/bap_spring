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
	
</script>

<section class="my-20">
		<div class="con-3 mx-auto px-3">
			<h1> 결제 성공! </h1>
			<div>결제 키 : ${paymentKey}</div>
			<div>주문번호 : ${orderId}</div>
			<div>가격 : ${amount}</div>
			<div>상품명 : ${orderName}</div>
			<div>예약자명 : ${customerName}</div>
			<div>
				<a href="payment/detail">결제 확인</a>
			</div>
		</div>
</section>






<%@ include file="../common/foot.jspf"%>