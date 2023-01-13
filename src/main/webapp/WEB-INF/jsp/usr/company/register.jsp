<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="사업장 등록" />
<%@ include file="../common/head.jspf" %>

<section class="mt-20">
	<div class="con-3 flex flex-row mx-auto px-3 ">
		<div class="side-bar-myPage mr-6">
			<div class="p-5 pt-0">
				<ul>
					<li><a href="../member/myPage">개인정보수정</a></li>
				</ul>
				<ul>
					<li><a href="../company/register">사업장 등록</a></li>
				</ul>
				<ul>
					<li><a href="../company/management">사업장 관리</a></li>
				</ul>
			</div>
		</div>
		<div class="table-box-type-2 company-list mt-0 flex flex-col text-sm">
			<div class="text-xl">사업장 등록</div>
			<form class="table-box-type-2 flex justify-center flex-col mt-5 text-sm" method="POST" enctype="multipart/form-data" action="../company/doRegister">
				<input type="hidden" name="host_id" value="${rq.loginedMember.id}"/>
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
							<th>시설 유형</th>
							<td>
							<div class="flex">
								<label class="cursor-pointer flex items-center">
							    <input type="radio" name="accommodationType" value="hotel" checked/>
							    <span class="text-sm ml-2">호텔</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="accommodationType" value="motel"/>
							    <span class="text-sm ml-2">모텔</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="accommodationType" value="pension"/>
							    <span class="text-sm ml-2">펜션</span> 
							  </label>
							  <label class="cursor-pointer flex items-center ml-5">
							    <input type="radio" name="accommodationType" value="guesthouse"/>
							    <span class="text-sm ml-2">게스트하우스</span> 
							  </label>
							</div>
						</td>
						</tr>
						<tr>
							<th>사업장 프로필 <br /> 이미지 등록</th>
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
	</div>
</section>

<%@ include file="../common/foot.jspf" %>