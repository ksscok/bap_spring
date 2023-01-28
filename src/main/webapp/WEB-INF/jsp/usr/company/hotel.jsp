<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상품 목록" />
<%@ include file="../common/head.jspf" %>
<!-- list css -->
<link rel="stylesheet" href="/resource/list.css" />

<c:set var="pageBaseUri" value="${pageBaseUri}?low_price=${param.low_price}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&high_price=${param.high_price}"/>
<c:set var="order_by" value="${param.order_by}"/>

<div class="back-ground-page">
	<div class="list-page">
		<div class="list-body">
			<section class="list-side-bar">
				<form action="../company/list">
					<span class="text-lg font-semibold">상세조건</span>
				
					<div class="pricing-box flex flex-col mt-5">
						<div class="mb-2">
								<span class="text-base font-semibold text-gray-500 mb-2">가격</span>
								<span id="low_price">10000</span>
								<span>~</span>
								<span id="high_price"></span>
						</div>
						<ul>
							<li class="flex">
								<input type="range" name="low_price" min="10000" max="250000" step="10000" class="range range-sm"
								oninput="document.getElementById('low_price').innerHTML=this.value;"
								value="${param.low_price == null || param.low_price.equals('') ? '10000' : param.low_price}"/>
							</li>
						</ul>
						<ul class="mt-1">
							<li class="flex">
								<input type="range" name="high_price" min="250000" max="500000" step="10000" class="range range-sm"
								oninput="document.getElementById('high_price').innerHTML=this.value;"
								value="${param.high_price == null || param.high_price.equals('') ? '250000' : param.high_price}"/>
							</li>
						</ul>
					</div>
					
					<div class="flex justify-between mt-5">
						<a href="../company/list?start_date=${param.start_date}&end_date=${param.end_date}&persons=${param.persons}&searchKeyword=${param.searchKeyword}&order_by=${param.order_by}" class="btn btn-primary btn-outline w-28">초기화</a>
						<button type="submit" class="btn btn-primary w-28">적용</button>
					</div>
					
				</form>
			</section>
			
			<section class="list-company-list">
				<div class="list-company-list-top">
					<div class="company-list-searchCount">
						총 <span class="font-bold">${hotelsCount}</span>개의 숙소
					</div>
					<div class="flex-grow"></div>
					<div class="company-list-orderby">
						<button onclick="location.href='${pageBaseUri}&order_by=lowPrice'" 
						class=" ${order_by == null || order_by.equals('') || order_by.equals('lowPrice') ? 'orderby-btn-active' : '' }">
							<div>✔</div>
							<span>낮은 가격순</span>
						</button>
						<button onclick="location.href='${pageBaseUri}&order_by=highPrice'" class="${order_by.equals('highPrice') ? 'orderby-btn-active' : '' }" >
							<div>✔</div>
							<span>높은 가격순</span>
						</button>
						<button onclick="location.href='${pageBaseUri}&order_by=a'" class="${order_by.equals('a') ? 'orderby-btn-active' : '' }" >
							<div>✔</div>
							<span>후기 많은순</span>
						</button>
						<button onclick="location.href='${pageBaseUri}&order_by=b'" class="${order_by.equals('b') ? 'orderby-btn-active' : '' }">
							<div>✔</div>
							<span>평점 높은순</span>
						</button>
					</div>
				</div>
				<div class="company-list">
					<c:forEach var="company" items="${hotels}">
						<div class="company-list-item">
							<div class="img-box">
		      		  <img src="${rq.getCompanyProfileImgUri(company.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
							</div>
							<div class="item-info">
								<div>
									<a href="../product/detail?comp_id=${company.id}" class="text-2xl font-bold">${company.name}</a>
								</div>
								<div class="score">
									<span>★</span>
									<div class="font-semibold">4.9&nbsp;</div>
									<span>(2,645) </span>
								</div> 
								<div class="mt-1">${company.address}</div>
								<div class="flex flex-grow"></div>
								<div class="item-info-price">
									<div class="text-2xl font-bold"><fmt:formatNumber value="${company.extra__minFee}" pattern="#,###"/></div>
									<div class="text-xl font-semibold won">원</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>
		</div>
	</div>
</div>
<%@ include file="../common/foot.jspf" %>