<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약" />
<%@ include file="../common/head.jspf"%>

<!-- 토스페이먼츠 -->
<script src="https://js.tosspayments.com/v1/payment"></script>
<!-- book css -->
<link rel="stylesheet" href="/resource/book.css" />

<section class="">
	<div class="con-3 flex flex-row mx-auto px-3">
		<div class="left left_book mr-14">
			<div class="guestInfor">
				<div class="font-bold my-8">예약자 정보</div>
				<div class="info_chkin mb-2 font-semibold">예약자 이름</div>
				<input type="text" class="input input-bordered w-full" placeholder="체크인시 필요한 정보입니다." maxlength="20" />
				<div class="mt-9 info_chkin mb-2 font-semibold">휴대폰 번호</div>
				<div class="info_chkin text-xs mb-8">개인 정보 보호를 위해 안심번호로 숙소에 전송됩니다.</div>
				<form action="">
					<div class="guestCellPhoneNum-box mb-16 w-full">
<!-- 				로그인시 고객의 번호를 가져오는 칸 -->
						<input type="text" class="input input-bordered input-md" style="width:440px;" placeholder="체크인시 필요한 정보입니다." maxlength="13" name="guestCellphoneNum" onblur="requiredData(this);"/>
<!-- 				휴대폰번호 11자리 입력 안하면 활성화 안되게 막아놓음/앞자리가 0으로 시작 안해도 활성화 안되게 막아놓음 -->
						<button type="submit" class="text-center btn btn-active btn-secondary">인증번호 전송</button>
						<div class="required-msg text-sm mt-2 h-5 text-red-500"></div>
					</div>
				</form>
				<c:if test="${rq.getLoginedMemberId() == 0}">
					<div class="guest_login text-center w-full h-28 flex justify-center items-center">
						<a href="../member/login" >
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
<!-- 			몇박인지는 (체크인-체크아웃)으로 가져와야할 듯?/근데 날짜가 28~31까지라서 이렇게 계산하면 길게 계산했을때 무조건 오륜데.. -->
					<div class="text-xl font-bold mb-7">${product.roomType }/${diff }박</div>
					<div class="info_chkin mb-2">체크인</div>
					<div class="text-xl font-bold mb-7">${DateAndDayOfTheWeekOfChkin }  ${company.timeChkin }</div>
					<div class="info_chkin mb-2">체크아웃</div>
					<div class="text-xl font-bold mb-9">${DateAndDayOfTheWeekOfChkout } ${company.timeChkout }</div>
				</div>
			</div>
			<div class="payment">
				<div class="font-extrabold mt-9">총 결제 금액</div>
				<div class="my-4 text-2xl font-extrabold text-red-600">${price }원</div>
				<ul>
					<li>
						<a href="#">
							결제완료 후
							<span class="text-red-600">예약자 이름</span> 
							으로 바로
							<span class="text-red-600">체크인</span> 
							하시면 됩니다
						</a>
					</li>
				</ul>
				<button id="payment-button" class="text-center btn btn-active btn-secondary w-full mt-4">결제하기</button>
<!-- 				결제하기 눌렀을 때 예약자 이름이 적혀있지 않다면 모달창으로 입력해달라고 보여주기 -->
			</div>
		</div>
	</div>
</section>

<script>
// 휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 시작
	function requiredData(el) {
		$(".required-msg").empty();
		const form = $(el).closest('form').get(0);
		
		if (form.guestCellphoneNum.value.length <= 8) {
			$(".required-msg").html('휴대폰 번호를 확인해주세요.');
		}
	}
// 휴대폰 번호 미입력 or 8자리 이하일 때 입력하라는 말 뜨도록하는 함수 끝
	
// 	토스페이먼츠 결제창 불러오는 함수 시작
		var clientKey = 'test_ck_Lex6BJGQOVDyvaadL5nrW4w2zNbg'
	    var tossPayments = TossPayments(clientKey)

	    var button = document.getElementById('payment-button') // 결제하기 버튼

	    button.addEventListener('click', function () {
	      tossPayments.requestPayment('카드', {
	        amount: 15000,
	        // 주문번호를 계속 바꿔야 계속 실행됨. DB에서 테이블 생성하고 규칙을 정해서 난수 발생 등으로 들어가게 해야할 듯
	        orderId: 'rp2EgdCu0A-iQ5CvL-Mqq',
	        orderName: '토스 티셔츠 외 2건',
	        customerName: '박토스',
	        successUrl: 'http://localhost:8082/success',
	        failUrl: 'http://localhost:8082/fail',
	      })
	    })
// 	토스페이먼츠 결제창 불러오는 함수 끝
</script>

<%@ include file="../common/foot.jspf"%>