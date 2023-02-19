<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="객실 관리" />
<%@ include file="../common/head.jspf" %>
<link rel="stylesheet" href="/resource/managementCompanyList.css" />

<section class="mt-20">
	<div class="con-3 flex flex-row mx-auto px-3 ">
		<div class="side-bar-myPage mr-6">
			<div class="p-5 pt-0">
				<ul>
					<li><a href="../management/companyDetail?id=${param.id}">사업장 정보</a></li>
				</ul>
				<ul>
					<li><a href="../product/management">예약 확인</a></li>
				</ul>
				<ul>
					<li><a href="../product/management">리뷰 확인</a></li>
				</ul>
				<ul>
					<li><a href="../product/register?id=${param.id}">객실 등록</a></li>
				</ul>
				<ul>
					<li><a href="../management/productList?id=${param.id}">객실 관리</a></li>
				</ul>
			</div>
		</div>
		<div class="table-box-type-2">
			<div class="text-xl">객실 관리</div>
			<table class="mt-5">
				<colgroup>
					<col width="350"/>
					<col width="100"/>
					<col width="150"/>
					<col width="100"/>
					<col width="100"/>
					<col width="200"/>
					<col width="150"/>
				</colgroup>
				<thead>
					<tr>
						<th>타입</th>
						<th>개수</th>
						<th>요금</th>
						<th>성인</th>
						<th>아동</th>
						<th>식사</th>
						<th>흡연</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="product" items="${products}">
						<tr>	
							<td>${product.roomType}</td>
							<td>${product.numberOfRooms}</td>
							<td>${product.fee}</td>
							<td>${product.countOfAdult}</td>
							<td>${product.countOfChild}</td>
							<td>${product.includeMeals}</td>
							<td>${product.smokingType}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>