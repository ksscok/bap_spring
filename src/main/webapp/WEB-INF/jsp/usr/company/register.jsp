<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="사업장 등록" />
<%@ include file="../common/head.jspf" %>
<link rel="stylesheet" href="/resource/register.css" />

<section class="mt-20">
	<div class="con-3 flex flex-row mx-auto px-3 ">
		<div class="side-bar-myPage mr-6">
			<div class="p-5 pt-0">
				<ul>
					<li><a href="../member/myPage">개인정보수정</a></li>
				</ul>
				<ul>
					<li><a href="../company/register">사업장 등록</a></li>
				</ul>
				<ul>
					<li><a href="../management/companyList">사업장 관리</a></li>
				</ul>
			</div>
		</div>
		<div class="table-box-type-2 company-list mt-0 flex flex-col text-sm">
			<div class="text-xl">사업장 등록</div>
			<form class="table-box-type-2 flex justify-center flex-col mt-5 text-sm" method="POST" enctype="multipart/form-data" action="../company/doRegister" onsubmit="companyRegister__submit(this); return false;">
				<input type="hidden" name="host_id" value="${rq.loginedMember.id}"/>
				<input id="area" type="hidden" name="area"/>
				<table>
					<colgroup>
						<col width="200"/>
						<col width="700"/>
					</colgroup>
					<tbody>
						<tr>
							<th>상호</th>
							<td>
								<input name="name" placeholder="상호를 입력해주세요." type="text" class="input input-bordered w-72" />
							</td>
						</tr>
						<tr>
							<th>사업장 전화번호</th>
							<td>
								<input name="cellphoneNo" onkeypress="chkCharCodeNum(event);" oninput="autoHyphen(this)" onblur="requiredData(this);" placeholder="사업장 전화번호를 입력해주세요." maxlength="13" type="text" class="input input-bordered w-72"/>
								<div class="required-msg text-sm mt-2 h-5 text-red-500"></div>
							</td>
						</tr>
						<tr>
							<th>사업장 주소</th>
							<td>
								<input name="address" placeholder="사업장 주소를 입력해주세요." type="text" class="input input-bordered w-72"/>
							</td>
						</tr>
						<tr>
							<th>사업장 지역</th>
							<td>
								<div class="area">
									<input type="text" id="areaInput" class="select select-bordered w-72" placeholder="사업장 지역을 선택해주세요." readonly/>
									<div id="pull-down-box" class="pull-down-box">
										<ul>
											<li>
												<div>
													<span>서울</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(1); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">강남/역삼/삼성/신사/청담</div></li>
													<li><div onclick="insert_area_param(2); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">서초/교대</div></li>
													<li><div onclick="insert_area_param(3); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">잠실/송파/왕십리/강동</div></li>
													<li><div onclick="insert_area_param(4); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">을지로/시청/명동</div></li>
													<li><div onclick="insert_area_param(5); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">종로/인사동/동대문/강북</div></li>
													<li><div onclick="insert_area_param(6); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">서울역/이태원/용산</div></li>
													<li><div onclick="insert_area_param(7); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">마포/홍대/신촌/서대문</div></li>
													<li><div onclick="insert_area_param(8); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">영등포/여의도/김포공항</div></li>
													<li><div onclick="insert_area_param(9); document.getElementById('areaInput').setAttribute('value', '서울 > ' + this.innerText);">강남/역삼/삼성/신사/청담</div></li>
												</ul>
											</li>
											<li>
												<div>
													<span>부산</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(10); document.getElementById('areaInput').setAttribute('value', '부산 > ' + this.innerText);">해운대</div></li>
													<li><div onclick="insert_area_param(11); document.getElementById('areaInput').setAttribute('value', '부산 > ' + this.innerText);">광안리</div></li>
													<li><div onclick="insert_area_param(12); document.getElementById('areaInput').setAttribute('value', '부산 > ' + this.innerText);">부산역/남포/자갈치</div></li>
													<li><div onclick="insert_area_param(13); document.getElementById('areaInput').setAttribute('value', '부산 > ' + this.innerText);">서면/동래/연제/남구</div></li>
													<li><div onclick="insert_area_param(14); document.getElementById('areaInput').setAttribute('value', '부산 > ' + this.innerText);">기장/김해공항</div></li>
													<li><div onclick="insert_area_param(15); document.getElementById('areaInput').setAttribute('value', '부산 > ' + this.innerText);">영도/송도해수욕장</div></li>
												</ul>
											</li>
											<li>
												<div>
													<span>제주</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(16); document.getElementById('areaInput').setAttribute('value', '제주 > ' + this.innerText);">제주시/제주국제공항</div></li>
													<li><div onclick="insert_area_param(17); document.getElementById('areaInput').setAttribute('value', '제주 > ' + this.innerText);">애월/협재/한림</div></li>
													<li><div onclick="insert_area_param(18); document.getElementById('areaInput').setAttribute('value', '제주 > ' + this.innerText);">조천/함덕/김녕</div></li>
													<li><div onclick="insert_area_param(19); document.getElementById('areaInput').setAttribute('value', '제주 > ' + this.innerText);">서귀포시</div></li>
													<li><div onclick="insert_area_param(20); document.getElementById('areaInput').setAttribute('value', '제주 > ' + this.innerText);">중문</div></li>
													<li><div onclick="insert_area_param(21); document.getElementById('areaInput').setAttribute('value', '제주 > ' + this.innerText);">성산/표선</div></li>
												</ul>
											</li>
											<li>
												<div>
													<span>강원</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(22); document.getElementById('areaInput').setAttribute('value', '강원 > ' + this.innerText);">강릉/동해/삼척</div></li>
													<li><div onclick="insert_area_param(23); document.getElementById('areaInput').setAttribute('value', '강원 > ' + this.innerText);">속초/고성</div></li>
													<li><div onclick="insert_area_param(24); document.getElementById('areaInput').setAttribute('value', '강원 > ' + this.innerText);">양양/홍천/인제/철원</div></li>
													<li><div onclick="insert_area_param(25); document.getElementById('areaInput').setAttribute('value', '강원 > ' + this.innerText);">평창/정선/횡성</div></li>
													<li><div onclick="insert_area_param(26); document.getElementById('areaInput').setAttribute('value', '강원 > ' + this.innerText);">춘천/원주/영월/태백</div></li>
												</ul>
											</li>
											<li>
												<div>
													<span>경기</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(27); document.getElementById('areaInput').setAttribute('value', '경기 > ' + this.innerText);">수원/성남/판교</div></li>
													<li><div onclick="insert_area_param(28); document.getElementById('areaInput').setAttribute('value', '경기 > ' + this.innerText);">가평/양평/포천</div></li>
													<li><div onclick="insert_area_param(29); document.getElementById('areaInput').setAttribute('value', '경기 > ' + this.innerText);">용인/평택/여주/이천</div></li>
													<li><div onclick="insert_area_param(30); document.getElementById('areaInput').setAttribute('value', '경기 > ' + this.innerText);">화성/동탄/안산/부천/안양</div></li>
													<li><div onclick="insert_area_param(31); document.getElementById('areaInput').setAttribute('value', '경기 > ' + this.innerText);">고양/의정부/파주/김포</div></li>
													<li><div onclick="insert_area_param(32); document.getElementById('areaInput').setAttribute('value', '경기 > ' + this.innerText);">시흥/군포/광명</div></li>
													<li><div onclick="insert_area_param(33); document.getElementById('areaInput').setAttribute('value', '경기 > ' + this.innerText);">남양주시/구리/하남</div></li>
												</ul>
											</li>
											<li>
												<div>
													<span>인천</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(34); document.getElementById('areaInput').setAttribute('value', '인천 > ' + this.innerText);">송도/남동구/옹진군</div></li>
													<li><div onclick="insert_area_param(35); document.getElementById('areaInput').setAttribute('value', '인천 > ' + this.innerText);">인천국제공항(중구)</div></li>
													<li><div onclick="insert_area_param(36); document.getElementById('areaInput').setAttribute('value', '인천 > ' + this.innerText);">부평/계양/서구/미추홀구/강화</div></li>
												</ul>
											</li>
											<li>
												<div>
													<span>경상</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(37); document.getElementById('areaInput').setAttribute('value', '경상 > ' + this.innerText);">경주</div></li>
													<li><div onclick="insert_area_param(38); document.getElementById('areaInput').setAttribute('value', '경상 > ' + this.innerText);">거제/고성</div></li>
													<li><div onclick="insert_area_param(39); document.getElementById('areaInput').setAttribute('value', '경상 > ' + this.innerText);">포항/청송/영덕/울진</div></li>
													<li><div onclick="insert_area_param(40); document.getElementById('areaInput').setAttribute('value', '경상 > ' + this.innerText);">통영/창</div></li>
													<li><div onclick="insert_area_param(41); document.getElementById('areaInput').setAttribute('value', '경상 > ' + this.innerText);">대구/구미/문경/안동</div></li>
													<li><div onclick="insert_area_param(42); document.getElementById('areaInput').setAttribute('value', '경상 > ' + this.innerText);">창원/양산/김해/울산</div></li>
													<li><div onclick="insert_area_param(43); document.getElementById('areaInput').setAttribute('value', '경상 > ' + this.innerText);">사천/남해/진주/하동</div></li>
												</ul>
											</li>
											<li>
												<div>
													<span>전라</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(44); document.getElementById('areaInput').setAttribute('value', '전라 > ' + this.innerText);">여수</div></li>
													<li><div onclick="insert_area_param(45); document.getElementById('areaInput').setAttribute('value', '전라 > ' + this.innerText);">전주</div></li>
													<li><div onclick="insert_area_param(46); document.getElementById('areaInput').setAttribute('value', '전라 > ' + this.innerText);">광주</div></li>
													<li><div onclick="insert_area_param(47); document.getElementById('areaInput').setAttribute('value', '전라 > ' + this.innerText);">순천/광양</div></li>
													<li><div onclick="insert_area_param(48); document.getElementById('areaInput').setAttribute('value', '전라 > ' + this.innerText);">군산/익산/부안/진안/무주</div></li>
													<li><div onclick="insert_area_param(49); document.getElementById('areaInput').setAttribute('value', '전라 > ' + this.innerText);">화순/남원/구례</div></li>
													<li><div onclick="insert_area_param(50); document.getElementById('areaInput').setAttribute('value', '전라 > ' + this.innerText);">목포/나주/완도/해남/영암</div></li>
												</ul>
											</li>
											<li>
												<div>
													<span>충청</span>
													<span>></span>
												</div>
												<ul>
													<li><div onclick="insert_area_param(51); document.getElementById('areaInput').setAttribute('value', '대전 > ' + this.innerText);">대전</div></li>
													<li><div onclick="insert_area_param(52); document.getElementById('areaInput').setAttribute('value', '대전 > ' + this.innerText);">천안/아산/예산/당진</div></li>
													<li><div onclick="insert_area_param(53); document.getElementById('areaInput').setAttribute('value', '대전 > ' + this.innerText);">보령(대천)/태안(안면도)/서산/부여</div></li>
													<li><div onclick="insert_area_param(54); document.getElementById('areaInput').setAttribute('value', '대전 > ' + this.innerText);">충주/제천/단양</div></li>
													<li><div onclick="insert_area_param(55); document.getElementById('areaInput').setAttribute('value', '대전 > ' + this.innerText);">청주/세종</div></li>
												</ul>
											</li>
										</ul>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>체크인 시간</th>
							<td>
								<select name="timeChkin" class="timeChkin select select-bordered">
									<option selected disabled></option>	
									<option>00:00</option>
									<option>01:00</option>
									<option>02:00</option>
									<option>03:00</option>
									<option>04:00</option>
									<option>05:00</option>
									<option>06:00</option>
									<option>07:00</option>
									<option>08:00</option>
									<option>09:00</option>
									<option>10:00</option>
									<option>11:00</option>
									<option>12:00</option>
									<option>13:00</option>
									<option>14:00</option>
									<option>15:00</option>
									<option>16:00</option>
									<option>17:00</option>
									<option>18:00</option>
									<option>19:00</option>
									<option>20:00</option>
									<option>21:00</option>
									<option>22:00</option>
									<option>23:00</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>체크아웃 시간</th>
							<td>
								<select name="timeChkout" class="timeChkout select select-bordered">
									<option selected disabled></option>
									<option>00:00</option>
									<option>00:00</option>
									<option>01:00</option>
									<option>02:00</option>
									<option>03:00</option>
									<option>04:00</option>
									<option>05:00</option>
									<option>06:00</option>
									<option>07:00</option>
									<option>08:00</option>
									<option>09:00</option>
									<option>10:00</option>
									<option>11:00</option>
									<option>12:00</option>
									<option>13:00</option>
									<option>14:00</option>
									<option>15:00</option>
									<option>16:00</option>
									<option>17:00</option>
									<option>18:00</option>
									<option>19:00</option>
									<option>20:00</option>
									<option>21:00</option>
									<option>22:00</option>
									<option>23:00</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>시설 유형</th>
							<td>
							<div class="flex">
								<label class="cursor-pointer flex items-center">
							    <input type="radio" name="accommodationType" value="hotel"/>
							    <span class="text-sm ml-2">호텔</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="accommodationType" value="motel"/>
							    <span class="text-sm ml-2">모텔</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="accommodationType" value="pension"/>
							    <span class="text-sm ml-2">펜션</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="accommodationType" value="guesthouse"/>
							    <span class="text-sm ml-2">게스트하우스</span> 
							  </label>
							</div>
						</td>
						</tr>
						<tr>
							<th>사업장 프로필 <br /> 이미지 등록</th>
							<td>
								<input name="file__company__0__extra__profileImg__1" placeholder="사업장 대표 이미지" type="file" />
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

function companyRegister__submit(form) {
	
	form.name.value = form.name.value.trim();
	if(form.name.value.length == 0) {
		alert('상호를 입력해주세요');
		form.name.focus();
		
		return;
	}
	
	form.cellphoneNo.value = form.cellphoneNo.value.trim();
	if(form.cellphoneNo.value.length == 0) {
		alert('사업장 전화번호를 입력해주세요');
		form.cellphoneNo.focus();
		
		return;
	}
	
	form.address.value = form.address.value.trim();
	if(form.address.value.length == 0) {
		alert('사업장 주소를 입력해주세요');
		form.address.focus();
		
		return;
	}
	
	form.area.value = form.area.value.trim();
	if(form.area.value.length == 0) {
		alert('사업장 지역을 선택해주세요');
		form.area.focus();
		
		return;
	}
	
	form.timeChkin.value = form.timeChkin.value.trim();
	if(form.timeChkin.value.length == 0) {
		alert('체크인 시간을 선택해주세요');
		form.timeChkin.focus();
		
		return;
	}
	
	form.timeChkout.value = form.timeChkout.value.trim();
	if(form.timeChkout.value.length == 0) {
		alert('체크아웃 시간을 선택해주세요');
		form.timeChkout.focus();
		
		return;
	}
	
	form.accommodationType.value = form.accommodationType.value.trim();
	if(form.accommodationType.value.length == 0) {
		alert('시설 유형을 선택해주세요');
		
		return;
	}
	
	form.file__company__0__extra__profileImg__1.value = form.file__company__0__extra__profileImg__1.value.trim();
	if(form.file__company__0__extra__profileImg__1.value.length == 0) {
		alert('사업장 프로필 이미지를 등록해주세요.');
		
		return;
	}
	
	form.submit();
}

function insert_area_param(areaNo) {
	document.getElementById('area').setAttribute('value', areaNo);
};

//전화번호칸에 숫자만 사용 가능하도록 하는 함수 시작(입력키 제한)
	function chkCharCodeNum(event) {
	  const keyCode = event.keyCode;
	  const isValidKey = (keyCode >= 48 && keyCode <= 57);
	  if (!isValidKey) {
	    event.preventDefault();
	    return false;
	  }
	};
//전화번호칸에 숫자만 사용 가능하도록 하는 함수 끝

//전화번호칸에 숫자를 적어 나아가면 자동으로 하이픈 붙여주는 함수 시작
	const autoHyphen = (target) => {
		 target.value = target.value
		   .replace(/[^0-9]/g, '')
		  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
//전화번호칸에 숫자를 적어 나아가면 자동으로 하이픈 붙여주는 함수 끝

//전화번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 시작
	function requiredData(el) {
		$(".required-msg").empty();
		const form = $(el).closest('form').get(0);
		
		if (form.cellphoneNo.value.length <= 8) {
			$(".required-msg").html('전화번호를 확인해주세요.');
		}
	};
//전화번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 끝

</script>

<%@ include file="../common/foot.jspf" %>