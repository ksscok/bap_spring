<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../common/head.jspf" %>

<section class="mt-20">
	<div class="con-3 flex flex-row mx-auto px-3 ">
		<div class="side-bar-myPage mr-6">
			<div class="p-5 pt-0">
				<ul>
					<li><a href="../member/myPage">개인정보수정</a></li>
				</ul>
				<c:if test="${rq.loginedMember.memberType.equals('guest')}">
					<ul>
						<li><a href="/usr/booking/list?cellphoneNo=${rq.getLoginedMember().cellphoneNo }">예약내역</a></li>
					</ul>
					<ul>
						<li><a href="../member/coupon">쿠폰함(개발 예정)</a></li>
					</ul>
					<ul>
						<li><a href="../point/list?memberId=${rq.loginedMember.id }">포인트 내역</a></li>
					</ul>
					<ul>
						<li><a href="/usr/wish/list?memberId=${rq.loginedMember.id }">찜</a></li>
					</ul>
					<ul>
						<li><a href="../review/list?memberId=${rq.loginedMember.id }">리뷰 관리</a></li>
					</ul>
				</c:if>
				<c:if test="${rq.loginedMember.memberType.equals('host')}">
					<ul>
						<li><a href="../company/register">사업장 등록</a></li>
					</ul>
					<ul>
						<li><a href="../management/companyList">사업장 관리</a></li>
					</ul>
				</c:if>
			</div>
		</div>
		<div class="table-box-type-2 company-list mt-0 flex flex-col text-sm">
			<div class="text-xl">개인정보수정</div>
			<table class="mt-5">
				<colgroup>
					<col width="200"/>
					<col width="700"/>
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
						<td>${rq.loginedMember.loginId}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${rq.loginedMember.name}</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${rq.loginedMember.email}</td>
					</tr>
					<tr>
						<th>핸드폰 번호</th>
						<td>${rq.loginedMember.cellphoneNo}</td>
					</tr>
					<tr>
						<th>포인트</th>
						<td class='text-green-500 font-bold text-lg'>+ ${rq.loginedMember.m_point}</td>
					</tr>
				</tbody>
			</table>
			<div class="mt-5 text-center">
				<a href="../member/checkPassword" class="btn btn-active w-36 h-11">개인정보수정</a>
				<button type="button" class="btn btn-active btn-ghost w-36 h-11" onclick="history.back();">뒤로가기</button>
			</div>
		</div>
	</div>
</section>


<%@ include file="../common/foot.jspf" %>