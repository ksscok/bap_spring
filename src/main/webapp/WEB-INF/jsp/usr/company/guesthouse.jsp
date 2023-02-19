<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상품 목록" />
<%@ include file="../common/head.jspf" %>
<link rel="stylesheet" href="/resource/hotel.css" />

<c:set var="pageBaseUri" value="${pageBaseUri}?area=${param.area}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&start_date=${param.start_date}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&end_date=${param.end_date}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&countOfRooms=${param.countOfRooms}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&countOfAdult=${param.countOfAdult}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&countOfChild=${param.countOfChild}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&low_price=${param.low_price}"/>
<c:set var="pageBaseUri" value="${pageBaseUri}&high_price=${param.high_price}"/>
<c:set var="order_by" value="${param.order_by}"/>

<div class="back-ground-page">
	<div class="list-page">

			<section class="side-bar">
				<div class="side-bar-1">
					<span class="text-3xl font-semibold mb-4">게스트하우스</span>
					<div>
						<label>지역</label>
						<input value="${areaInput}" type="text" class="select select-bordered"/>
						<div class="pull-down-box">
							<ul>
								<li>
									<div>
										<span>서울</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=1">강남/역삼/삼성/신사/청담</a></li>
										<li><a href="../company/hotel?area=2">서초/교대</a></li>
										<li><a href="../company/hotel?area=3">잠실/송파/왕십리/강동</a></li>
										<li><a href="../company/hotel?area=4">을지로/시청/명동</a></li>
										<li><a href="../company/hotel?area=5">종로/인사동/동대문/강북</a></li>
										<li><a href="../company/hotel?area=6">서울역/이태원/용산</a></li>
										<li><a href="../company/hotel?area=7">마포/홍대/신촌/서대문</a></li>
										<li><a href="../company/hotel?area=8">영등포/여의도/김포공항</a></li>
										<li><a href="../company/hotel?area=9">구로/금천/관악/동작</a></li>
									</ul>
								</li>
								<li>
									<div>
										<span>부산</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=10">해운대</a></li>
										<li><a href="../company/hotel?area=11">광안리</a></li>
										<li><a href="../company/hotel?area=12">부산역/남포/자갈치</a></li>
										<li><a href="../company/hotel?area=13">서면/동래/연제/남구</a></li>
										<li><a href="../company/hotel?area=14">기장/김해공항</a></li>
										<li><a href="../company/hotel?area=15">영도/송도해수욕장</a></li>
									</ul>
								</li>
								<li>
									<div>
										<span>제주</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=16">제주시/제주국제공항</a></li>
										<li><a href="../company/hotel?area=17">애월/협재/한림</a></li>
										<li><a href="../company/hotel?area=18">조천/함덕/김녕</a></li>
										<li><a href="../company/hotel?area=19">서귀포시</a></li>
										<li><a href="../company/hotel?area=20">중문</a></li>
										<li><a href="../company/hotel?area=21">성산/표선</a></li>
									</ul>
								</li>
								<li>
									<div>
										<span>강원</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=22">강릉/동해/삼척</a></li>
										<li><a href="../company/hotel?area=23">속초/고성</a></li>
										<li><a href="../company/hotel?area=24">양양/홍천/인제/철원</a></li>
										<li><a href="../company/hotel?area=25">평창/정선/횡성</a></li>
										<li><a href="../company/hotel?area=26">춘천/원주/영월/태백</a></li>
									</ul>
								</li>
								<li>
									<div>
										<span>경기</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=27">수원/성남/판교</a></li>
										<li><a href="../company/hotel?area=28">가평/양평/포천</a></li>
										<li><a href="../company/hotel?area=29">용인/평택/여주/이천</a></li>
										<li><a href="../company/hotel?area=30">화성/동탄/안산/부천/안양</a></li>
										<li><a href="../company/hotel?area=31">고양/의정부/파주/김포</a></li>
										<li><a href="../company/hotel?area=32">시흥/군포/광명</a></li>
										<li><a href="../company/hotel?area=33">남양주시/구리/하남</a></li>
									</ul>
								</li>
								<li>
									<div>
										<span>인천</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=34">송도/남동구/옹진군</a></li>
										<li><a href="../company/hotel?area=35">인천국제공항(중구)</a></li>
										<li><a href="../company/hotel?area=36">부평/계양/서구/미추홀구/강화</a></li>
									</ul>
								</li>
								<li>
									<div>
										<span>경상</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=37">경주</a></li>
										<li><a href="../company/hotel?area=38">거제/고성</a></li>
										<li><a href="../company/hotel?area=39">포항/청송/영덕/울진</a></li>
										<li><a href="../company/hotel?area=40">통영/창녕</a></li>
										<li><a href="../company/hotel?area=41">대구/구미/문경/안동</a></li>
										<li><a href="../company/hotel?area=42">창원/양산/김해/울산</a></li>
										<li><a href="../company/hotel?area=43">사천/남해/진주/하동</a></li>
									</ul>
								</li>
								<li>
									<div>
										<span>전라</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=44">여수</a></li>
										<li><a href="../company/hotel?area=45">전주</a></li>
										<li><a href="../company/hotel?area=46">광주</a></li>
										<li><a href="../company/hotel?area=47">순천/광양</a></li>
										<li><a href="../company/hotel?area=48">군산/익산/부안/진안/무주</a></li>
										<li><a href="../company/hotel?area=49">화순/남원/구례</a></li>
										<li><a href="../company/hotel?area=50">목포/나주/완도/해남/영암</a></li>
									</ul>
								</li>
								<li>
									<div>
										<span>충청</span>
										<span>></span>
									</div>
									<ul>
										<li><a href="../company/hotel?area=51">대전</a></li>
										<li><a href="../company/hotel?area=52">천안/아산/예산/당진</a></li>
										<li><a href="../company/hotel?area=53">보령(대천)/태안(안면도)/서산/부여</a></li>
										<li><a href="../company/hotel?area=54">충주/제천/단양</a></li>
										<li><a href="../company/hotel?area=55">청주/세종</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>		
				
				<div class="side-bar-2">
					<form action="../company/hotel">
						<input type="hidden" name="area" value="${param.area}"/>
					
					
						<span class="text-lg font-semibold">기본조건</span>
						
						<div class="select-day">
							<div class="checkin">
								<label>체크인</label>
								<input name="start_date" type="date" value="${start_date}" class="input input-bordered"/>
							</div>
							<div class="checkout">
								<label>체크아웃</label>
								<input name="end_date"  type="date" value="${end_date}" class="input input-bordered"/>
							</div>
						</div>
						
						<div class="rooms-persons">
							<div>
								<label>객실</label>
								<div>
									<select class="select select-bordered" name="countOfRooms">
										<c:forEach begin="0" end="10" var="i">
											<option value="${i}" <c:if test="${i == countOfRooms}">selected</c:if> >${i}</option>
										</c:forEach>
									</select>	
								</div>
							</div>
							<div>
								<label>성인</label>
								<div>
									<select class="select select-bordered" name="countOfAdult">
										<c:forEach begin="0" end="10" var="i">
											<option value="${i}" <c:if test="${i == countOfAdult}">selected</c:if> >${i}</option>
										</c:forEach>
									</select>	
								</div>
							</div>
							<div>
								<label>아동</label>
								<div>
									<select class="select select-bordered" name="countOfChild">
										<c:forEach begin="0" end="10" var="i">
											<option value="${i}" <c:if test="${i == countOfChild}">selected</c:if> >${i}</option>
										</c:forEach>
									</select>	
								</div>
							</div>
						</div>
						
						<div class="flex justify-between">
							<a href="../company/list?start_date=${param.start_date}&end_date=${param.end_date}&persons=${param.persons}&searchKeyword=${param.searchKeyword}&order_by=${param.order_by}" class="btn btn-primary btn-outline w-32">초기화</a>
							<button type="submit" class="btn btn-primary w-32">적용</button>
						</div>
						<span class="text-lg font-semibold">상세조건</span>
						<div class="pricing-box mt-5">
							<div class="mb-3">
								<span class="text-base font-semibold text-gray-500">가격</span>
								<span id="low_price">1만원</span>
								<span>~</span>
								<span id="high_price"></span>
							</div>
							<div class="middle">
							  <div class="multi-range-slider">
							    <!-- 진짜 슬라이더 -->
							    <input name="low_price" type="range" id="input-left" min="10000" max="500000" step="10000"
							    value="${param.low_price == null || param.low_price.equals('') ? '10000' : param.low_price}" 
							    oninput="displayLowPrice(value)"/>
							    <input name="high_price" type="range" id="input-right" min="10000" max="500000" step="10000"
							    value="${param.high_price == null || param.high_price.equals('') ? '500000' : param.high_price}" 
							    oninput="displayHighPrice(value)"/>
							
							    <!-- 커스텀 슬라이더 -->
							    <div class="slider">
							      <div class="track"></div>
							      <div class="range1"></div>
							      <div class="thumb left"></div>
							      <div class="thumb right"></div>
							    </div>
							  </div>
							  <div class="flex justify-between mt-2">
							  	<div>1만원</div>
							  	<div>50만원</div>
							  </div>
							</div>
						</div>
						
					</form>
				</div>
				
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
						<button onclick="location.href='${pageBaseUri}&order_by=review'" class="${order_by.equals('review') ? 'orderby-btn-active' : '' }" >
							<div>✔</div>
							<span>후기 많은순</span>
						</button>
						<button onclick="location.href='${pageBaseUri}&order_by=rating'" class="${order_by.equals('rating') ? 'orderby-btn-active' : '' }">
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
									<div class="font-semibold">${company.getForPrintReviewRating()}&nbsp;</div>
									<span>(${company.extra__reviewCount})</span>
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

<script>

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

//pricing box 시작
let lowValue = document.getElementById('input-left').value;
let displayLowPrice1 = lowValue/10000 + "만원";
document.getElementById('low_price').innerHTML = displayLowPrice1;

function displayLowPrice(value) {
	let displayLowPrice = value/10000 + "만원";
	document.getElementById('low_price').innerHTML = displayLowPrice;
}

let highValue = document.getElementById('input-right').value;
let displayLowPrice2 = highValue/10000 + "만원";
document.getElementById('high_price').innerHTML = displayLowPrice2;

function displayHighPrice(value) {
	let displayLowPrice = value/10000 + "만원";
	document.getElementById('high_price').innerHTML = displayLowPrice;
}
//pricing box 끝
</script>



<%@ include file="../common/foot.jspf" %>