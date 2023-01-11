<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="상품 등록" />
<%@ include file="../common/head.jspf" %>

<section class="mt-14">
	<div class="con-2 mx-auto px-3">
		<div class="text-xl">상품 등록</div>
		<form class="table-box-type-2 flex justify-center flex-col mt-5 text-sm" method="POST" enctype="multipart/form-data" action="../host/doRegister">
			<table>
				<colgroup>
					<col width="200"/>
					<col width="700"/>
				</colgroup>
				<tbody>
					<tr>
						<th>상품 리스트 페이지 <br> 이미지 등록</th>
						<td>
							<input name="file__host__0__extra__productListImg__1" placeholder="상품 이미지" type="file" />
						</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<th>상품 디테일 페이지 <br> 이미지 등록</th>
						<td>
							<input name="file__host__0__extra__productDetailImg__1" placeholder="상품 이미지" type="file" />
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