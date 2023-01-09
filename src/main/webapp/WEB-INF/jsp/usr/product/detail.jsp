<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상세보기3" />
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
	
	$('.modal').click(function(){
		  // $('.layer').show(); 
		  $('.layer').css('display','block'); 
		  $('.layer-bg').css('display','block'); 
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
	<div class="con-3 flex flex-row mx-auto px-3 bg-red-200">
		<div class="left side-bar-1 bg-green-200 mr-6">
			<form action="../product/list">
				<input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />
				<input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />
				<input type="hidden" name="order_by" value="${param.order_by}" />
				<input type="text" name="low_price" class="input input-bordered" />
				<input type="text" name="high_price" class="input input-bordered" />
				<button type="submit" class="btn btn-primary">적용</button>
			</form>
		</div>
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
						<button class="modal flex justify-between w-full my-4">
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