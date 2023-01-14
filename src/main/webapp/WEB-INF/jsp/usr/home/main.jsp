<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인페이지" />

<%@ include file="../common/head.jspf" %>

<section class="page-1 con-min-width">
	<div class="con-1 flex h-full justify-center mx-auto px-3">
		<div class="img-box-1 flex h-full items-center justify-center ">
			<div class="absolute search-box flex justify-center items-center" >
				<form action="../company/list" class="flex">
					<input name="Start_date" type="date" />
					<input name="end_date"  type="date" class="mx-2"/>
					<div class="input-group w-full">
				    <input placeholder="지역, 숙소명" type="text" maxlength="20" class="input input-bordered w-full" name="searchKeyword" />
				    <button class="btn btn-square">
				      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" /></svg>
				    </button>
				  </div>
				</form>
			</div>
		</div>
	</div>
</section>

<section class="product-link-box con-min-width">
	<div class="con-1 h-full mx-auto bg-red-200">
		<ul class="bg-green-200 flex h-full">
			<li><a href="../company/list?type=motel" class="h-full flex items-center justify-center bg-blue-200"><span>모텔</span></a></li>
			<li><a href="../company/list?type=hotel" class="h-full flex items-center justify-center bg-red-200"><span>호텔</span></a></li>
			<li><a href="../company/list?type=pension" class="h-full flex items-center justify-center bg-blue-200"><span>펜션</span></a></li>
			<li><a href="../company/list?type=guest_house" class="h-full flex items-center justify-center bg-red-200"><span>게스트하우스</span></a></li>
		</ul>
	</div>
</section>


<%@ include file="../common/foot.jspf" %>