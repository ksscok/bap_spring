<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../common/head.jspf" %>

<section class="mt-14">
	<div class="con-2 mx-auto px-3">
		<div class="text-xl">마이페이지</div>
		<div class="table-box-type-2 flex justify-center flex-col mt-5 text-sm">
			<table>
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