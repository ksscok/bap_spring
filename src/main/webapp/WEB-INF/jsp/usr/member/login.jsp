<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="메인" />
<%@ include file="../common/head.jspf" %>

<section class="mt-60">
	<div class="con-1 mx-auto px-3">
		<form class="flex justify-center" method="POST" action="../member/doLogin">
			<table>
				<colgroup>
					<col width="350"/>
				</colgroup>
				<tbody>
					<tr>
						<td>
							<div>
								<input name="loginId" type="text" class="input input-bordered w-full " placeholder="🤵  아이디"/>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<input name="loginPw" type="text" class="input input-bordered w-full mt-2" placeholder="🔒  비밀번호"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="submit" class="btn btn-primary w-full mt-4" value="로그인"/>
						</td>
					</tr>
					<tr>
						<td class="flex justify-around items-center text-sm font-semibold mt-4">
							<a href="usr/member/findLoginId">아이디 찾기</a>
							<a href="usr/member/findLoginPw">비밀번호 찾기</a>
							<a href="usr/member/join">회원가입</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</section>


<%@ include file="../common/foot.jspf" %>