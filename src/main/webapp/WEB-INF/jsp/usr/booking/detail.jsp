<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약 상세보기" />
<%@ include file="../common/head.jspf"%>

<!-- bookingDetail css -->
<link rel="stylesheet" href="/resource/bookingDetail.css" />

<section>
	<div class="con-3 mx-auto px-3">
		<div class="my-12 text-3xl font-extrabold">예약 상세보기</div>
		<div class="table-box-type-1">
			<div class="text-2xl font-extrabold mb-6 ml-2">예약 날짜</div>
			<div class="period-inform flex justify-around items-center w-full">
				<div class="chkin-inform text-xl">
					<span class="text-gray-400">체크인</span>
					&nbsp;&nbsp;&nbsp;
					<span>${dateAndDayOfTheWeekOfChkin }</span>
					&nbsp;
					<span>${timeChkin }</span>
				</div>
				<div class="text-xl">
					<i class="fa-solid fa-circle-right"></i>
				</div>
				<div class="chkout-inform text-xl">
					<span class="text-gray-400">체크아웃</span>
					&nbsp;&nbsp;&nbsp;
					<span>${dateAndDayOfTheWeekOfChkout }</span>
					&nbsp;
					<span>${timeChkout }</span>
				</div>
			</div>

			<table class="mt-10">
				<colgroup>
					<col width="300" />
				</colgroup>

				<thead>
					<tr>
						<th colspan="2">
							<div class="text-2xl">예약 정보</div>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>예약번호</th>
						<td>${booking.id }</td>
					</tr>
					<tr>
						<th>예약자 이름</th>
						<td>${booking.customerName }</td>
					</tr>
					<tr>
						<th>예약자 전화번호</th>
						<td>${booking.cellphoneNo }</td>
					</tr>
					<tr>
						<th>예약 상태</th>
						<td>${booking.extra__status }</td>
					</tr>
<!-- 					host의 사정으로 예약을 취소하게 되는 경우 시작 -->
					<c:if test="${booking.getStatus() == 'done'}">
						<c:if test="${rq.getLoginedMember().getMemberType() == 'host' }">
							<tr>
								<th></th>
								<td>
									<a href="../booking/cancel?booking_id=${payment.booking_id }" class="text-center btn btn-active btn-secondary">예약 취소하기</a>
								</td>
							</tr>
						</c:if>
					</c:if>
<!-- 					host의 사정으로 예약을 취소하게 되는 경우 끝 -->
					<c:if test="${booking.getStatus() == 'cancel'}">
						<tr>
							<th></th>
							<td>
								<a href="../booking/cancelDetail?booking_id=${payment.booking_id }" class="text-center btn btn-active btn-secondary">취소 사유 상세보기</a>
							</td>
						</tr>
					</c:if>
					<c:if test="${booking.getStatus() == 'cancel_apply'}">
						<tr>
							<c:choose>
								<c:when test="${rq.getLoginedMember().getMemberType() == 'host' }">
									<th></th>
								</c:when>
								<c:otherwise>
									<th style="text-align: right;">
										<a href="../booking/cancelDelete?booking_id=${payment.booking_id }" class="text-center btn btn-active btn-secondary">예약으로 되돌리기</a>
									</th>
								</c:otherwise>
							</c:choose>
							<td>
								<a href="../booking/cancelDetail?booking_id=${payment.booking_id }" class="text-center btn btn-active btn-secondary">취소 사유 상세보기</a>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<table class="mt-10">
				<colgroup>
					<col width="300" />
				</colgroup>

				<thead>
					<tr>
						<th colspan="2">
							<div class="text-2xl">숙소 정보</div>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>숙소 이름</th>
						<td>${company.name }</td>
					</tr>
					<tr>
						<th>숙소 번호</th>
						<td>${company.cellphoneNo }</td>
					</tr>
					<tr>
						<th>방 타입</th>
						<td>${product.roomType }</td>
					</tr>
				</tbody>
			</table>

			<table class="mt-10">
				<colgroup>
					<col width="300" />
				</colgroup>

				<thead>
					<tr>
						<th colspan="2">
							<div class="text-2xl">결제 정보</div>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>결제일시</th>
						<td>
							<input type="text" id="dateTime" name="dateTime" value="${dateTime }" readonly />
						</td>
					</tr>
					<tr>
						<th>상품가격(${booking.diff }박)</th>
						<td>
							<fmt:formatNumber value="${payment.totalAmount}" pattern="#,###" />
							원
						</td>
					</tr>
					<tr>
						<th>결제 시 포인트 사용</th>
						<td>- 0P</td>
					</tr>
					<tr>
						<th>결제 시 쿠폰 사용</th>
						<td>- 0P</td>
					</tr>
					<tr>
						<th>실 결제 금액</th>
						<td>70,000원</td>
					</tr>
					<tr>
						<th>결제수단</th>
						<td>${easyPay }</td>
					</tr>
				</tbody>
			</table>
			<div class="btns flex justify-end mb-3">
				<button class="text-center btn btn-active btn-secondary my-5 mr-2" type="button" onclick="history.back();">뒤로가기</button>
				<c:if test="${!rq.isLogined()}">
					<c:if test="${booking.getStatus() == 'done'}">
						<a href="../booking/cancelWrite?booking_id=${payment.booking_id }" class="text-center btn btn-active btn-secondary my-5">예약 취소 신청</a>
					</c:if>
				</c:if>
				<c:if test="${rq.isLogined()}">
					<c:if test="${rq.getLoginedMember().getMemberType() == 'guest'}">
						<c:if test="${booking.getStatus() == 'done'}">
							<a href="../booking/cancelWrite?booking_id=${payment.booking_id }" class="text-center btn btn-active btn-secondary my-5">예약 취소 신청</a>
						</c:if>
					</c:if>
					<c:if test="${rq.getLoginedMember().getMemberType() == 'host'}">
						<c:if test="${booking.getStatus() == 'done'}">
							<a href="../booking/cancelWrite?booking_id=${payment.booking_id }" class="text-center btn btn-active btn-secondary my-5">결제 취소</a>
						</c:if>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>
</section>

<script>
	// UTC를 Local로 변경하는 함수 시작
	let date1 = document.getElementById('dateTime').value;
	
	const reqdate = new Date(date1).toISOString().replace('T', ' ').substring(0, 16);
	$(document).ready(function chgUtcLocal(date){
		$('input[name=dateTime]').attr('value', reqdate);
	})
	// UTC를 Local로 변경하는 함수 끝
	
</script>

<%@ include file="../common/foot.jspf"%>