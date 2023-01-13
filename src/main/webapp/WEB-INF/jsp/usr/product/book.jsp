<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약" />
<%@ include file="../common/head.jspf"%>

<c:set var="pageBaseUri" value="${pageBaseUri}?searchKeyword=${param.searchKeyword}" />
<c:set var="pageBaseUri" value="${pageBaseUri}&low_price=${param.low_price}" />
<c:set var="pageBaseUri" value="${pageBaseUri}&high_price=${param.high_price}" />

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
</script>

<section class="my-20">
		<div class="con-3 flex justify-between mx-auto px-3">
			<h1> kakaoPay api 이용하기 </h1>
			
			<form method="post" action="/kakaopay">
			    <button id="kakaopayApi">결제버튼</button>
			</form>
		</div>
</section>






<%@ include file="../common/foot.jspf"%>