<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상세보기" />
<%@ include file="../common/head.jspf"%>

<c:set var="pageBaseUri" value="${pageBaseUri}?searchKeyword=${param.searchKeyword}" />
<c:set var="pageBaseUri" value="${pageBaseUri}&low_price=${param.low_price}" />
<c:set var="pageBaseUri" value="${pageBaseUri}&high_price=${param.high_price}" />

<section class="my-20">
	<div class="con-3 flex flex-row mx-auto px-3">
		<div class="left">
			<div class="side-bar-d1 mr-6 p-5 border border-gray-300 rounded-md mb-2">
				<div class="text-base font-semibold mb-4">날짜 변경</div>

				<div>
					<span class="mr-4">체크인</span>
					<input name="Start_date" type="date" class="mx-2 input input-bordered" />
				</div>
				<div class="my-1">
					<span>체크아웃</span>
					<input name="end_date" type="date" class="mx-2 input input-bordered" />
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
			<div class="left side-bar-d2 mr-6 p-5 border border-gray-300 rounded-md">
				<span class="text-base font-semibold">상세조건</span>

				<input type="hidden" name="searchKeyword" value="${param.searchKeyword}" />
				<input type="hidden" name="order_by" value="${param.order_by}" />

				<div class="accommodationType-box flex flex-col mt-5">
					<span class="text-sm font-semibold text-gray-500 mb-2">식사</span>
					<label class="cursor-pointer flex items-center h-8">
						<input type="checkbox" name="withoutMeals" class="checkbox checkbox-sm" />
						<span class="text-sm ml-2">식사 불포함</span>
					</label>
					<label class="cursor-pointer flex items-center h-8">
						<input type="checkbox" name="withBreakfast" class="checkbox checkbox-sm" />
						<span class="text-sm ml-2">조식 포함</span>
					</label>
					<label class="cursor-pointer flex items-center h-8">
						<input type="checkbox" name="withDinner" class="checkbox checkbox-sm" />
						<span class="text-sm ml-2">석식 포함</span>
					</label>
					<label class="cursor-pointer flex items-center h-8">
						<input type="checkbox" name="withBreakfastAndDinner" class="checkbox checkbox-sm" />
						<span class="text-sm ml-2">조식・석식포함</span>
					</label>
				</div>

				<div class="accommodationType-box flex flex-col mt-5">
					<span class="text-sm font-semibold text-gray-500 mb-2">흡연 여부</span>
					<label class="cursor-pointer flex items-center h-8">
						<input type="checkbox" name="motelType" class="checkbox checkbox-sm" value="smoking" />
						<span class="text-sm ml-2">흡연</span>
					</label>
					<label class="cursor-pointer flex items-center h-8">
						<input type="checkbox" name="hotelType" class="checkbox checkbox-sm" value="noSmoking" />
						<span class="text-sm ml-2">금연</span>
					</label>
				</div>

				<div class="pricing-box flex flex-col mt-5">
					<span class="text-sm font-semibold text-gray-500 mb-2">가격</span>
					<ul>
						<li>
							<input type="text" name="low_price" class="input input-bordered input-sm" placeholder="최소" />
						</li>
					</ul>
					<ul class="mt-1">
						<li>
							<input type="text" name="high_price" class="input input-bordered input-sm" placeholder="최대" />
						</li>
					</ul>
				</div>

				<button type="submit" class="btn btn-primary w-full mt-5">적용</button>
			</div>
		</div>

		<!-- 		오른쪽 시작 -->
		<div class="right mt-2 bg-blue-400 w-4/6">
			<input type="hidden" name="id" value="${product.comp_id}" />
			<div class="flex justify-between">
				<div class="company-body">
					<div class="text-3xl">${company.name}</div>
					<div class="text-lg my-2">${company.address}</div>
				</div>
				<div class="flex bg-red-400 my-2">
					<div>찜하기</div>
					<button class="saving mx-2 mt-1 flex content-start" onclick="change_bgc();">
						<i class="fa-regular fa-heart"></i>
					</button>
					<!-- 					 onclick="change_bgc();" -->
					<i class="fa-solid fa-heart"></i>
				</div>
			</div>
			<div>
				<img src="https://image.goodchoice.kr/resize_490x348/affiliate/2016/06/22/5769f8085f3a2.jpg" alt="" />
			</div>
			<c:forEach var="product" items="${products}" varStatus="status">
				<div id="${status.count }" class="room-body flex border-gray rounded-lg p-6 my-4">
					<div>
						<img class="w-80" src="https://image.goodchoice.kr/resize_370x220/affiliate/2016/06/22/5769f8523df2b.jpg" alt="" />
					</div>
					<div class="ml-4 w-6/12">
						<div class="text-xl font-bold mb-10">${product.roomType }</div>
						<div class="price flex justify-between w-full border-bt-gray pb-4">
							<div class="text-base font-bold">가격</div>
							<div class="text-lg">${product.fee}</div>
						</div>
						<button class="dt-modal flex justify-between w-full my-4">
							<div>객실 이용 안내</div>
							<div class="">&gt;</div>
						</button>

						<div class="layer">
							<div class="relative-body">
								<h2 class="md-title text-base font-extrabold flex items-center">객실 이용 안내</h2>
								<div class="md-body border-bt-gray box-border">
									<ul>
										<li>
											<div class="mt-4 mb-2 font-bold text-sm">기본정보</div>
											<ul>
												<li><a href="#">2인 기준 최대 4인 (유료)</a></li>
												<li><a href="#">인원 추가시 비용이 발생되며, 현장에서 결제 바랍니다.</a></li>
												<li><a href="#">객실+욕실/10.00평</a></li>
											</ul>
										</li>
									</ul>
								</div>
								<div class="md-body border-bt-gray box-border">
									<ul>
										<li>
											<div class="mt-4 mb-2 font-bold text-sm">편의시설</div>
											<ul>
												<li><a href="#">TV,침대,식탁,에어컨,냉장고,드라이기,취사도구,전기밥솥,전자레인지,핫플레이트,욕실용품,객실샤워실</a></li>
											</ul>
										</li>
									</ul>
								</div>
								<div class="md-body border-bt-gray box-border">
									<ul>
										<li>
											<div class="mt-4 mb-2 font-bold text-sm">추가 정보</div>
											<ul>
												<li><a href="#">3층위치</a></li>
											</ul>
										</li>
									</ul>
								</div>
								<div class="md-body border-bt-gray box-border">
									<ul>
										<li>
											<div class="mt-4 mb-2 font-bold text-sm">선택 날짜</div>
											<ul>
												<li><a href="#">01월 14일 ~ 01월 15일</a></li>
											</ul>
										</li>
									</ul>
								</div>
							</div>
							<div class="toggle-btn">
								<div></div>
								<div></div>
							</div>
						</div>

						<div class="layer-bg"></div>

						<button type="submit" class="w-full text-center btn btn-active btn-secondary">예약</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>

<script>
	// 	$('.saving').click(change_bgc);

	let changeSaving = false;

	function change_bgc() {
		changeSaving = true;
		// 		$('.saving').children().removeClass(fa-regular);
		// 		alert($('.saving').children().classList);
		alert(changeSaving);
	}

	$('.dt-modal').click(function() {
		// $('.layer').show(); 
		$('.layer').css('display', 'block');
		$('.layer-bg').css('display', 'block');
	});

	$('.close-btn').click(function() {
		// $('.layer').hide(); 
		$('.layer').css('display', 'none');
		$('.layer-bg').css('display', 'none');
	});

	$('.layer-bg').click(function() {
		$('.layer').css('display', 'none');
		$('.layer-bg').css('display', 'none');
	});
</script>





<%@ include file="../common/foot.jspf"%>