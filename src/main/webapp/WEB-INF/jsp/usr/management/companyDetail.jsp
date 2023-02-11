<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="사업장 정보" />
<%@ include file="../common/head.jspf" %>

<section class="mt-20">
	<div class="con-3 flex flex-row mx-auto px-3 ">
		<div class="side-bar-myPage mr-6">
			<div class="p-5 pt-0">
				<ul>
					<li><a href="../management/companyDetail?id=${param.id}">사업장 정보</a></li>
				</ul>
				<ul>
					<li><a href="../management/bookingList?comp_id=${param.id }">예약 확인</a></li>
				</ul>
				<ul>
					<li><a href="../product/management">리뷰 확인</a></li>
				</ul>
				<ul>
					<li><a href="../product/register?id=${param.id}">객실 등록</a></li>
				</ul>
				<ul>
					<li><a href="../management/productList?id=${param.id}">객실 관리</a></li>
				</ul>
			</div>
		</div>
		<div class="table-box-type-2">
			<div class="text-xl">사업장 정보</div>
			<table class="mt-5">
					<colgroup>
					<col width="200"/>
					<col width="700"/>
				</colgroup>
				<tbody>
					<tr>
						<th>등록날짜</th>
						<td>${company.regDate}</td>
					</tr>
					<tr>
						<th>수정날짜</th>
						<td>${company.updateDate}</td>
					</tr>
					<tr>
						<th>상호</th>
						<td>${company.name}</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${company.cellphoneNo}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${company.address}</td>
					</tr>
					<tr>
						<th>지역</th>
						<td>${rq.getAreaMap(company.area)}</td>
					</tr>
					<tr>
						<th>체크인 시간</th>
						<td>${company.timeChkin}</td>
					</tr>
					<tr>
						<th>체크아웃 시간</th>
						<td>${company.timeChkout}</td>
					</tr>
					<tr>
						<th>시설 유형</th>
						<td>${company.getForPrintAccommodationType()}</td>
					</tr>
				</tbody>
			</table>
			<div class="mt-5 text-center">
				<a href="../member/checkPassword" class="btn btn-active w-36 h-11">정보수정</a>
				<a href="../management/companyList" class="btn btn-active btn-ghost w-36 h-11">뒤로가기</a>
			</div>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>