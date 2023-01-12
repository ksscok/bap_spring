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
		</div>
		<div>
			<div class="company-list">
				<div class="btn-group">
					<button onclick="location.href='${pageBaseUri}&order_by=lowPrice'" class="btn ${order_by.equals('lowPrice') ? 'orderby-btn-active' : '' } btn-outline">낮은 가격순</button>
					<button onclick="location.href='${pageBaseUri}&order_by=highPrice'" class="btn ${order_by.equals('highPrice') ? 'orderby-btn-active' : '' }  btn-outline" >높은 가격순</button>
					<button onclick="location.href='${pageBaseUri}&order_by=a'" class="btn ${order_by.equals('a') ? 'orderby-btn-active' : '' } btn-outline " >후기 많은순</button>
					<button onclick="location.href='${pageBaseUri}&order_by=b'" class="btn ${order_by.equals('b') ? 'orderby-btn-active' : '' } btn-outline ">평점 높은순</button>
				</div>
				<c:forEach var="company" items="${companies}">
					<div class="company-contents-wrapper flex p-4 border-gray-300">
						<div>
		          <img class="company-image object-cover" src="${rq.getCompanyProfileImgUri(company.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
						</div>
						<div class="company-info-wrapper">
							<div>
								<a href="../product/detail?companyId=${company.id}" class="text-2xl font-bold">${company.name}</a>
							</div>
							<div class="flex mt-1">
								⭐ 
								<div class="font-semibold">4.9&nbsp;</div>
								(2,645) 
							</div> 
							<div class="font-semibold mt-1">${company.address}</div>
							<div class="company-info-price flex items-end justify-end">
								<div class="text-2xl font-bold">${company.extra__minFee}</div>
								<div class="text-xl font-semibold won">원</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>






<%@ include file="../common/foot.jspf" %>