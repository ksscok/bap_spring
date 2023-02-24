<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../common/head.jspf" %>

<section class="mt-14">
	<div class="con-2 mx-auto px-3">
		<div class="text-xl">회원정보 수정</div>
		<form class="table-box-type-2 flex justify-center flex-col mt-5 text-sm" method="POST" action="../member/doModify">
		<input type="hidden" name="id" value="${rq.loginedMember.id}"/>
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
						<th>비밀번호</th>
						<td>
							<input name="loginPw" type="text" class="input input-bordered w-64" placeholder="변경할 비밀번호를 입력해주세요."/>
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input name="loginPwConfirm" type="text" class="input input-bordered w-64" placeholder="비밀번호를 다시 한번 입력해주세요."/>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${rq.loginedMember.name}</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input name="email" type="text" class="input input-bordered w-64" placeholder="이메일을 입력해주세요." value="${rq.loginedMember.email}"/>
						</td>
					</tr>
					<tr>
						<th>핸드폰 번호</th>
						<td>
							<input name="cellphoneNo" type="text" class="input input-bordered w-64" placeholder="핸드폰 번호를 입력해주세요." value="${rq.loginedMember.cellphoneNo}"/>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="mt-5 text-center">
				<button type="submit" class="btn btn-active w-36 h-11">확인</button>
				<button class="btn btn-active btn-ghost w-36 h-11">취소</button>
			</div>
		</form>
	</div>
</section>


<%@ include file="../common/foot.jspf" %>