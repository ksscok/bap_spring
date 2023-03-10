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
			<div class="text-xl ml-1 mt-4">
				<span class="text-gray-400">현재 총 포인트 : </span>
				<span class="text-green-500 font-bold text-xl">+ ${rq.getLoginedMember().getM_point() }</span>
			</div>
			<form>
			<div class="pointList-top-box flex justify-between items-center mt-2 ml-2">
				<div>
					<span>${pointsCount } 개</span>
				</div>
				<div class="grow-3"></div>
				<div class="point-list-orderby flex items-center mr-2">
					<a href="../point/list?start_date=${start_date}&end_date=${end_date }&searchKeywordTypeCode=plusPoint" class="${searchKeywordTypeCode.equals('plusPoint') ? 'searchKeywordTypeCode-btn-active' : '' }" >
						<span>✔</span>
						<span>+포인트</span>
					</a>
					<a href="../point/list?start_date=${start_date}&end_date=${end_date }&searchKeywordTypeCode=minusPoint" class="${searchKeywordTypeCode.equals('minusPoint') ? 'searchKeywordTypeCode-btn-active' : '' }"  >
						<span>✔</span>
						<span>-포인트</span>
					</a>
					<a href="../point/list?start_date=${start_date}&end_date=${end_date }&searchKeywordTypeCode=allPoint" class="${searchKeywordTypeCode.equals('allPoint') ? 'searchKeywordTypeCode-btn-active' : '' }"  >
						<span>✔</span>
						<span>모든 포인트</span>
					</a>
					<a href="../point/list?start_date=&end_date=&searchKeywordTypeCode=${searchKeywordTypeCode}" class="${start_date.equals('') and end_date.equals('') ? 'searchKeywordTypeCode-btn-active' : '' }" >
						<span>✔</span>
						<span>전체 기간</span>
					</a>
				</div>
				<div class="searchDate-box flex items-center -mr-2">
					<div>
						<input id="start_date" name="start_date" type="month" class="mx-2 input input-bordered" value="${start_date }" />
					</div>
					~
					<div class="">
						<input id="end_date" name="end_date" type="month" class="mx-2 input input-bordered" value="${end_date }" />
					</div>
				</div>
				<button class="text-center btn btn-active btn-secondary ml-2">검색</button>
			</div>
			</form>
			<table class="mt-5">
				<colgroup>
					<col width="70" />
					<col width="80" />
					<col width="130" />
					<col width="200" />
					<col width="100" />
					<col width="100" />
					<col width="100" />
				</colgroup>
				<thead>
					<tr>
						<th>포인트</th>
						<th>적립/사용</th>
						<th>날짜</th>
						<th>숙소명</th>
						<th>실제 결제 금액</th>
						<th>총 결제 금액</th>
						<th>결제 상태</th>
					</tr>
				</thead>

				<tbody>
					<c:choose>
						<c:when test="${pointsCount == 0}">
							<td colspan="7" class="text-center">
								<span>검색 결과에 해당하는 포인트가 존재하지 않습니다.</span>
							</td>
						</c:when>
						<c:otherwise>
							<c:forEach var="point" items="${points}">
						<tr class="hover">
							<c:if test="${point.p_point > 0}">
								<td>
									<span class="text-green-500">+ ${point.p_point}</span>
								</td>
								<c:choose>
									<c:when test="${point.status eq 'cancel' }">
										<td>결제 취소</td>
									</c:when>
									<c:otherwise>
										<td>적립</td>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${point.p_point < 0}">
								<td>
									<span class="text-red-600 text-base">- </span>
									<span class='text-red-600'> ${point.p_point * (-1)}</span>
								</td>
								<c:choose>
									<c:when test="${point.status eq 'cancel' }">
										<td>적립 취소</td>
									</c:when>
									<c:otherwise>
										<td>사용</td>
									</c:otherwise>
								</c:choose>
							</c:if>
							<td>${point.getForPrintRegDate()}</td>
							<td>${point.extra__compName}</td>
							<td>${point.extra__paidRealAmount}</td>
							<td>${point.extra__lastTotalAmount}</td>
							<c:choose>
								<c:when test="${point.status eq 'cancel' }">
									<td>취소</td>
								</c:when>
								<c:otherwise>
									<td>결제</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		
		<div class="page-menu mt-2 flex justify-center">
			<div class="btn-group">
				<c:set var="pageMenuLen" value="5" />
				<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page - pageMenuLen : 1}" />
				<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
				
				<c:set var="pageBaseUri" value="?start_date=${start_date }&end_date=${end_date }&searchKeywordTypeCode=${searchKeywordTypeCode }" />
				<c:if test="${pointsCount != 0 }">
					<c:if test="${page == 1 }">
						<a class="btn btn-sm btn-disabled">«</a>
						<a class="btn btn-sm btn-disabled">&lt;</a>
					</c:if>
					<c:if test="${page > 1 }">
						<a class="btn btn-sm" href="${pageBaseUri }&page=1">«</a>
						<a class="btn btn-sm" href="${pageBaseUri }&page=${page - 1 }">&lt;</a>
					</c:if>
					<c:forEach begin="${startPage }" end="${endPage }" var="i">
						<a class="btn btn-sm ${page == i ? 'btn-active' : ''}" href="${pageBaseUri }&page=${i }">${i }</a>
					</c:forEach>
					<c:if test="${page < pagesCount }">
						<a class="btn btn-sm" href="${pageBaseUri }&page=${page + 1 }">&gt;</a>
						<a class="btn btn-sm" href="${pageBaseUri }&page=${pagesCount }">»</a>
					</c:if>
					<c:if test="${page == pagesCount }">
						<a class="btn btn-sm btn-disabled">&gt;</a>
						<a class="btn btn-sm btn-disabled">»</a>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>
</section>

<script>
	function searchAllDate(){
		$('#start_date').val('');
		$('#end_date').val('');
	};
</script>

<%@ include file="../common/foot.jspf"%>