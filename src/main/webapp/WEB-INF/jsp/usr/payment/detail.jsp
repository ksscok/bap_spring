<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="예약 상세보기" />
<%@ include file="../common/head.jspf"%>

<!-- bookingDetail css -->
<link rel="stylesheet" href="/resource/bookingDetail.css" />

<section>
	<div class="con-3 mx-auto px-3">
	 mId : 
	 ${mId }
	</div>
</section>

<script>
	// UTC를 Local로 변경하는 함수 시작
	let date1 = document.getElementById('dateTime').value;
	
	const reqdate = new Date(date1).toISOString().replace('T', ' ').substring(0, 16);
	$(document).ready(function chgUtcLocal(date){
		$('input[name=dateTime]').attr('value', reqdate);
	})
	// UTC를 Local로 변경하는 함수 끝
	
</script>

<%@ include file="../common/foot.jspf"%>