<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약" />
<%@ include file="../common/head.jspf"%>

<c:set var="pageBaseUri" value="${pageBaseUri}?searchKeyword=${param.searchKeyword}" />
<c:set var="pageBaseUri" value="${pageBaseUri}&low_price=${param.low_price}" />
<c:set var="pageBaseUri" value="${pageBaseUri}&high_price=${param.high_price}" />

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
  

    var IMP = window.IMP; 
    IMP.init('TC0ONETIME'); 
    IMP.request_pay({
    	pg : "kakaopay", 
        pay_method : 'card',
        merchant_uid : 'merchant_' + new Date().getTime(),
        name : '결제',
        amount : 주문개수,
        buyer_email : '구매자 이메일',
        buyer_name : '구매자 이름',
        buyer_tel : '구매자 번호',
        buyer_addr : '구매자 주소',
        buyer_postcode : '구매자 주소',
        m_redirect_url : 'redirect url'
    }, function(rsp) {
        if ( rsp.success ) {
            var msg = '결제가 완료되었습니다.';
            location.href='결제완료후 갈 url';
        } else {
            var msg = '결제에 실패하였습니다.';
            rsp.error_msg;
            
        }
    });


    </script>

<section class="my-20">
		<div class="con-3 flex flex-row mx-auto px-3">
			<h1> kakaoPay api 이용하기 </h1>
 
			<form method="post" action="/kakaoPay">
			    <button>카카오페이로 결제하기</button>
			</form>
		</div>
</section>






<%@ include file="../common/foot.jspf"%>