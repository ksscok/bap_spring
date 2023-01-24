<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상품 목록" />
<%@ include file="../common/head.jspf" %>
<!-- list css -->
<link rel="stylesheet" href="/resource/list.css" />

<c:set var="pageBaseUri" value="${pageBaseUri}?searchKeyword=${param.searchKeyword}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&low_price=${param.low_price}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&high_price=${param.high_price}"/>
<c:set var="order_by" value="${param.order_by}"/>
<c:set var="accommodationType1" value="${param.accommodationType1}"/>

<div class="back-ground-page">
	<div class="list-page">
		<div class="list-top">
			<div>
				<span>체크인: 2023-01-20</span>
				<span>체크아웃: 2023-01-21</span>
				<span>인원: 2</span>
<!-- 				※키워드 칸을 많이 확보하도록 -->
				<span>키워드: '대전'</span>
			</div>
		</div>
		<div class="list-body">
			<section class="list-side-bar">
				<form action="../company/list">
					<span class="text-base font-semibold">상세조건</span>
				
					<input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />
					<input type="hidden" name="order_by" value="${param.order_by}" />
					
					<div class="accommodationType-box flex flex-col mt-5">
						<span class="text-sm font-semibold text-gray-500 mb-2">숙소 유형</span>
					  <label class="cursor-pointer flex items-center h-8">
					    <input type="checkbox" name="hotelType" class="checkbox checkbox-sm"/>
					    <span class="text-sm ml-2">호텔</span> 
					  </label>
					  <label class="cursor-pointer flex items-center h-8">
					    <input type="checkbox" name="motelType" class="checkbox checkbox-sm" />
					    <span class="text-sm ml-2">모텔</span> 
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
			</section>
			
			<section class="list-company-list">
				<div class="list-company-list-top">
					<div class="company-list-searchCount">
						<span class="font-bold">${companiesCount}</span>개의 검색결과
					</div>
					<div class="flex-grow"></div>
					<div class="company-list-orderby">
						<button onclick="location.href='${pageBaseUri}&order_by=lowPrice'" class="${order_by.equals('lowPrice') ? 'orderby-btn-active' : '' }">
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
					<c:forEach var="company" items="${companies}">
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
									(2,645) 
								</div> 
								<div class="mt-1">${company.address}</div>
								<div class="flex flex-grow"></div>
								<div class="item-info-price">
									<div class="text-2xl font-bold">${company.extra__minFee}</div>
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