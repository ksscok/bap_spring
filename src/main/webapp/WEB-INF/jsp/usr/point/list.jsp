<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="포인트 내역" />
<%@ include file="../common/head.jspf"%>

<!-- pointList css -->
<link rel="stylesheet" href="/resource/pointList.css" />

<section class="my-10">
	<div class="con-3 mx-auto px-3">
		<div class="text-2xl font-bold">포인트 내역</div>
		<div class="table-box-type-2 company-list mt-0 flex flex-col text-sm">
			<div class="text-xl mt-4 ml-1">
			<span class="text-gray-400">현재 총 포인트 : </span>
			<span class="text-green-500 font-bold text-xl">+ ${rq.getLoginedMember().getM_point() }</span>
			</div>
			<table class="mt-5">
				<colgroup>
					<col width="200" />
					<col width="300" />
					<col width="500" />
					<col width="200" />
				</colgroup>
				<thead>
					<tr>
						<th>포인트</th>
						<th>날짜</th>
						<th>숙소명</th>
						<th>결제 금액</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="point" items="${points}">
						<tr class="hover">
							<c:if test="${point.p_point > 0}">
								<td class='text-green-500'>+ ${point.p_point}</td>
							</c:if>
							<c:if test="${point.p_point < 0}">
								<td class='text-red-600'>- ${point.p_point}</td>
							</c:if>
							<td>${point.regDate}</td>
							<td>${point.extra__compName}</td>
							<td>${point.extra__balanceAmount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</section>

<script>
	
</script>

<%@ include file="../common/foot.jspf"%>