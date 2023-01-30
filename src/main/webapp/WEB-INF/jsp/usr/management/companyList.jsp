<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="사업장 관리" />
<%@ include file="../common/head.jspf" %>
<link rel="stylesheet" href="/resource/managementCompanyList.css" />

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
					<li><a href="../management/companyList">사업장 관리</a></li>
				</ul>
			</div>
		</div>
		<div class="table-box-type-2">
			<div class="text-xl">사업장 관리</div>
			<table class="mt-5">
				<colgroup>
					<col width="150"/>
					<col width="300"/>
					<col width="200"/>
					<col width="200"/>
				</colgroup>
				<thead>
					<tr>
						<th>사업장 번호</th>
						<th>상호</th>
						<th>시설 유형</th>
						<th>등록날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="company" items="${companies}">
						<tr>	
							<td>${company.id}</td>
							<td>
								<a href="../management/companyDetail?id=${company.id}">${company.name}</a>
							</td>
							<td>${company.getForPrintAccommodationType()}</td>
							<td>${company.getForPrintRegDate()}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf" %>