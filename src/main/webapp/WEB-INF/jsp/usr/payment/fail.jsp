<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="결제 실패" />
<%@ include file="../common/head.jspf"%>

<script src="https://js.tosspayments.com/v1/payment"></script>

<section class="my-20">
		<div class="con-3 flex justify-between mx-auto px-3">
			<h1>결제 실패</h1>
		    <p>{{message}}</p>
		    <span>에러코드: {{code}}</span>
		</div>
</section>






<%@ include file="../common/foot.jspf"%>