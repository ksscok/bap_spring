<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약 상세보기" />
<%@ include file="../common/head.jspf"%>

<!-- bookingDetail css -->
<link rel="stylesheet" href="/resource/bookingDetail.css" />

<section>
	<input id="booking" type="hidden" name="booking" value="${booking }" />
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
				<div class="text-xl"><i class="fa-solid fa-circle-right"></i></div>
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
						<th colspan="2"><div class="text-2xl">예약 정보</div></th>
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
						<th>전화번호</th>
						<td>010-1212-3434</td>
					</tr>
				</tbody>
			</table>
			
			<table class="mt-10">
				<colgroup>
					<col width="300" />
				</colgroup>
				
				<thead>
					<tr>
						<th colspan="2"><div class="text-2xl">결제 정보</div></th>
					</tr>
				</thead>				
				<tbody>
					<tr>
						<th>결제일시</th>
						<td>2023.02.01 목 11:14</td>
					</tr>
					<tr>
						<th>상품가격(1박)</th>
						<td>70,000원</td>
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
						<td>토스페이</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</section>

<script>

</script>

<%@ include file="../common/foot.jspf"%>