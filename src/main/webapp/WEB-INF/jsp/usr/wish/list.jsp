<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="찜 목록" />
<%@ include file="../common/head.jspf"%>

<!-- wishList css -->
<link rel="stylesheet" href="/resource/wishList.css" />

<section class="my-10">
	<div class="con-3 mx-auto px-3">
		<div class="text-2xl font-bold">찜 목록</div>
		<div class="searchAndDelete-box flex justify-between items-center">
			<div class="mb-2 flex justify-between items-center flex-grow">
				<div>
					<span>${wishesCount } 개</span>
				</div>
				<form>
					<input type="hidden" name="memberId" value="${rq.getLoginedMemberId() }" />
					
					<select data-value="${searchKeywordTypeCode }" class="select select-bordered" name="searchKeywordTypeCode">
						<option value="name">숙소 이름</option>
					</select>
					
					<input class="ml-2 w-84 input input-bordered" type="text" name="searchKeyword" placeholder="예약번호를 입력해주세요" maxlength="20" value="${searchKeyword }" />
	
					<button class="ml-2 btn btn-active btn-ghost">검색</button>
				</form>
			</div>
			<button class="mr-2 ml-6 text-3xl btn-delete-selected-companies"><i class="fa-solid fa-trash-can"></i></button>
			
			<form method="POST" name="do-delete-companies-form" action="doDeleteAtWishList">
				<input type="hidden" name="memberId" value="${rq.getLoginedMemberId() }" />
				<input type="hidden" name="comp_id" value="" />
			</form>
		</div>
		<c:choose>
			<c:when test="${wishesCount == 0 }">
				<div class="text-center mt-10">조건에 일치하는 검색결과가 없습니다</div>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="companies" value="${companies }"/>
				<c:forEach var="company" items="${companies}" >
					<div class="checkboxPlusCompanyList-box flex justify-between items-center">
						<input type="checkbox" class="checkbox-member-id mx-4 checkbox-company-id" value="${company.id }" />
						<a href="../product/detail?comp_id=${company.id }" class="flex-grow">
							<span class="companyList-box flex mt-5">
							<!-- 		추후에 product 대표 이미지로 바꾸기 -->
								<span class="img-box">
									 <img src="${rq.getCompanyProfileImgUri(company.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
								</span>
								<span class="company-infor ml-4 w-full">
									<span class="companyList-top-box h-1/2">
										<span>숙소명 : ${company.name }</span>
										<br />
										<span>(리뷰 칸)★★★★☆ 점수(리뷰 개수)</span>
										<br />
									</span>
									<br />
									<span class="companyList-bottom-box h-1/2 flex justify-end items-end mt-5">
										<span>체크인 : ${company.timeChkin }</span>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span><fmt:formatNumber value="${company.extra__minFee}" pattern="#,###"/></span>
										&nbsp;
										<span class="text-sm" style="line-height: 25px;">원</span>
										<span>~</span>
									</span>
								</span>
							</span>
						</a>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</section>

<script>
	$('.btn-delete-selected-companies').click(function() {
		const values = $('.checkbox-company-id:checked').map((index, el) => el.value).toArray();
		if (values.length == 0) {
			alert('선택한 숙소가 없습니다');
			return;
		}
		if (confirm('선택한 숙소를 찜 목록에서 삭제하시겠습니까?') == false) {
			return;
		}
		$('input[name=comp_id]').val(values.join(','));
		$('form[name=do-delete-companies-form]').submit();
	})
</script>

<%@ include file="../common/foot.jspf"%>