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
		<div class="mb-2 flex justify-between items-center">
			<div>
				<span>${bookingsCount } 개</span>
			</div>
			<form>
				<input type="hidden" name="cellphoneNo" value="${cellphoneNo }" />
				
				<select data-value="${searchKeywordTypeCode }" class="select select-bordered" name="searchKeywordTypeCode">
					<option value="booking_id">예약번호</option>
				</select>
				
				<input class="ml-2 w-84 input input-bordered" type="text" name="searchKeyword" placeholder="예약번호를 입력해주세요" maxlength="20" value="${searchKeyword }" />

				<button class="ml-2 btn btn-active btn-ghost">검색</button>
			</form>
		</div>
		<c:choose>
			<c:when test="${bookingsCount == 0 }">
				<div class="text-center mt-10">조건에 일치하는 검색결과가 없습니다</div>
			</c:when>
			<c:otherwise>
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
								<div class="right text-right">
									<div class="mb-2">
										<span>예약 상황 : </span>
										<span class="text-red-400">${booking.extra__status }</span>
									</div>
									<a href="../booking/detail?orderId=${booking.orderId }"  class="text-center btn btn-active btn-secondary">예약 상세보기</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</section>

<script>
	
</script>

<%@ include file="../common/foot.jspf"%>