<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="결제 취소" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jsp"%>

<script src="https://js.tosspayments.com/v1/payment"></script>

<section class="my-20">
	<div class="con-3 mx-auto px-3">
		<div class="my-12 text-2xl font-extrabold">결제 취소</div>
		<div class="text-lg font-extrabold mb-4 ml-2">예약 날짜</div>
		<div class="period-inform flex justify-around items-center w-full">
			<div class="chkin-inform text-xl">
				<span class="text-gray-400">체크인</span>
				&nbsp;&nbsp;&nbsp;
				<span>${booking.start_date }</span>
			</div>
			<div class="text-xl">
				<i class="fa-solid fa-circle-right"></i>
			</div>
			<div class="chkout-inform text-xl">
				<span class="text-gray-400">체크아웃</span>
				&nbsp;&nbsp;&nbsp;
				<span>${booking.end_date }</span>
			</div>
		</div>
		<div class="mt-6 ml-2">
			<span class="text-lg font-extrabold mb-4">간략정보</span>
			<div class="my-2">예약번호 : ${booking.id }</div>
			<div>결제 금액 : <fmt:formatNumber value="${payment.totalAmount}" pattern="#,###"/> 원</div>
<!-- 			추후에 포인트, 쿠폰 등으로 인한 금액을 총 결제 금액에서 뺀 금액으로 넣을 예정 -->
			<div class="my-2">취소 가능 금액 : <fmt:formatNumber value="${payment.balanceAmount}" pattern="#,###"/> 원</div>
		</div>
		<div class="mt-6">
			<div class="text-lg font-extrabold mb-2 ml-2">취소 사유</div>
			<div class="ml-2">${cancelReason.title }</div>
			<div class="text-lg font-extrabold my-2 ml-2">취소 상세사유</div>
			<div class="ml-2">${cancelReason.body }</div>
		</div>
		<div class="flex justify-end">
			<c:choose>
				<c:when test="${rq.getLoginedMember().getMemberType() == 'host' }">
					<a href="../booking/authorize?booking_id=${booking_id }" class="text-center btn btn-active btn-secondary mt-4">취소 승인</a>
				</c:when>
				<c:otherwise>
					<a href="#" class="text-center btn btn-active btn-secondary mt-4">수정</a>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="mt-4">
			<div class="text-lg font-bold mb-2">취소 및 환불 규정</div>
			<div>
				<ul>
					<li class="list-active">
						<a href="#" style="pointer-events: none;">비회원으로 예약 시 예약 연기가 불가합니다.</a>
					</li>
					<li class="list-active">
						<a href="#" style="pointer-events: none;">숙소 사정에 의한 취소 시 100% 환불 가능합니다.</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</section>






<%@ include file="../common/foot.jspf"%>