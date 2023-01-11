<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="사업장 등록" />
<%@ include file="../common/head.jspf" %>

<section class="mt-14">
	<div class="con-2 mx-auto px-3">
		<div class="text-xl">사업장 등록</div>
		<form class="table-box-type-2 flex justify-center flex-col mt-5 text-sm" method="POST" enctype="multipart/form-data" action="../company/doRegister">
			<table>
				<colgroup>
					<col width="200"/>
					<col width="700"/>
				</colgroup>
				<tbody>
					<tr>
						<th>상호</th>
						<td>
							<input name="name" placeholder="상호를 입력해주세요." type="text" class="input input-bordered w-64" />
						</td>
					</tr>
					<tr>
						<th>사업장 주소</th>
						<td>
							<input name="address" placeholder="사업장 주소를 입력해주세요." type="text" class="input input-bordered w-64"/>
						</td>
					</tr>
					<tr>
						<th>사업장 대표 이미지 등록</th>
						<td>
							<input name="file__company__0__extra__profileImg__1" placeholder="사업장 대표 이미지" type="file" />
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