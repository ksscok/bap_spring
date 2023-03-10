<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인페이지" />

<%@ include file="../common/head.jspf" %>
<!-- main css -->
<link rel="stylesheet" href="/resource/main.css" />

<div class="main-page mb-10">

	<section class="main-product-search">
		<h1 class="title">전국 숙박업소 실시간 예약</h1>
		<h1 class="sub-title">호텔부터 펜션까지, 다양한 숙소가 한곳에!</h1>
		<form action="../home/doSearch" class="search-container" onsubmit="mainSearch__submit(this); return false;">
			<div class="search-box" >
				<div class="m-1">
					<h2 class="font-bold mb-2 pl-1">체크인</h2>
					<input id="start_date" name="start_date" type="date" value="${start_date}" class="input input-bordered"/>
				</div>
				<div class="m-1">
					<h2 class="font-bold mb-2 pl-1">체크아웃</h2>
					<input id="end_date" name="end_date"  type="date" value="${end_date}" class="input input-bordered"/>
				</div>
				<div class="m-1">
					<h2 class="font-bold mb-2 pl-1">성인</h2>
					<select class="select select-bordered" name=countOfAdult>
					  <option>0</option>
					  <option>1</option>
					  <option selected>2</option>
					  <option>3</option>
					  <option>4</option>
					  <option>5</option>
					  <option>6</option>
					  <option>7</option>
					  <option>8</option>
					  <option>9</option>
					  <option>10</option>
					</select>
				</div>
				<div class="m-1">
					<h2 class="font-bold mb-2 pl-1">아동</h2>
					<select class="select select-bordered" name="countOfChild">
					  <option selected>0</option>
					  <option>1</option>
					  <option>2</option>
					  <option>3</option>
					  <option>4</option>
					  <option>5</option>
					  <option>6</option>
					  <option>7</option>
					  <option>8</option>
					  <option>9</option>
					  <option>10</option>
					</select>
				</div>
				<div class="m-1">
					<h2  class="font-bold mb-2 pl-1">지역, 숙소명</h2>
			    <input placeholder="예) 서울, oo호텔" type="text" maxlength="30" name="searchKeyword" class="search-keyword-input input input-bordered" />
				</div>
			</div>
			<div>
				<button type="submit" class="search-btn">
					<i class="fa-solid fa-magnifying-glass"></i>
					<span class="mt-2 font-bold">숙소 검색하기</span>
				</button>
			</div>
		</form>
	</section>
	
	<section class="main-product-link">
		<ul>
			<li>
				<div class="img-box">
					<img src="https://media-cdn.tripadvisor.com/media/photo-s/25/04/93/1e/blossom-hotel-houston.jpg" alt="" />
					<a href="../company/hotel">호텔</a>
				</div>
			</li>
			<li>
				<div class="img-box">
					<img src="https://content.skyscnr.com/m/4bb6095d0dbb56fd/original/Motel-Nacht.jpg?resize=1800px:1800px&quality=100" alt="" />
					<a href="../company/motel">모텔</a>
				</div>
			</li>
			<li>
				<div class="img-box">
					<img src="https://cf.bstatic.com/xdata/images/hotel/max1024x768/113104449.jpg?k=2c2c3784d9c114d5079c7144774b2b405e483a4229fe68ceca124d8d36e4ba3b&o=&hp=1" alt="" />
					<a href="../company/pension">펜션</a>
				</div>
			</li>
			<li>
				<div class="img-box">
					<img src="https://cf.bstatic.com/xdata/images/hotel/max1024x768/107183120.jpg?k=5f5c8fff1abdb68a79c8a8e89260427e5699d4e05190f41bb89229cdfc34ab0d&o=&hp=1" alt="" />
					<a href="../company/guesthouse">게스트하우스</a>
				</div>
			</li>
		</ul>
	</section>
	
	<section class="main-event">
		<div class="event">
			<div class="img-box">
				<a href="">
					<img src="https://image.goodchoice.kr/images/cms/home_img/59aeb2aa78cc4d86ce4f93fa27674da0.png" alt="" />
				</a>
			</div>
		</div>
	</section>

</div>

<script>

function mainSearch__submit(form) {
	
	form.start_date.value = form.start_date.value.trim();
	if(form.start_date.value.length == 0) {
		alert('체크인 날짜를 선택해주세요.');
		form.start_date.focus();
		
		return;
	}
	
	form.end_date.value = form.end_date.value.trim();
	if(form.end_date.value.length == 0) {
		alert('체크인 날짜를 선택해주세요.');
		form.end_date.focus();
		
		return;
	}
	
	form.countOfAdult.value = form.countOfAdult.value.trim();
	form.countOfChild.value = form.countOfChild.value.trim();
	if(form.countOfAdult.value == 0 && form.countOfChild.value == 0) {
		alert('인원을 1명 이상 선택해주세요.');
		form.countOfAdult.focus();
		
		return;
	}
	
	form.searchKeyword.value = form.searchKeyword.value.trim();
	if(form.searchKeyword.value.length == 0) {
		alert('검색어를 입력해주세요.');
		form.searchKeyword.focus();
		
		return;
	}
	
	form.submit();

}

</script>


<%@ include file="../common/foot.jspf" %>