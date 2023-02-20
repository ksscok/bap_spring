<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="숙소 방 목록" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jsp"%>

<!-- detail css -->
<link rel="stylesheet" href="/resource/detail.css" />
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5cfbc84cabfd59358618e0e4eec5096f&libraries=services,clusterer"></script>

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
					<input type="hidden" id="address" name="address" value="${company.address }" />
					<input type="hidden" id="comp_name" name="comp_name" value="${company.name }" />
					<div class="side-bar-d1 mr-6 p-5 border border-gray-300 mb-2">
						<div class="text-base font-semibold mb-4">날짜 변경</div>
						
						<div class="flex items-center">
							<div>
								<div class="">체크인</div>
								<input id="start_date" name="start_date" type="date" class="input input-bordered" value="${start_date }" />
							</div>
							<div class="">
								<div>체크아웃</div>
								<input id="end_date" name="end_date" type="date" class="input input-bordered" value="${end_date }" />
							</div>
						</div>
						<div class="mt-2">
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
							<div class="middle">
							  <div class="multi-range-slider">
							    <!-- 진짜 슬라이더 -->
							    <input name="low_price" type="range" id="input-left" min="10000" max="500000" step="10000"
							    value="${param.low_price == null || param.low_price.equals('') ? '10000' : param.low_price}" 
							    oninput="AddCommaAtLow_price(value)"/>
							    <input name="high_price" type="range" id="input-right" min="10000" max="900000000" step="10000"
							    value="${param.high_price == null || param.high_price.equals('') ? '900000000' : param.high_price}" 
							    oninput="AddCommaAtHigh_price(value)"/>
							
							    <!-- 커스텀 슬라이더 -->
							    <div class="slider">
							      <div class="track"></div>
							      <div class="range1"></div>
							      <div class="thumb left"></div>
							      <div class="thumb right"></div>
							    </div>
							  </div>
							  <div class="flex justify-between mt-2">
							  	<div>10,000원</div>
							  	<div>900,000,000원</div>
							  </div>
							</div>
						</div>
						<div class="flex justify-between mt-5">
							<a href="../product/detail?comp_id=${comp_id }&start_date=${param.start_date}&end_date=${param.end_date}&countOfRoom=${countOfRoom }&countOfAdult=${param.countOfAdult}&countOfChild=${param.countOfChild}" class="btn btn-primary btn-outline w-32">초기화</a>
							<button type="submit" class="btn btn-primary w-32">적용</button>
						</div>
					</div>
				</form>
			</div>
			<!-- 		오른쪽 시작 -->
			<div class="right w-4/6">
				<input type="hidden" name="id" value="${product.comp_id}" />
				<div class="flex justify-between pl-2">
					<div class="company-body">
						<div class="text-3xl">${company.name}</div>
						<div class="text-lg my-2">${company.address}</div>
					</div>
					<div class="flex my-2">
						<div>찜하기</div>
						<c:if test="${rq.isLogined()}">
							<c:choose>
								<c:when test="${wish.id == null }">
		<!-- 					아래 버튼과 버튼 내의 i태그 줄바꿈하면 change_bgc();이거 첫번째 클릭때 오류나서 안 바뀜 -->
									<button class="saving mx-2 mt-1 flex content-start text-red-600" onclick="change_bgc();"><i id="i-heart" class="fa-regular fa-heart"></i></button>
								</c:when>
								<c:otherwise>
		<!-- 					아래 버튼과 버튼 내의 i태그 줄바꿈하면 change_bgc();이거 첫번째 클릭때 오류나서 안 바뀜 -->
									<button class="saving mx-2 mt-1 flex content-start text-red-600" onclick="change_bgc();"><i id="i-heart" class="fa-solid fa-heart"></i></button>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${!rq.isLogined()}">
							<a href="${rq.loginUri}" class="saving mx-2 mt-1 flex content-start text-red-600" onclick="alert('로그인 후 이용해주세요.');"><i id="i-heart" class="fa-regular fa-heart"></i></a>
						</c:if>
					</div>
				</div>
				<div class="company-img img-box flex justify-center">
					<img src="${rq.getCompanyProfileImgUri(company.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
				</div>
				<div class="product-btn text-gray-400 mt-8">
					<a href="#" class="list-btn ml-4">객실 안내/예약</a>
					<a href="#" class="detail-btn ml-4">숙소 정보</a>
					<a href="#" class="review-btn ml-4">리뷰</a>
				</div>
				
				<div class="productList-box">
					<c:forEach var="product" items="${products}" varStatus="status">
						<div id="${status.count }" class="room-body flex items-center rounded-lg p-2 my-4">
							<div class="w-80 h-60 product-img img-box flex justify-center">
								<img class="w-full" src="${rq.getProductProfileImgUri(product.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
							</div>
							<div class="ml-4 w-6/12">
								<div class="text-xl font-bold mb-10">${product.roomType }</div>
								<div class="price flex justify-between w-full border-bt-gray pb-4">
									<div class="text-base font-bold">가격</div>
									<div class="text-lg">(${diff}박) ${product.extra__showTotalFee}</div>
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
														<li><a href="#">${product.countOfAdult }인 기준</a></li>
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
				
				<div class="productDetail-box">
					<div class="baseInform">
						<div class="baseInform-btn flex justify-between items-center">
							<div class="m-4">기본 정보</div>
							<button type="button" class="m-4"><i class="fa-solid fa-chevron-up"></i></button>
						</div>
						<div class="baseInfor-box">
						<div class="container mx-auto px-3">
							<div id="map" style="width:100%;height:200px;"></div>
							<p class="my-2">
								<button type="button" onclick="relayout()">지도 새로고침</button>
							    <button type="button" onclick="panTo()">숙소 위치로</button> 
							</p>
						</div>
						</div>
					</div>
					<div class="amenities-and-services flex justify-between items-center">
						<div class="m-4">편의시설 및 서비스</div>
						<button type="button" class="m-4"><i class="fa-sharp fa-solid fa-chevron-down"></i></button>
					</div>
					<div class="hostInform flex justify-between items-center">
						<div class="m-4">판매자 정보</div>
						<button type="button" class="m-4"><i class="fa-sharp fa-solid fa-chevron-down"></i></button>
					</div>
				</div>
				
				<div class="review-box">
					<div class="review-box-top text-center">
						<c:choose>
							<c:when test="${avgStarCount == 5}">
								<div class="mt-6 text-lg font-extrabold">최고예요</div>
							</c:when>
							<c:when test="${avgStarCount == 4}">
								<div class="mt-6 text-lg font-extrabold">추천해요</div>
							</c:when>
							<c:when test="${avgStarCount == 3}">
								<div class="mt-6 text-lg font-extrabold">만족해요</div>
							</c:when>
							<c:when test="${avgStarCount == 2}">
								<div class="mt-6 text-lg font-extrabold">그저그래요</div>
							</c:when>
							<c:when test="${avgStarCount == 1}">
								<div class="mt-6 text-lg font-extrabold">아쉬워요</div>
							</c:when>
							<c:otherwise>
								<div class="mt-6 text-lg font-extrabold">아직 리뷰가 없습니다</div>
							</c:otherwise>
						</c:choose>
						<span class="text-xl text-yellow-400">${ratingOptions.get(avgStarCount) }</span>
						&nbsp;&nbsp;&nbsp;
						<span>${avg }</span>
						<div class="review-count flex justify-center item-center mt-3">
							<div class="totalReview-count mr-8">
								전체 리뷰
								<span class="font-extrabold">${reviews.size() }</span>
							</div>
							<div class="answerReview-count">
								제휴점 답변
								<span class="font-extrabold">7</span>
							</div>
						</div>
					</div>
					
					<div class="showReview mb-2">
					<c:forEach var="review" items="${reviews}" varStatus="status">
						<div id="review${status.count }" class="showReview-box mt-8">
							<div class="showReview-box-top flex justify-start items-center">
								<c:choose>
									<c:when test="${review.memberId != 0}">
										<div class="member-img img-box flex justify-center w-16 h-14 border rounded-xl border-gray-400">
											<img class="w-full rounded-xl" src="${rq.getMemberProfileImgUri(review.memberId)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
										</div>
									</c:when>
									<c:otherwise>
										<div class="member-img img-box flex justify-center w-16 h-14">
											<img class="w-full" src="https://image.goodchoice.kr/profile/ico/ico_21.png" alt="" />
										</div>
									</c:otherwise>
								</c:choose>
								<div class="flex justify-between" style="width: 505px">
									<div class="showReview-rating-box">
										<span class="ml-3 text-yellow-400">${ratingOptions.get(review.rating) }</span>
										<span class="ml-1">${review.rating }</span>
									</div>
								<c:if test="${review.actorCanChangeData }">
									<div class="dropdown">
										<button class="btn btn-circle btn-ghost btn-sm">
								      		<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
								    	</button>
								    	<ul tabindex="0" class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-20">
									        <li><a onclick="ReviewModify__getForm(${review.id }, ${status.count });">수정</a></li>
									    	<li><a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="../review/doDelete?id=${review.id }&comp_id=${review.comp_id}">삭제</a></li>
									    </ul>
					    			</div>
					    		</c:if>
			    				</div>
							</div>
							<div class="ml-20 text-gray-400">${review.extra__writerName }</div>
							<div class="ml-20 mt-1">${review.getForPrintBody() }</div>
							<div class="ml-1 mt-3 review-img img-box flex justify-center">
								<img class="w-9/12" src="${rq.getReviewProfileImgUri(review.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
							</div>
							<c:choose>
								<c:when test="${review.getForPrintBeforeDays() == 0}">
									<div class="mt-5 text-gray-400 ml-20">오늘</div>
								</c:when>
								<c:when test="${review.getForPrintBeforeDays() == 1}">
									<div class="mt-5 text-gray-400 ml-20">어제</div>
								</c:when>
								<c:otherwise>
									<div class="mt-5 text-gray-400 ml-20">${review.getForPrintBeforeDays() }일 전</div>
								</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
					</div>
					<div class="writeReview-box mx-2">
						<form action="../review/doWrite" onsubmit="submitFormReview(this); return false;">
							<input type="hidden" id="memberId" name="memberId" value="${rq.getLoginedMemberId() }" />
							<input type="hidden" id="comp_id" name="comp_id" value="${comp_id }" />
							<div class="text-sm text-gray-400 mb-2">리뷰를 남겨주세요.</div>
							<div class="text-sm text-gray-400 mb-2">${rq.getLoginedMember().getName() }</div>
							<div class="writeReview-rating-box mb-2">
								<c:forEach begin="1" end="5" var="writeStar" varStatus="status">
									<a id="star${status.count }" style="cursor: pointer;" class="text-yellow-400" onclick="change_star(${status.count });">☆</a>
								</c:forEach>
								<input name="rating" class="writeRating ml-1" type="text" readonly/>
							</div>
							<input name="booking_id" class="booking_id-box mb-3 border-gray" type="text" placeholder="      예약번호를 입력해주세요."/>
							<div class="toast-ui-editor">
								<script type="text/x-template"></script>
							</div>
							<input id="body" type="hidden" name="body" />
							<div class="flex justify-end">
								<button class="text-center btn btn-active btn-secondary mt-3">작성</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script>
// 리뷰 작성시 이미 리뷰를 작성한 예약번호를 적어서 보냈다면 다시 detail로 넘어와서 예약번호가 그대로 남아있는 것을 초기화하는 함수 시작
	$(document).ready(function initialize_booking_id() {
		$(".booking_id-box").val('');
	});
// 리뷰 작성시 이미 리뷰를 작성한 예약번호를 적어서 보냈다면 다시 detail로 넘어와서 예약번호가 그대로 남아있는 것을 초기화하는 함수 끝

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

// 양방향 슬라이더 시작
const inputLeft = document.getElementById("input-left");
const inputRight = document.getElementById("input-right");

const thumbLeft = document.querySelector(".slider > .thumb.left");
const thumbRight = document.querySelector(".slider > .thumb.right");
const range = document.querySelector(".slider > .range1");

const [min1, max1] = [parseInt(inputLeft.min), parseInt(inputLeft.max)];

// 교차되지 않게, 20000을 빼준 건 완전히 겹치기보다는 어느 정도 간격을 남겨두기 위해.
inputLeft.value = Math.min(parseInt(inputLeft.value), parseInt(inputRight.value) - 20000);

// input, thumb 같이 움직이도록
const percent1 = ((inputLeft.value - min1) / (max1 - min1)) * 100;
thumbLeft.style.left = percent1 + "%";
range.style.left = percent1 + "%";

const [min2, max2] = [parseInt(inputRight.min), parseInt(inputRight.max)];

// 교차되지 않게, 20000을 더해준 건 완전히 겹치기보다는 어느 정도 간격을 남겨두기 위해.
inputRight.value = Math.max(parseInt(inputRight.value), parseInt(inputLeft.value) + 20000);

// input, thumb 같이 움직이도록
const percent2 = ((inputRight.value - min2) / (max2 - min2)) * 100;
thumbRight.style.right = 100 - percent2 + "%";
range.style.right = 100 - percent2 + "%";


const setLeftValue = () => {
  const _this = inputLeft;
  const [min, max] = [parseInt(_this.min), parseInt(_this.max)];
  
  // 교차되지 않게, 20000을 빼준 건 완전히 겹치기보다는 어느 정도 간격을 남겨두기 위해.
  _this.value = Math.min(parseInt(_this.value), parseInt(inputRight.value) - 20000);
  
  // input, thumb 같이 움직이도록
  const percent = ((_this.value - min) / (max - min)) * 100;
  thumbLeft.style.left = percent + "%";
  range.style.left = percent + "%";
};

const setRightValue = () => {
  const _this = inputRight;
  const [min, max] = [parseInt(_this.min), parseInt(_this.max)];
  
  // 교차되지 않게, 20000을 더해준 건 완전히 겹치기보다는 어느 정도 간격을 남겨두기 위해.
  _this.value = Math.max(parseInt(_this.value), parseInt(inputLeft.value) + 20000);
  
  // input, thumb 같이 움직이도록
  const percent = ((_this.value - min) / (max - min)) * 100;
  thumbRight.style.right = 100 - percent + "%";
  range.style.right = 100 - percent + "%";
};

inputLeft.addEventListener("input", setLeftValue);
inputRight.addEventListener("input", setRightValue);
//양방향 슬라이더 끝

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
		
		$.get('../wish/doWriteOrDelete', {
			memberId : $memberId,
			comp_id : $comp_id,
			ajaxMode : 'Y'
		}, function(data){
			// hasClass - boolean 타입 리턴. hasClass('class1 class2')처럼 여러개의 클래스의 존재를 확인할 때 한 개라도 일치하지 않으면 false 반환
			if($('#i-heart').hasClass('fa-regular')){
				$('#i-heart').removeClass('fa-regular').addClass('fa-solid');
			}else {
				$('#i-heart').removeClass('fa-solid').addClass('fa-regular');
			}
		}, 'json');
		
	};
// 찜하기 ajax 끝

// product-btn 컨트롤 시작
	$('.list-btn').click(function() {
		$('.list-btn').css('color', 'red')
		$('.list-btn').css('font-weight', '900')
		$('.list-btn').css('border-bottom', '3px solid red')
		$('.detail-btn').css('color', 'rgba(156, 163, 175, var(--tw-text-opacity))')
		$('.detail-btn').css('font-weight', 'normal')
		$('.detail-btn').css('border-bottom', 'none')
		$('.review-btn').css('color', 'rgba(156, 163, 175, var(--tw-text-opacity))')
		$('.review-btn').css('font-weight', 'normal')
		$('.review-btn').css('border-bottom', 'none')
		$('.productList-box').show(); 
		$('.productDetail-box').hide(); 
		$('.review-box').hide(); 
	});

	$('.detail-btn').click(function() {
		$('.list-btn').css('color', 'rgba(156, 163, 175, var(--tw-text-opacity))')
		$('.list-btn').css('font-weight', 'normal')
		$('.list-btn').css('border-bottom', 'none')
		$('.detail-btn').css('color', 'red')
		$('.detail-btn').css('font-weight', '900')
		$('.detail-btn').css('border-bottom', '3px solid red')
		$('.review-btn').css('color', 'rgba(156, 163, 175, var(--tw-text-opacity))')
		$('.review-btn').css('font-weight', 'normal')
		$('.review-btn').css('border-bottom', 'none')
		$('.productList-box').hide(); 
		$('.productDetail-box').show(); 
		$('.review-box').hide(); 
	});

	$('.review-btn').click(function() {
		$('.list-btn').css('color', 'rgba(156, 163, 175, var(--tw-text-opacity))')
		$('.list-btn').css('font-weight', 'normal')
		$('.list-btn').css('border-bottom', 'none')
		$('.detail-btn').css('color', 'rgba(156, 163, 175, var(--tw-text-opacity))')
		$('.detail-btn').css('font-weight', 'normal')
		$('.detail-btn').css('border-bottom', 'none')
		$('.review-btn').css('color', 'red')
		$('.review-btn').css('font-weight', '900')
		$('.review-btn').css('border-bottom', '3px solid red')
		$('.productList-box').hide(); 
		$('.productDetail-box').hide(); 
		$('.review-box').show(); 
	});
// product-btn 컨트롤 끝

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

// 리뷰 수정 함수 시작
	originalForm = null;
	originalId = null;
	
	function ReviewModify__getForm(reviewId, i) {	
		
		if(originalForm != null){
			ReviewModify__cancel(originalId);
		}
		
		$.get('../review/getReviewContent', {
			id : reviewId,
			ajaxMode : 'Y'
		}, function(data){
			let reviewContent = $('#review' + i);
			originalId = i;
			originalForm = reviewContent.html();
			
			let addHtml = `
				<div class="writeReview-box mx-2">
					<form action="../review/doModify" onsubmit="submitFormReviewModify(this); return false;">
						<input type="hidden" id="id2" name="id" value="\${data.data1.id }" />
						<input type="hidden" id="memberId2" name="memberId" value="\${data.data1.memberId }" />
						<input type="hidden" id="comp_id2" name="comp_id" value="\${data.data1.comp_id }" />
						<div class="text-sm text-gray-400 mb-2">리뷰를 남겨주세요.</div>
						<div class="text-sm text-gray-400 mb-2">\${data.data1.extra__writerName }</div>
						<div class="writeReview-rating-box mb-2">
							<c:forEach begin="1" end="5" var="writeStar" varStatus="status">
								<a id="star${status.count }" style="cursor: pointer;" class="text-yellow-400" onclick="change_star(${status.count });">☆</a>
							</c:forEach>
							<input id="rating2" name="rating" class="writeRating ml-1" type="text" readonly/>
						</div>
						<input id="booking_id2" name="booking_id" class="booking_id-box mb-3 border-gray" type="text" placeholder="   예약번호 : \${data.data1.booking_id}"/>
						<div class="toast-ui-editor2">
							<script type="text/x-template">\${data.data1.body }<\/script>
						</div>
						<input id="body2" type="hidden" name="body" />
						<div class="flex justify-end">
							<a onclick="ReviewModify__cancel(\${i})" class="text-center btn btn-active btn-secondary mt-3 mr-3">취소</a>
							<button class="text-center btn btn-active btn-secondary mt-3">수정</button>
						</div>
					</form>
				</div>`;
				
			reviewContent.empty().html("");
			reviewContent.append(addHtml);
			
			// 아마 클래스명이 toast-ui-editor인 태그가 두 개여서 수정 폼에서는 안먹는 것 같아서 뒤에 2 붙여서 하니까 됨 
			$('.toast-ui-editor2').each(function(index, node) {
			    const $node = $(node);
			    const $initialValueEl = $node.find(' > script');
			    const initialValue = $initialValueEl.length == 0 ? '' : $initialValueEl.html().trim();
			    const editor = new toastui.Editor({
			      el: node,
			      previewStyle: 'tab',
			      initialValue: initialValue,
			      height:'200px',
			      plugins: [
			        [toastui.Editor.plugin.chart, ToastEditor__chartOptions],
			        [toastui.Editor.plugin.codeSyntaxHighlight, {highlighter:Prism}],
			        toastui.Editor.plugin.colorSyntax,
			        toastui.Editor.plugin.tableMergedCell,
			        toastui.Editor.plugin.uml,
			        katexPlugin,
			        youtubePlugin,
			        codepenPlugin,
			        replPlugin
			      ],
			      customHTMLSanitizer: html => {
			        return DOMPurify.sanitize(html, { ADD_TAGS: ["iframe"], ADD_ATTR: ['width', 'height', 'allow', 'allowfullscreen', 'frameborder', 'scrolling', 'style', 'title', 'loading', 'allowtransparency'] }) || ''
			      }
			    });
			    $node.data('data-toast-editor', editor);
			  });
			
		}, 'json');
	}

	// toast-ui-editor2를 위한 함수
	function submitFormReviewModify(form){
		  
		  form.memberId2.value = form.memberId2.value.trim();
			  
		  if(form.memberId2.value.length == 0){
		  	alert('로그인 후 이용해주세요.');
		    return;
		  }
		  
		  form.comp_id2.value = form.comp_id2.value.trim();
			  
		  if(form.comp_id2.value.length == 0){
		  	alert('사업장 번호를 입력해주세요.');
		    return;
		  }
		  
		  form.rating2.value = form.rating2.value.trim();
			  
		  if(form.rating2.value.length == 0){
		  	alert('별점을 체크해주세요.');
		    return;
		  }
		  
		  if(form.booking_id2.value.length == 0){
			  	alert('예약 번호를 입력해주세요.');
			  	form.booking_id2.focus();
			    return;
		  }
		  
		  const editor = $(form).find('.toast-ui-editor2').data('data-toast-editor');
		  const markdown2 = editor.getMarkdown().trim();
		  
		  if(markdown2.length < 2){
		    alert('리뷰 내용을 2글자 이상 입력해주세요');
		    editor.focus();
		    return;
		  }
		  
		  form.booking_id.value = form.booking_id.value.trim();
		  
		  document.getElementById('body2').value = markdown2;
		  
		  form.submit();
		}
	
	function ReviewModify__cancel(i) {
		let reviewContent = $('#review' + i);
		reviewContent.html(originalForm);
		
		originalForm = null;
		originalId = null;
	}
// 리뷰 수정 함수 끝


// 별 클릭시 클릭한 별 위치까지 색이 채워진 별로 바뀌고 그에 해당하는 점수가 나오도록 하는 함수 시작
	function change_star(starNo) {
		
		$('.writeRating').val(starNo);
	
		if($('a#star' + starNo).text() == "★"){
			for(let i = starNo + 1; i <= 5; i++){
				$('a#star' + i).text("☆");
			}
		} else {
			for(let i = 1; i <= starNo; i++){
				$('a#star' + i).text("★");
			}
		}
		
	};
// 별 클릭시 클릭한 별 위치까지 색이 채워진 별로 바뀌고 그에 해당하는 점수가 나오도록 하는 함수 끝

// writeReview toastUiEditor 커스터마이징 시작
function ToastEditor__init() {
	  $('.toast-ui-editor').each(function(index, node) {
	    const $node = $(node);
	    const $initialValueEl = $node.find(' > script');
	    const initialValue = $initialValueEl.length == 0 ? '' : $initialValueEl.html().trim();
	    const editor = new toastui.Editor({
	      el: node,
	      previewStyle: 'tab',
	      initialValue: initialValue,
	      height:'200px',
	      plugins: [
	        [toastui.Editor.plugin.chart, ToastEditor__chartOptions],
	        [toastui.Editor.plugin.codeSyntaxHighlight, {highlighter:Prism}],
	        toastui.Editor.plugin.colorSyntax,
	        toastui.Editor.plugin.tableMergedCell,
	        toastui.Editor.plugin.uml,
	        katexPlugin,
	        youtubePlugin,
	        codepenPlugin,
	        replPlugin
	      ],
	      customHTMLSanitizer: html => {
	        return DOMPurify.sanitize(html, { ADD_TAGS: ["iframe"], ADD_ATTR: ['width', 'height', 'allow', 'allowfullscreen', 'frameborder', 'scrolling', 'style', 'title', 'loading', 'allowtransparency'] }) || ''
	      }
	    });
	    $node.data('data-toast-editor', editor);
	  });
	}
	
	function submitFormReview(form){
	  
	  form.memberId.value = form.memberId.value.trim();
		  
	  if(form.memberId.value.length == 0){
	  	alert('로그인 후 이용해주세요.');
	    return;
	  }
	  
	  form.comp_id.value = form.comp_id.value.trim();
		  
	  if(form.comp_id.value.length == 0){
	  	alert('사업장 번호를 입력해주세요.');
	    return;
	  }
	  
	  form.rating.value = form.rating.value.trim();
		  
	  if(form.rating.value.length == 0){
	  	alert('별점을 체크해주세요.');
	    return;
	  }
	  
	  if(form.booking_id.value.length == 0){
		  	alert('예약 번호를 입력해주세요.');
		  	form.booking_id.focus();
		    return;
	  }
	  
	  const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
	  const markdown = editor.getMarkdown().trim();
	  
	  if(markdown.length < 2){
	    alert('리뷰 내용을 2글자 이상 입력해주세요');
	    editor.focus();
	    return;
	  }
	  
	  form.booking_id.value = form.booking_id.value.trim();
	  
	  document.getElementById('body').value = markdown;
	  
	  form.submit();
	}
//writeReview toastUiEditor 커스터마이징 끝
	
	let comp_address = $('#address').val();
	let comp_name = $('#comp_name').val();
	let x = "";
	let y = "";
// 카카오맵 시작
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	function relayout() {    
	    
	    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
	    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
	    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
	    map.relayout();
	}
	
	let mCenter = '';
	
// 	주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	function getData(callback) {
		  // new Promise() 추가
		  return new Promise(function(resolve, reject) {
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(comp_address, async function(result, status) {
		
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
		
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        y = await result[0].x;
			        x = await result[0].y;
			        
			        mCenter = coords;
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			       	});
		
			     // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:200px;text-align:center;padding:6px 0;margin-top:-7px;">' + comp_name + '</div>'
			        });
			        infowindow.open(map, marker);
		
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			    
			    let z = [x, y]
			     resolve(z);
				reject(new Error("Request is failed"));
			});    
		});
	}
	
	function panTo() {
	    // 이동할 위도 경도 위치를 생성합니다 
	    var moveLatLon = mCenter;
	    
	    // 지도 중심을 부드럽게 이동시킵니다
	    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	    map.panTo(moveLatLon);            
	}       
	
	// 큰 지도로 보기 시작
	getData().then(function(z) {
			
			let x1 = z[0];
			let y1 = z[1];
					
			var html = '<button type="button" onclick="window.open(\'https://map.kakao.com/link/map/' + comp_name + ',' + x1 + ',' + y1 + '\')" >큰 지도로 보기</button>';
			$('p').append(html);
	}).catch(function(err) {
		  console.error(err); // Error 출력
	});
	// 큰 지도로 보기 끝
// 카카오맵 끝
</script>

<%@ include file="../common/foot.jspf"%>