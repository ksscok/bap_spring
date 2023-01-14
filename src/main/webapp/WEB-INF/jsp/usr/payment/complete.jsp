<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약" />
<%@ include file="../common/head.jspf"%>


<script src="https://js.tosspayments.com/v1/payment"></script>

<section class="my-20">
	<div class="con-3 flex flex-row mx-auto px-3 justify-between">
		<div>
			<span>총 주문금액</span>
      		 <span>15,000 원</span>
		</div>
		<button id="payment-button">15,000원 결제하기</button>
	</div>
</section>

<script>
var clientKey = 'test_ck_Lex6BJGQOVDyvaadL5nrW4w2zNbg'
    var tossPayments = TossPayments(clientKey)

    var button = document.getElementById('payment-button') // 결제하기 버튼

    button.addEventListener('click', function () {
      tossPayments.requestPayment('카드', {
        amount: 15000,
        // 주문번호를 계속 바꿔야 계속 실행됨. DB에서 테이블 생성하고 규칙을 정해서 난수 발생 등으로 들어가게 해야할 듯
        orderId: 'rp2EgdCu0A-iQ5CvL-Mqw',
        orderName: '토스 티셔츠 외 2건',
        customerName: '박토스',
        successUrl: 'http://localhost:8082/success',
        failUrl: 'http://localhost:8082/fail',
      })
    })
	
</script>






<%@ include file="../common/foot.jspf"%>