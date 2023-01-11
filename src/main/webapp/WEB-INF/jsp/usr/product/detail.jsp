<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상세보기" />
<%@ include file="../common/head.jspf"%>

<c:set var="pageBaseUri" value="${pageBaseUri}?searchKeyword=${param.searchKeyword}" />
<c:set var="pageBaseUri" value="${pageBaseUri}&low_price=${param.low_price}" />
<c:set var="pageBaseUri" value="${pageBaseUri}&high_price=${param.high_price}" />

<script>
// 	$('.saving').click(change_bgc);

	let changeSaving = false;

	function change_bgc() {
		changeSaving = true;
// 		$('.saving').children().removeClass(fa-regular);
		// 		alert($('.saving').children().classList);
		alert(changeSaving);
	}
	
	$('.dt-modal').click(function(){
		  // $('.layer').show(); 
		  alert("안녕");
// 		  $('.layer').css('display','block'); 
// 		  $('.layer-bg').css('display','block'); 
		});

		$('.close-btn').click(function(){
		  // $('.layer').hide(); 
		  $('.layer').css('display','none'); 
		  $('.layer-bg').css('display','none');
		});

		$('.layer-bg').click(function(){
		  $('.layer').css('display','none'); 
		  $('.layer-bg').css('display','none');
		});
</script>

<section class="my-20">
	<div class="con-3 flex flex-row mx-auto px-3">
		<form action="../product/detail">
			<div class="side-bar-1 mr-6 p-5 border border-gray-300 rounded-md mb-2">
				<div class="text-base font-semibold mb-4">날짜 변경</div>
				
				<div>
					<span class="mr-4">체크인</span>
					<input name="Start_date" type="date" class="mx-2 input input-bordered" />
				</div>
				<div class="my-1">
					<span>체크아웃</span>
					<input name="end_date"  type="date" class="mx-2 input input-bordered"/>
				</div>
				<div class="">
					<span>객실</span>
					<span class="mx-14">성인</span>
					<span>아동</span>
				</div>
				<div>
					<select name="countOfRoom" class="select select-bordered">
						<c:forEach begin="1" end="10" var="i">
							<option value="${i }">${i }</option>
						</c:forEach>
					</select>
					<select name="countOfAdult" class="mx-2 select select-bordered">
						<c:forEach begin="1" end="10" var="i">
							<option value="${i }">${i }</option>
						</c:forEach>
					</select>
					<select name="countOfChild" class="select select-bordered">
						<c:forEach begin="1" end="10" var="i">
							<option value="${i }">${i }</option>
						</c:forEach>
					</select>
				</div>
				
				<button type="submit" class="btn btn-primary w-full mt-5">적용</button>
			</div>
<!-- 			폼만 제작 / 변수 수정해야 함 -->
			<div class="side-bar-2 mr-6 p-5 border border-gray-300 rounded-md">
				<span class="text-base font-semibold">상세조건</span>
			
				<input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />
				<input type="hidden" name="order_by" value="${param.order_by}" />
				
				<div class="accommodationType-box flex flex-col mt-5">
					<span class="text-sm font-semibold text-gray-500 mb-2">식사</span>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="motelType" class="checkbox checkbox-sm" />
				    <span class="text-sm ml-2">식사 불포함</span> 
				  </label>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="hotelType" class="checkbox checkbox-sm"/>
				    <span class="text-sm ml-2">조식 포함</span> 
				  </label>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="pensionType" class="checkbox checkbox-sm" />
				    <span class="text-sm ml-2">석식 포함</span> 
				  </label>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="geusthouseType" class="checkbox checkbox-sm" />
				    <span class="text-sm ml-2">조식・석식포함</span> 
				  </label>
		  		</div>
		  		
				<div class="accommodationType-box flex flex-col mt-5">
					<span class="text-sm font-semibold text-gray-500 mb-2">흡연 여부</span>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="motelType" class="checkbox checkbox-sm" />
				    <span class="text-sm ml-2">흡연</span> 
				  </label>
				  <label class="cursor-pointer flex items-center h-8">
				    <input type="checkbox" name="hotelType" class="checkbox checkbox-sm"/>
				    <span class="text-sm ml-2">금연</span> 
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
			</div>
		</form>
		<div class="right mt-2 bg-blue-400 w-4/6">
			<input type="hidden" name="id" value="${product.id}" />
			<div class="flex justify-between">
				<div class="company-body">
					<div class="text-3xl">${product.comName}</div>
					<div class="text-lg my-2">${product.comAddr}</div>
				</div>
				<div class="flex bg-red-400 my-2">
					<div>찜하기</div>
					<button class="saving mx-2 mt-1 flex content-start" onclick="change_bgc();"><i class="fa-regular fa-heart"></i></button>
					<!-- 					 onclick="change_bgc();" -->
					<i class="fa-solid fa-heart"></i>
				</div>
			</div>
			<div><img src="https://image.goodchoice.kr/resize_490x348/affiliate/2016/06/22/5769f8085f3a2.jpg" alt="" /></div>
			<c:forEach var="product" items="${products}" varStatus="status">
				<div id="${status.count }" class="room-body flex border-gray rounded-lg p-6 my-4">
					<div><img class="w-80" src="https://image.goodchoice.kr/resize_370x220/affiliate/2016/06/22/5769f8523df2b.jpg" alt="" /></div>
					<div class="ml-4 w-6/12">
						<div class="text-xl font-bold mb-10">${product.roomType }</div>
						<div class="price flex justify-between w-full border-bt-gray pb-4">
							<div class="text-base font-bold">가격</div>
							<div class="text-lg">${product.fee}</div>
						</div>
						<button class="dt-modal flex justify-between w-full my-4">
							<div class="">객실 이용 안내</div>
							<div class="">&gt;</div>
						</button>
						
						<div class="layer">
						  <h2 class="title">title</h2>
						  <div class="body">Lorem</div>
						  <button class="close-btn">close</button>
						</div>
						
						<div class="layer-bg"></div>
						
						<button class="w-full text-center btn btn-active btn-secondary">예약</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>






<%@ include file="../common/foot.jspf"%>