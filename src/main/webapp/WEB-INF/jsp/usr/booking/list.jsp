<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약 목록" />
<%@ include file="../common/head.jspf"%>

<c:set var="bookings" value="${bookings}" />

<!-- bookingList css -->
<link rel="stylesheet" href="/resource/bookingList.css" />

<section class="my-10">
	<div class="con-3 mx-auto px-3">
		<div class="text-2xl font-bold">예약 목록</div>
		<input type="hidden" name="bookings" value="${bookings }"/>
		<c:forEach var="booking" items="${bookings}" >
			<div class="bookingList-box mt-5">
				<!-- 				대표이미지 들어갈 곳 -->
				<div class="img-box"></div>
				<div class="booking-infor">
					<div class="bookingList-top-box flex justify-between">
						<div class="left text-lg">
							<div class="text-xl my-2">${booking.extra__compName }</div>
							<div>예약번호 : ${booking.id }</div>
						</div>
						<div class="chkPeriod-box flex text-center">
							<div class="chkin-inform text-xl">
								<div class="text-gray-400">체크인</div>
								<div>${booking.extra__dateAndDayOfTheWeekOfChkin }</div>
							</div>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<div class="chkout-inform text-xl">
								<div class="text-gray-400">체크아웃</div>
								<div>${booking.extra__dateAndDayOfTheWeekOfChkout }</div>
							</div>
						</div>
					</div>
					<div class="bookingList-bottom-box flex justify-between items-end mt-5">
						<div class="left text-lg">
							<div class="mb-2">${booking.extra__prodRoomType }</div>
							<div>
								<span>결제 금액 : </span>
								<span class="text-red-400"><fmt:formatNumber value="${booking.extra__prodFee}" pattern="#,###"/></span>
								<span>원</span>
							</div>
						</div>
						<a href="../booking/detail?orderId=${booking.orderId }"  class="text-center btn btn-active btn-secondary">예약 상세보기</a>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</section>

<script>
	
</script>

<%@ include file="../common/foot.jspf"%>