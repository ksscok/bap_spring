<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="test1135" />

<%@ include file="../common/head.jspf" %>

<section class="page-1 con-min-width bg-red-200">
	<div class="con-1 flex h-full justify-center mx-auto px-3">
		<div class="img-box-1 flex h-full items-center justify-center ">
			<div class="absolute search-box flex justify-center items-center" >
				<form action="../product/list">
					<input name="Start_date" type="date" />
					<input name="end_date"  type="date" class="mx-2"/>
					<input name="searchKeyword" value="${param.searchKeyword}" type="text" placeholder="지역, 숙소명" maxlength="20" 
					class="w-72 input input-info"/>
					<button type="submit" class="ml-2 btn btn-accent">검색</button>
				</form>
			</div>
		</div>
	</div>
</section>

<section class="product-link-box con-min-width">
	<div class="con-1 h-full mx-auto bg-red-200">
		<ul class="bg-green-200 flex h-full">
			<li><a href="../product/list?type=motel" class="h-full flex items-center justify-center bg-blue-200"><span>모텔</span></a></li>
			<li><a href="../product/list?type=hotel" class="h-full flex items-center justify-center bg-red-200"><span>호텔</span></a></li>
			<li><a href="../product/list?type=pension" class="h-full flex items-center justify-center bg-blue-200"><span>펜션</span></a></li>
			<li><a href="../product/list?type=guest_house" class="h-full flex items-center justify-center bg-red-200"><span>게스트하우스</span></a></li>
		</ul>
	</div>
</section>


<%@ include file="../common/foot.jspf" %>