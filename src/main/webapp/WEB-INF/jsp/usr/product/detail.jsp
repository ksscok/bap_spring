<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="숙소 방 목록" />
<%@ include file="../common/head.jspf"%>

<!-- detail css -->
<link rel="stylesheet" href="/resource/detail.css" />

<div class="back-ground-page">
	<section class="py-20">
		<div class="con-4 flex flex-row mx-auto px-3">
			<div class="left">
				<form>
					<input type="hidden" id="memberId" name="memberId" value="${rq.getLoginedMemberId() }" />
					<input type="hidden" id="comp_id" name="comp_id" value="${comp_id }" />
					<input type="hidden" name="withoutMealsType" value="${withoutMealsType }" />
					<input type="hidden" name="withBreakfastType" value="${withBreakfastType }" />
					<input type="hidden" name="withBreakfastAndDinnerType" value="${withBreakfastAndDinnerType }" />
					<input type="hidden" name="smokingType" value="${smokingType }" />
					<input type="hidden" name="low_price" value="${low_price }" />
					<input type="hidden" name="high_price" value="${high_price }" />
					<div class="side-bar-d1 mr-6 p-5 border border-gray-300 mb-2">
						<div class="text-base font-semibold mb-4">날짜 변경</div>
						
						<div>
							<span class="mr-3">체크인</span>
							<input id="start_date" name="start_date" type="date" class="mx-2 input input-bordered" value="${start_date }" />
						</div>
						<div class="my-1">
							<span>체크아웃</span>
							<input id="end_date" name="end_date" type="date" class="mx-2 input input-bordered" value="${end_date }" />
						</div>
						<div class="">
							<span>객실</span>
							<span class="mx-14">성인</span>
							<span>아동</span>
						</div>
						<div>
	<!-- 					if로도 쓸 수 있다는 걸 같이 적어둔 것/성인, 아동처럼 data-value안 넣어도 됨 -->
							<select id="countOfRoom" data-value="${countOfRoom }" name="countOfRoom" class="select select-bordered" >
								<c:forEach begin="1" end="10" var="i">
									<option value="${i }" <c:if test="${i == countOfRoom}">selected</c:if> >${i }</option>
								</c:forEach>
							</select>
							<select id="countOfAdult" data-value="${countOfAdult }" name="countOfAdult" class="mx-2 select select-bordered">
								<c:forEach begin="0" end="10" var="i">
									<option value="${i }" <c:if test="${i == countOfAdult}">selected</c:if> >${i }</option>
								</c:forEach>
								
							</select>
							<select id="countOfChild" data-value="${countOfChild }" name="countOfChild" class="select select-bordered">
								<c:forEach begin="0" end="10" var="i">
									<option value="${i }" <c:if test="${i == countOfChild}">selected</c:if> >${i }</option>
								</c:forEach>
							</select>
						</div>
						<button type="submit" class="btn btn-primary w-full mt-5" id="btnToApplyDate" >적용</button>
					</div>
				</form>
				
				<form>
					<input type="hidden" name="comp_id" value="${comp_id }" />
					<input type="hidden" name="start_date" value="${start_date }" />
					<input type="hidden" name="end_date" value="${end_date }" />
					<input type="hidden" name="countOfRoom" value="${countOfRoom }" />
					<input type="hidden" name="countOfAdult" value="${countOfAdult }" />
					<input type="hidden" name="countOfChild" value="${countOfChild }" />
					<!-- 			폼만 제작 / 변수 수정해야 함 -->
					<div class="left side-bar-d2 mr-6 p-5 border border-gray-300">
						<span class="text-base font-semibold">상세조건</span>
		
						<input type="hidden" name="order_by" value="${param.order_by}" />
		
						<div class="includeMeals-box flex flex-col mt-5">
							<span class="text-sm font-semibold text-gray-500 mb-2">식사</span>
							<label class="cursor-pointer flex items-center h-8">
								<input type="checkbox" name="withoutMealsType" class="checkbox checkbox-sm" ${param.withoutMealsType.equals('on') ? 'checked' : '' } />
								<span class="text-base ml-2">식사 불포함</span>
							</label>
							<label class="cursor-pointer flex items-center h-8">
								<input type="checkbox" name="withBreakfastType" class="checkbox checkbox-sm" ${param.withBreakfastType.equals('on') ? 'checked' : '' } />
								<span class="text-base ml-2">조식 포함</span>
							</label>
							<label class="cursor-pointer flex items-center h-8">
								<input type="checkbox" name="withDinnerType" class="checkbox checkbox-sm" ${param.withDinnerType.equals('on') ? 'checked' : '' } />
								<span class="text-base ml-2">석식 포함</span>
							</label>
							<label class="cursor-pointer flex items-center h-8">
								<input type="checkbox" name="withBreakfastAndDinnerType" class="checkbox checkbox-sm" ${param.withBreakfastAndDinnerType.equals('on') ? 'checked' : '' } />
								<span class="text-base ml-2">조식・석식포함</span>
							</label>
						</div>
		
						<div class="smokinType-box flex flex-col mt-5">
							<span class="text-sm font-semibold text-gray-500 mb-2">흡연 여부</span>
							<label class="cursor-pointer flex items-center h-8">
								<input type="checkbox" name="smokingType" id="smokingType" class="checkbox checkbox-sm" value="noSmoking" ${param.smokingType.equals('noSmoking') ? 'checked' : '' } />
								<span class="text-base ml-2">금연</span>
							</label>
							<label class="cursor-pointer flex items-center h-8">
								<input type="checkbox" name="smokingType" id="smokingType" class="checkbox checkbox-sm" value="smoking" ${param.smokingType.equals('smoking') ? 'checked' : '' } />
								<span class="text-base ml-2">흡연</span>
							</label>
						</div>
		
						<div class="pricing-box flex flex-col mt-5">
							<div class="mb-2">
									<span class="text-base font-semibold text-gray-500 mb-2 mr-2">가격</span>
									<span id="low_price"><fmt:formatNumber value="${param.low_price}" pattern="#,###"/> 원</span>
									<span>~</span>
									<span id="high_price"><fmt:formatNumber value="${param.high_price}" pattern="#,###"/> 원</span>
							</div>
							<ul>
								<li class="flex">
									<input type="range" name="low_price" min="10000" max="250000" step="10000" class="range range-sm"
									oninput="AddCommaAtLow_price(this.value);"
									value="${param.low_price == null || param.low_price.equals('') ? '10000' : param.low_price}"/>
								</li>
							</ul>
							<ul class="mt-1">
								<li class="flex">
									<input type="range" name="high_price" min="250000" max="500000" step="10000" class="range range-sm"
									oninput="AddCommaAtHigh_price(this.value);"
									value="${param.high_price == null || param.high_price.equals('') ? '250000' : param.high_price}"/>
								</li>
							</ul>
						</div>
		
						<button type="submit" class="btn btn-primary w-full mt-5">적용</button>
					</div>
				</form>
			</div>
			<!-- 		오른쪽 시작 -->
			<div class="right w-4/6">
				<input type="hidden" name="id" value="${product.comp_id}" />
				<div class="flex justify-between">
					<div class="company-body">
						<div class="text-3xl">${company.name}</div>
						<div class="text-lg my-2">${company.address}</div>
					</div>
					<c:if test="${rq.isLogined()}">
						<div class="flex my-2">
							<div>찜하기</div>
								<c:choose>
									<c:when test="${cart.id == null }">
		<!-- 					아래 버튼과 버튼 내의 i태그 줄바꿈하면 change_bgc();이거 첫번째 클릭때 오류나서 안 바뀜 -->
										<button class="saving mx-2 mt-1 flex content-start" onclick="change_bgc();"><i id="i-heart" class="fa-regular fa-heart"></i></button>
									</c:when>
									<c:otherwise>
		<!-- 					아래 버튼과 버튼 내의 i태그 줄바꿈하면 change_bgc();이거 첫번째 클릭때 오류나서 안 바뀜 -->
										<button class="saving mx-2 mt-1 flex content-start" onclick="change_bgc();"><i id="i-heart" class="fa-solid fa-heart"></i></button>
									</c:otherwise>
								</c:choose>
						</div>
					</c:if>
				</div>
				<div>
					<img src="https://image.goodchoice.kr/resize_490x348/affiliate/2016/06/22/5769f8085f3a2.jpg" alt="" />
				</div>
				<div id="productList">
					<c:forEach var="product" items="${products}" varStatus="status">
						<div id="${status.count }" class="room-body flex items-center rounded-lg p-2 my-4">
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
														<li><a href="#">${start_date} ~ ${end_date}</a></li>
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
								<form action="../booking/book" >
									<input type="hidden" name="comp_id" value="${comp_id }" />
									<input type="hidden" name="prod_id" value="${product.id }" />
									<input type="hidden" name="accommodationTypeCode" value="${accommodationTypeCode }" />
									<input type="hidden" name="start_date" value="${start_date }" />
									<input type="hidden" name="end_date" value="${end_date }" />
									<button type="submit" class="w-full text-center btn btn-active btn-secondary">예약</button>
								</form>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
</div>

<script>
// 체크인, 체크아웃 유효성 체크 시작
	$('#btnToApplyDate').click(function(){
	  var dateFrom = document.getElementById('start_date');	//시작일
	  var dateTo = document.getElementById('end_date');	//종료일
	  var today = new Date();				//오늘 날짜

	  dateFrom = new Date(dateFrom.value);
	  var fromYear = dateFrom.getFullYear();
	  var fromMonth = dateFrom.getMonth() + 1;
	  var fromDay = dateFrom.getDate();

	  //날짜 지정을 하지 않았을 때 NaN이 발생하여 0으로 처리
	  if (isNaN(fromYear) || isNaN(fromMonth) || isNaN(fromDay)){
	    fromYear  = 0;
	    fromMonth = 0;
	    fromDay   = 0;
	  }

		dateFrom = fromYear +'/'+ fromMonth +'/'+fromDay; 

	  dateTo = new Date(dateTo.value);
	  var toYear  = dateTo.getFullYear();
	  var toMonth = dateTo.getMonth() + 1;
	  var toDay   = dateTo.getDate();

	  //날짜 지정을 하지 않았을 때 NaN이 발생하여 0으로 처리
	  if (isNaN(toYear) || isNaN(toMonth) || isNaN(toDay)){
	  toYear  = 0;
	  toMonth = 0;
	  toDay   = 0;
	  }

	    dateTo = toYear +'/'+ toMonth +'/'+toDay;

	  //오늘날짜 날짜 형식으로 지정
	  var todayYear  = today.getFullYear(); 	//2020
	  var todayMonth = today.getMonth() + 1;    	//06
	  var todayDay   = today.getDate();  		//11
	  today = todayYear +'/'+ todayMonth +'/'+todayDay;  // 2020/06/11 (형식 지정은 본인 자유)

	  //날짜 조회 시, 시작일이 오늘 날짜보다는 크고, 종료일이 시작일보다는 커야하기 때문에 조건을 걸어줌
	  if(dateFrom >= today && dateTo >= dateFrom){
	  	return true;
	  } else {
	 	 alert("해당 기간의 조회가 불가능합니다." + today);
	 	 return false;
	  }
	});//click() end
// 체크인, 체크아웃 유효성 체크 끝

// 가격 콤마 붙여서 나오는 함수 시작
	function AddCommaAtLow_price(num) {
       let comma_price= num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
       document.getElementById('low_price').innerHTML = comma_price + " 원";
    }
	
	function AddCommaAtHigh_price(num) {
       let comma_price= num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
       document.getElementById('high_price').innerHTML = comma_price + " 원";
    }
	
// 가격 콤마 붙여서 나오는 함수 끝
	
// 찜하기 ajax 시작
	function change_bgc() {
		
		let $memberId = document.getElementById('memberId').value;
		let $comp_id = document.getElementById('comp_id').value;
		
		$.get('../cart/doWriteOrDelete', {
			memberId : $memberId,
			comp_id : $comp_id,
			ajaxMode : 'Y'
		}, function(data){
			// hasClass - boolean 타입 리턴. hasClass('class1 class2')처럼 여러개의 클래스의 존재를 확인할 때 한 개라도 일치하지 않으면 false 반환
			if($('#i-heart').hasClass('fa-regular')){
				alert(data);
				$('#i-heart').removeClass('fa-regular').addClass('fa-solid');
			}else {
				alert(data);
				$('#i-heart').removeClass('fa-solid').addClass('fa-regular');
				
			}
		}, 'json');
		
	};
// 찜하기 ajax 끝

// 객실 이용 안내 modal창 시작
	$('.dt-modal').click(function() {
		// $('.layer').show(); 
		$('.layer').css('display', 'block');
		$('.layer-bg').css('display', 'block');
	});

	$('.toggle-btn').click(function() {
		// $('.layer').hide(); 
		$('.layer').css('display', 'none');
		$('.layer-bg').css('display', 'none');
	});

	$('.layer-bg').click(function() {
		$('.layer').css('display', 'none');
		$('.layer-bg').css('display', 'none');
	});
// 객실 이용 안내 modal창 끝
</script>





<%@ include file="../common/foot.jspf"%>