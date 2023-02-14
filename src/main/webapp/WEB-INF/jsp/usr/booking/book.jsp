<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약" />
<%@ include file="../common/head.jspf"%>

<!-- 토스페이먼츠 -->
<script src="https://js.tosspayments.com/v1/payment"></script>
<!-- book css -->
<link rel="stylesheet" href="/resource/book.css" />

<section class="">
	<form id="writeForm" onsubmit="chkNull(event);" action="doBook" >
		<input id=memberId type="hidden" name="memberId" value="${rq.getLoginedMemberId() }" />
		<input id=comp_id type="hidden" name="comp_id" value="${comp_id }" />
		<input id=prod_id type="hidden" name="prod_id" value="${prod_id }" />
		<input id=amount type="hidden" name="amount" value="${product.fee }" />
		<input id="orderId" type="hidden" name="orderId" value="${orderId }" />
		<input id="start_date" type="hidden" name="start_date" value="${start_date }" />
		<input id="end_date" type="hidden" name="end_date" value="${end_date }" />
		<input id="countOfAdult" type="hidden" name="countOfAdult" value="${countOfAdult }" />
		<input id="countOfChild" type="hidden" name="countOfChild" value="${countOfChild }" />
		<input id="DateAndDayOfTheWeekOfChkin" type="hidden" name="DateAndDayOfTheWeekOfChkin" value="${DateAndDayOfTheWeekOfChkin }" />
		<input id="DateAndDayOfTheWeekOfChkout" type="hidden" name="DateAndDayOfTheWeekOfChkout" value="${DateAndDayOfTheWeekOfChkout }" />
		<input id="orderName" type="hidden" name="orderName" value="${company.name }/${product.roomType } " />
		<input id="diff" type="hidden" name="diff" value="${diff } " />
		<input id="isWrite" type="hidden" name="isWrite" value="${isWrite } " />
		<div class="con-3 flex flex-row mx-auto px-3">
			<div class="left left_book mr-14">
				<div class="guestInfor">
					<div class="font-bold my-8">예약자 정보</div>
					<div class="info_chkin mb-2 font-semibold">예약자 이름</div>
					<input id="customerName" name="customerName" type="text" onkeypress="chkCharCodeName(event);" class="input input-bordered w-full" placeholder="체크인시 필요한 정보입니다." maxlength="20" />
					<div class="mt-9 info_chkin mb-2 font-semibold">휴대폰 번호</div>
					<div class="info_chkin text-xs mb-8">개인 정보 보호를 위해 안심번호로 숙소에 전송됩니다.</div>
	<!-- 				<form id="cellphoneNumConfirm"> -->
						<div class="cellphoneNo-box mb-16 w-full">
	<!-- 				로그인시 고객의 번호를 가져오는 칸 -->
							<input id="cellphoneNo" name="cellphoneNo" onkeypress="chkCharCodeNum(event);" type="text" oninput="autoHyphen(this);" class="input input-bordered input-md" style="width:440px;" placeholder="체크인시 필요한 정보입니다." maxlength="13" onblur="requiredData(this);"/>
	<!-- 				휴대폰번호 11자리 입력 안하면 활성화 안되게 막아놓음/앞자리가 0으로 시작 안해도 활성화 안되게 막아놓음 -->
	<!-- 						<button type="submit" class="text-center btn btn-active btn-secondary">인증번호 전송</button> -->
							<button class="text-center btn btn-active btn-secondary">인증번호 전송</button>
							<div class="required-msg text-sm mt-2 h-5 text-red-500"></div>
						</div>
	<!-- 				</form> -->
					<c:if test="${rq.isLogined() }">
						<div class="m_point-box -mt-8 flex justify-between items-center">
							<div class="info_chkin font-semibold mb-1">사용 가능한 포인트</div>
							<div>
								<input type="text" id="m_point" name="m_point" value="<fmt:formatNumber value="${rq.getLoginedMember().getM_point() }" pattern="#,###" />" class="text-green-500 text-2xl" style="text-align: right; width: 100px;" readonly/>
								<span>원</span>
							</div>
						</div>
						<div class="flex justify-between items-center mt-6">
							<div>사용</div>
							<div class="usePointAmount-box flex items-center">
								<div style="height: 24px; width: 10px"></div>
								<input id="usepointAmount" name="pay_point" onkeydown="chkCharCodePoint(event);" class="text-green-500" style="text-align: right; width: 150px;" type="text" placeholder="0"  />							
								<span class="mr-2">원</span>
								<button type="button" id="pointDelete-btn" onclick="pointDelete();" class="mr-2"><i class="fa-solid fa-circle-xmark"></i></button>
								<button type="button" class="px-2 useAllPoint-btn" onclick="chgValueOfPay_point();">전액사용</button>
							</div>
						</div>
						<div class="required-msg2 text-sm mt-2 h-5 text-red-500" style="text-align: right;"></div>
						<div class="alwaysUseAllAmount-box flex justify-end mt-1">
							<button type="button" class="text-green-500" onclick="alwaysUseAllAmount();"><i id="i-alwaysUseAllAmount-btn" class="fa-regular fa-circle-check"></i></button>
							<span class="ml-2">항상 전액사용</span>
						</div>
					</c:if>
					<c:if test="${rq.getLoginedMemberId() == 0}">
						<div class="guest_login text-center w-full h-28 flex justify-center items-center">
							<a href="${rq.loginUri}" >
								로그인 후 예약하시면
								<br />
								할인 쿠폰과 추가 혜택을 받을 수 있어요
								<br />
								<span class="text-sm">로그인&nbsp;></span>
							</a>
						</div>
					</c:if>
				</div>
			</div>
			
			<div class="right right_side_bar ml-14">
				<div class="accomInfor border-bt-gray">
					<div class="bookingInfor">
						<div class="info_chkin mb-2 mt-16">숙소이름</div>
						<div class="text-xl font-bold mb-7">${company.name }</div>
						<div class="info_chkin mb-2">객실타입/기간</div>
						<div class="text-xl font-bold mb-7">${product.roomType }/${diff }박</div>
						<div class="info_chkin mb-2">체크인</div>
						<div class="text-xl font-bold mb-7">${DateAndDayOfTheWeekOfChkin }  ${company.timeChkin }</div>
						<div class="info_chkin mb-2">체크아웃</div>
						<div class="text-xl font-bold mb-9">${DateAndDayOfTheWeekOfChkout } ${company.timeChkout }</div>
					</div>
				</div>
				<div class="payment">
					<div class="font-extrabold mt-9">총 결제 금액</div>
					<div class="my-4 text-xl font-extrabold text-red-600">${price }원</div>
					<div class="showUsePoint-box flex justify-between items-center mb-2">
						<div>포인트 차감</div>
						<div class="text-lg">
						<span class="text-xl font-extrabold">-</span> 
						<input id="showUsePoint" type="text" style="text-align: right; width: 70px;" readonly/>원
						</div>
					</div>
					<div class="balanceAmount-box flex justify-between items-center mb-2">
						<div class="font-extrabold">실제 결제 금액</div>
						<div class="text-xl font-extrabold text-red-600"><input id="balanceAmount" type="text" name="balanceAmount" value="" style="text-align: right; width: 90px;" readonly/>원</div>
<%-- 						<div class="text-xl font-extrabold text-red-600"><input id="balanceAmount" type="text" name="balanceAmount" value="<fmt:formatNumber value="" pattern="#,###" />" style="text-align: right; width: 90px;" readonly/>원</div> --%>
					</div>
					<ul class="mt-5">
						<li>
							<a href="#">
								결제완료 후
<!-- 								<span class="text-red-600">예약자 이름</span>  -->
								으로 바로
								<span class="text-red-600">체크인</span> 
								하시면 됩니다
							</a>
						</li>
					</ul>
					<c:if test="${rq.isLogined() }">
						<ul class="mt-1">
							<li>
								<a href="#">
									결제완료 후
									<span class="text-red-600">포인트를 제외한</span> 
									총 결제금액의 
									<span class="text-red-600">2%</span>가
									포인트로 적립됩니다
								</a>
							</li>
						</ul>
						<ul class="mt-1">
							<li>
								<a href="#">
									예약(결제) 취소 시 적립된 포인트는 다시
									<span class="text-red-600">반환</span> 
									됩니다
								</a>
							</li>
						</ul>
					</c:if>
					<button class="text-center btn btn-active btn-secondary w-full mt-4 mb-10">결제하기</button>
				</div>
			</div>
		</div>
	</form>
</section>

<script>
// 예약자 이름칸에 숫자, 한글, 영어, 스페이스, 백스페이스만 사용 가능하도록 하는 함수 시작(입력키 제한)
	// 추후에 스페이스 횟수 제한 찾아보기
	function chkCharCodeName(event) {
		  const keyCode = event.keyCode;
		  const isValidKey = (
		    (keyCode >= 48 && keyCode <= 57) || // Numbers
		    (keyCode >= 97 && keyCode <= 122) || // Numbers, Keypad
		    (keyCode >= 65 && keyCode <= 90) || // Alphabet
		    (keyCode === 32) || // Space
		    (keyCode === 8) || // BackSpace
		    (keyCode === 189) // Dash
		  );
		  if (!isValidKey) {
		    event.preventDefault();
		    return false;
		  }
		};
// 예약자 이름칸에 숫자, 한글, 영어, 스페이스, 백스페이스만 사용 가능하도록 하는 함수 끝

// 전화번호칸에 숫자만 사용 가능하도록 하는 함수 시작(입력키 제한)
	function chkCharCodeNum(event) {
		  const keyCode = event.keyCode;
		  const isValidKey = (keyCode >= 48 && keyCode <= 57);
		  if (!isValidKey) {
		    event.preventDefault();
		    return false;
		  }
		};
// 전화번호칸에 숫자만 사용 가능하도록 하는 함수 끝

// 포인트칸에 숫자만 사용 가능하도록 하는 함수 시작(입력키 제한)
	// conts 이름이 위에랑 같아서 안먹는듯? 근데 왜 또 chkCharCodeName이랑은 같은데 문제가 없는거지? isValidKey에서 담는 변수가 달라서 가능한건가?
	function chkCharCodePoint(event) {
		  const keyCode2 = event.keyCode;
		  const isValidKey2 = ((keyCode2 >= 48 && keyCode2 <= 57) || (keyCode2 === 8));
		  if (!isValidKey2) {
		    event.preventDefault();
		    return false;
		  }
		};
// 포인트칸에 숫자만 사용 가능하도록 하는 함수 끝

// 전화번호칸에 숫자를 적어 나아가면 자동으로 하이픈 붙여주는 함수 시작
	const autoHyphen = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
// 전화번호칸에 숫자를 적어 나아가면 자동으로 하이픈 붙여주는 함수 끝

// pay_point칸에 숫자를 적어 나아가면 자동으로 콤마 붙여주는 함수 시작
	const input = document.querySelector('#usepointAmount');
	input.addEventListener('keyup', function(e) {
	  let value = e.target.value;
	  value = Number(value.replaceAll(',', ''));
	  if(isNaN(value)) {
	    input.value = 0;
	  }else {
	    const formatValue = value.toLocaleString('ko-KR');
	    input.value = formatValue;
	  }
	})
// pay_point칸에 숫자를 적어 나아가면 자동으로 콤마 붙여주는 함수 끝

	  

// 휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 시작
	function requiredData(el) {
		$(".required-msg").empty();
		const form = $(el).closest('form').get(0);
		
		if (form.cellphoneNo.value.length <= 8) {
			$(".required-msg").html('휴대폰 번호를 확인해주세요.');
			}
		};
// 휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 끝
	
// 전액사용 버튼 클릭시 사용 가능한 포인트(m_point)값을 pay_point input 값에 넣어주고 delete-btn 생기도록 하는 함수 시작
	function chgValueOfPay_point(){
		let m_point = $('#m_point').val();
		$('#usepointAmount').val(m_point);
		$('#pointDelete-btn').css('display', 'block')
	}
// 전액사용 버튼 클릭시 사용 가능한 포인트(m_point)값을 pay_point input 값에 넣어주고 delete-btn 생기도록 하는 함수 끝

// 포인트 사용 입력칸에 value = 0일 경우 close버튼 사라지고 아닐경우 버튼 나타나는 함수 시작		
		 $(document).ready(function() {
	        $('#usepointAmount').keydown(function(e) {
	        	var usepointAmount = $('#usepointAmount').val();
	       	 	$('#showUsePoint').val($(this).val());
	          
	          if(usepointAmount != 0){
	        	  $('#pointDelete-btn').css('display', 'block');
	        	  
	        	  // pay_point 입력값이 m_point 값보다 큰 값을 입력할 경우를 막으려는 로직 시작
	        	  var mPointValue = $('#m_point').val();
	        	  
	        	  var m_length = $('#m_point').val().length
	        	  var p_length = usepointAmount.length
	        	  
	        	  const keyCode4 = e.keyCode;
        		  const isValidKey4 = (keyCode4 === 8);
	        	  
	        	  if(p_length >= m_length){
	        		  $(".required-msg2").html('사용 가능한 포인트를 넘어설 수 없습니다.');
	        		  $('#usepointAmount').val(mPointValue);
	        		  if (!isValidKey4) {
	        		    e.preventDefault();
	        		    return false;
	        		  }
	        	  }
	        	  $(".required-msg2").html('');
	        	  // pay_point 입력값이 m_point 값보다 큰 값을 입력할 경우를 막으려는 로직 시작
	        	  
	          } else {
	        	  $('#pointDelete-btn').css('display', 'none')
	        	  $('#showUsePoint').val('');
	          }
	          
	        } );
	      } );
	      
	     // pay_point를 입력하고 나서 마우스로 다른 곳을 클릭할 때라도 showUsePoint가 바뀌도록 하는 함수 시작
		 $(document).ready(function() {
		        $('#usepointAmount').keydown(function() {
		        	$('#showUsePoint').val($(this).val());
		        } );
	      } );
		 $(document).ready(function() {
		        $('#usepointAmount').change(function() {
		        	$('#showUsePoint').val($(this).val());
		        	
		        	// 실제 결제 금액 = 총 결제 금액 - pay_point 시작
		        	 let totalAmount = parseInt($('#amount').val());
					 
					 let sup = parseInt($('#usepointAmount').val().replace(/,/g, ""));
			        	
					 let t_s = (totalAmount-sup);
					 // 실제 결제 금액을 3자리마다 콤마 찍어주기 위한 작업 시작
					 const option = {
							  maximumFractionDigits: 0
							};
					 
					 let bA = t_s.toLocaleString('ko-KR', option);
					 // 실제 결제 금액을 3자리마다 콤마 찍어주기 위한 작업 끝
					 
			        $('#balanceAmount').val(bA);
		        	// 실제 결제 금액 = 총 결제 금액 - pay_point 끝
		        } );
	      } );
	     // pay_point를 입력하고 나서 마우스로 다른 곳을 클릭할 때라도 showUsePoint가 바뀌도록 하는 함수 끝
// 포인트 사용 입력칸에 value = 0일 경우 close버튼 사라지고 아닐경우 버튼 나타나는 함수 시작		
		
// close(pointDelete-btn)버튼 클릭시 pay_point 값 0으로 초기화하는 함수 시작
	function pointDelete(){
		$('#usepointAmount').val(0);
		$('#showUsePoint').val('');
	}
// close(pointDelete-btn)버튼 클릭시 pay_point 값 0으로 초기화하는 함수 끝
		
// 항상 전액사용 버튼 클릭시 작동 함수 시작
	function alwaysUseAllAmount(){
	
		if($('#i-alwaysUseAllAmount-btn').hasClass('fa-regular')){
			
			let memberId = $('#memberId').val();
			localStorage.setItem("memberId", memberId);
			
			$('#i-alwaysUseAllAmount-btn').removeClass('fa-regular').addClass('fa-solid');
			chgValueOfPay_point();
		}else {
			localStorage.removeItem("memberId");
			
			$('#i-alwaysUseAllAmount-btn').removeClass('fa-solid').addClass('fa-regular');
			pointDelete()
		}
	}
// 항상 전액사용 버튼 클릭시 작동 함수 끝
		
// 항상 전액 사용 버튼을 눌렀는지 여부에 따른 페이지 시작시 포인트 사용 관련 ui 변환 함수 시작
	window.onload = function(){
			let stMemberId = localStorage.getItem("memberId");
			
			if(stMemberId == null){
				
			} else {
				chgValueOfPay_point();
				$('#i-alwaysUseAllAmount-btn').removeClass('fa-regular').addClass('fa-solid');
			}
		}
// 항상 전액 사용 버튼을 눌렀는지 여부에 따른 페이지 시작시 포인트 사용 관련 ui 변환 함수 끝
		
// write에 보내기전에 입력 내용 체크하고, localStorage에 customerName 저장하기 위한 함수
	function chkNull(event){
		
		// pay_point의 값이 변할 때 showUsePoint의 값이 바로바로 변하지 않아서 결제로 넘어가기 전에 교정 시작
		let inputPP = $('#usepointAmount').val().trim();
		
		$('#showUsePoint').val(inputMP);
		// pay_point의 값이 변할 때 showUsePoint의 값이 바로바로 변하지 않아서 결제로 넘어가기 전에 교정 끝
	
		if(document.getElementById('customerName').value.trim().length == 0){
		    alert('예약자 이름을 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
		if(document.getElementById('cellphoneNo').value.trim().length == 0){
		    alert('전화번호를 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
		if(document.getElementById('cellphoneNo').value.trim().length <= 10 && document.getElementById('cellphoneNo').value.trim().length != 0){
		    alert('전화번호를 정확히 입력해주세요');
		    event.preventDefault(); // return false와 같은 역할
	    }
		
		// 결제성공창에서 customerName을 확인시켜주기 위한 작업
	    if(document.getElementById('customerName').value.trim().length != 0){
		    sessionStorage.setItem('customerName', document.getElementById('customerName').value);
	    }
	}
	
</script>

<%@ include file="../common/foot.jspf"%>