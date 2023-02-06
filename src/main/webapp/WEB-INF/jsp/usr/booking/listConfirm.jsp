<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약 목록" />
<%@ include file="../common/head.jspf"%>

<!-- bookingListConfirm css -->
<link rel="stylesheet" href="/resource/bookingListConfirm.css" />

<section class="my-10">
	<div class="con-3 mx-auto px-3">
		<div class="non-memberInquiry-box flex justify-center mt-32">
			<div class="non-memberInquiry">
				<div class="text-2xl font-bold my-5">비회원 예약 조회</div>
				<form onsubmit="chkNull(event);" action="list">
					<div class="cellphoneNoInput-box flex items-center">
						<div class="text-3xl text-gray-300 mx-3"><i class="fa-solid fa-mobile-screen-button"></i></div>
						<input id="cellphoneNo" name="cellphoneNo" onkeypress="chkCharCodeNum(event);" type="text" class="cellphoneNo" oninput="autoHyphen(this)" style="width:230px;" placeholder="휴대폰 번호" maxlength="13" onblur="cellphoneNoData(this);"/>
					</div>
					<div class="bookingIdInput-box flex items-center mt-2">
						<div class="text-3xl text-gray-300 mx-3"><i class="fa-solid fa-receipt"></i></div>
						<input id="searchKeyword" name="searchKeyword" onkeypress="chkCharCodeNum(event);" type="text" class="searchKeyword" style="width:230px;" placeholder="예약 번호" maxlength="13" onblur="searchKeywordData(this);"/>
					</div>
						<button class="text-center btn btn-active btn-secondary w-full mt-4">조회하기</button>
				</form>
			</div>
		</div>
	</div>
</section>

<script>
	//전화번호칸, 예약번호칸에 숫자만 사용 가능하도록 하는 함수 시작(입력키 제한)
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
	
	//휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 시작
	function cellphoneNoData(el) {
		$(".cellphoneNo").empty();
		const form = $(el).closest('form').get(0);
		
		if (form.cellphoneNo.value.length <= 8) {
			$(".cellphoneNo").html('휴대폰 번호를 확인해주세요.');
			}
		};
	//휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 끝
	
	// list에 보내기전에 입력 내용 체크하는 함수
	function chkNull(event){
		
		if(document.getElementById('cellphoneNo').value.trim().length == 0){
		    alert('전화번호를 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
		if(document.getElementById('cellphoneNo').value.trim().length <= 10 && document.getElementById('cellphoneNo').value.trim().length != 0){
		    alert('전화번호를 정확히 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
		if(document.getElementById('searchKeyword').value.trim().length == 0){
		    alert('예약번호를 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
	}
	
	
</script>

<%@ include file="../common/foot.jspf"%>