<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="객실 등록" />
<%@ include file="../common/head.jspf" %>
<link rel="stylesheet" href="/resource/register.css" />

<section class="mt-20">
	<div class="con-3 flex flex-row mx-auto px-3 ">
		<div class="side-bar-myPage mr-6">
			<div class="p-5 pt-0">
				<ul>
					<li><a href="../management/companyDetail?id=${param.id}">사업장 정보</a></li>
				</ul>
				<ul>
					<li><a href="../product/management">예약 확인</a></li>
				</ul>
				<ul>
					<li><a href="../product/management">리뷰 확인</a></li>
				</ul>
				<ul>
					<li><a href="../product/register?id=${param.id}">객실 등록</a></li>
				</ul>
				<ul>
					<li><a href="../product/management">객실 관리</a></li>
				</ul>
			</div>
		</div>
		<div class="table-box-type-2 company-list mt-0 flex flex-col text-sm">
			<div class="text-xl">객실 등록</div>
			<form class="table-box-type-2 flex justify-center flex-col mt-5 text-sm" method="POST" enctype="multipart/form-data" action="../product/doRegister" onsubmit="productRegister__submit(this); return false;">
				<input type="hidden" name="comp_id" value="${param.id}"/>
				<input type="hidden" name="countOfRoom" value="1"/>
				<table>
					<colgroup>
						<col width="150"/>
						<col width="700"/>
					</colgroup>
					<tbody>
						<tr>
							<th>객실 이름</th>
							<td>
								<input name="roomType" placeholder="객실 이름을 입력해주세요." type="text" class="input input-bordered w-72" />
							</td>
						</tr>
						<tr>
							<th>객실 개수</th>
							<td>
								<input name="numberOfRooms" placeholder="사용 가능한 객실 개수를 입력해주세요." type="text" class="input input-bordered w-72" />
							</td>
						</tr>
						<tr>
							<th>객실 요금</th>
							<td>
								<input name="fee" placeholder="객실 요금을 입력해주세요." type="text" class="input input-bordered w-72" />
							</td>
						</tr>
						<tr>
							<th>객실 인원</th>
							<td>
								<div class="flex flex items-center">
									<label class="mr-2">성인</label>
									<select class="select select-bordered" name=countOfAdult>
									  <option></option>
									  <option>0</option>
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
									<label class="ml-5 mr-2 flex items-center">아동</label>
									<select class="select select-bordered" name="countOfChild">
									  <option></option>
									  <option>0</option>
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
							</td>
						</tr>
						<tr>
							<th>식사 정보</th>
							<td>
								<div class="flex">
								<label class="cursor-pointer flex items-center">
							    <input type="radio" name="includeMeals" value="조식"/>
							    <span class="text-sm ml-2">조식</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="includeMeals" value="조식, 석식"/>
							    <span class="text-sm ml-2">조식, 석식</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="includeMeals" value="식사불포함"/>
							    <span class="text-sm ml-2">식사불포함</span> 
							  </label>
							</div>
							</td>
						</tr>
						<tr>
							<th>흡연 가능 여부</th>
							<td>
								<div class="flex">
								<label class="cursor-pointer flex items-center">
							    <input type="radio" name="smokingType" value="smoking"/>
							    <span class="text-sm ml-2">흡연 가능</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="smokingType" value="noSmiking"/>
							    <span class="text-sm ml-2">흡연 불가능</span> 
							  </label>
							</div>
							</td>
						</tr>
						<tr>
							<th>객실 프로필 <br /> 이미지 등록</th>
							<td>
								<input name="file__product__0__extra__profileImg__1" placeholder="객실 프로필 이미지" type="file" />
							</td>
						</tr>
					</tbody>
				</table>
				<div class="mt-5 text-center">
					<button type="submit" class="btn btn-active w-36 h-11">확인</button>
				</div>
			</form>
		</div>
	</div>
</section>

<script>

function productRegister__submit(form) {
	
	form.roomType.value = form.roomType.value.trim();
	if(form.roomType.value.length == 0) {
		alert('객실 이름을 입력해주세요');
		form.roomType.focus();
		
		return;
	}
	form.numberOfRooms.value = form.numberOfRooms.value.trim();
	if(form.numberOfRooms.value.length == 0) {
		alert('객실 개수를 입력해주세요');
		form.numberOfRooms.focus();
		
		return;
	}
	form.fee.value = form.fee.value.trim();
	if(form.fee.value.length == 0) {
		alert('객실 요금을 입력해주세요');
		form.fee.focus();
		
		return;
	}
	form.countOfAdult.value = form.countOfAdult.value.trim();
	if(form.countOfAdult.value.length == 0) {
		alert('성인 인원을 입력해주세요');
		form.countOfAdult.focus();
		
		return;
	}
	form.countOfChild.value = form.countOfChild.value.trim();
	if(form.countOfChild.value.length == 0) {
		alert('아동 인원을 입력해주세요');
		
		return;
	}
	form.includeMeals.value = form.includeMeals.value.trim();
	if(form.includeMeals.value.length == 0) {
		alert('식사 정보를 입력해주세요');
		
		return;
	}
	form.smokingType.value = form.smokingType.value.trim();
	if(form.smokingType.value.length == 0) {
		alert('흡연 가능 여부를 선택해주세요');
		
		return;
	}
	form.file__product__0__extra__profileImg__1.value = form.file__product__0__extra__profileImg__1.value.trim();
	if(form.file__product__0__extra__profileImg__1.value.length == 0) {
		alert('객실 프로필 이미지를 등록력해주세요');
		
		return;
	}
	
	form.submit();
}

</script>

<%@ include file="../common/foot.jspf" %>