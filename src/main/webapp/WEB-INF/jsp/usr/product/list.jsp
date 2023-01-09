<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상품 목록" />
<%@ include file="../common/head.jspf" %>

<c:set var="pageBaseUri" value="${pageBaseUri}?searchKeyword=${param.searchKeyword}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&low_price=${param.low_price}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&high_price=${param.high_price}"/>
<c:set var="order_by" value="${param.order_by}"/>
<c:set var="accommodationType1" value="${param.accommodationType1}"/>

<section class="mt-20">
	<div class="con-3 flex flex-row mx-auto px-3">
		<div class="side-bar-1 mr-6 p-5 border border-gray-300 rounded-md">
			<form action="../product/list">
				<span class="text-base font-semibold">상세조건</span>
			
				<input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />
				<input type="hidden" name="order_by" value="${param.order_by}" />
				
				<div class="accommodationType-box flex flex-col mt-5">
					<span class="text-sm font-semibold text-gray-500 mb-2">숙소 유형</span>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="motelType" class="checkbox checkbox-sm" />
				    <span class="text-sm ml-2">모텔</span> 
				  </label>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="hotelType" class="checkbox checkbox-sm"/>
				    <span class="text-sm ml-2">호텔</span> 
				  </label>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="pensionType" class="checkbox checkbox-sm" />
				    <span class="text-sm ml-2">펜션</span> 
				  </label>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="geusthouseType" class="checkbox checkbox-sm" />
				    <span class="text-sm ml-2">게스트하우스</span> 
				  </label>
		  	</div>
				
				<div class="pricing-box flex flex-col mt-5">
					<span class="text-sm font-semibold text-gray-500 mb-2">가격</span>
					<ul>
						<li>
							<input type="text" name="low_price" class="input input-bordered input-sm" placeholder="최소"/>
						</li>
					</ul>
					<ul class="mt-1">
						<li>
							<input type="text" name="high_price" class="input input-bordered input-sm" placeholder="최대"/>
						</li>
					</ul>
				</div>
				
				<button type="submit" class="btn btn-primary w-full mt-5">적용</button>
			</form>
		</div>
		<div class="table table-fixed">
			<div class="btn-group">
				<button onclick="location.href='${pageBaseUri}&order_by=lowPrice'" class="btn ${order_by.equals('lowPrice') ? 'btn-active' : '' }">낮은 가격순</button>
				<button onclick="location.href='${pageBaseUri}&order_by=highPrice'" class="btn ${order_by.equals('highPrice') ? 'btn-active' : '' }" >높은 가격순</button>
			</div>
			<table class="w-full mt-5">
      	<colgroup>
          <col width="50" />
          <col width="150" />
          <col width="150" />
          <col />
        </colgroup>
        <thead>
        	<tr>	
						<th>번호</th>
						<th>숙소 이름</th>
						<th>주소</th>
						<th>가격</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="product" items="${products}">
						<tr>
							<td>${product.id}</td>
							<td>
								<a href="../product/detail?companyId=${product.companyId}">${product.comName}</a>
							</td>
							<td>${product.comAddr}</td>
							<td>${product.extra__minFee}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</section>






<%@ include file="../common/foot.jspf" %>