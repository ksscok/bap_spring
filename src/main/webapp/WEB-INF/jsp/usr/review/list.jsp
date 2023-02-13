<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="리뷰 목록" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jsp"%>

<!-- reviewList css -->
<link rel="stylesheet" href="/resource/reviewList.css" />

<section class="my-10">
	<div class="con-3 mx-auto px-3">
		<div class="text-2xl font-bold">리뷰 목록</div>
		<div class="searchAndDelete-box flex justify-between items-center">
			<div class="mb-2 flex justify-between items-center flex-grow">
				<div>
					<span>${reviews.size() } 개</span>
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
			<button class="mr-2 ml-6 text-3xl btn-delete-selected-reviews"><i class="fa-solid fa-trash-can"></i></button>
			
			<form method="POST" name="do-delete-reviews-form" action="doDeleteAtReviewList">
				<input type="hidden" name="ids" />
				<input type="hidden" name="memberId" value="${rq.getLoginedMemberId() }" />
			</form>
		</div>
		<div class="showReview mb-2">
		<c:choose>
			<c:when test="${reviews.size() == 0 }">
				<div class="text-center mt-10">조건에 일치하는 검색결과가 없습니다</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="review" items="${reviews}" varStatus="status">
					<div class="checkboxPlusCompanyList-box flex justify-between items-center">
						<input type="checkbox" class="checkbox-review-id mx-20" value="${review.id }" />
						<div id="review${status.count }" class="showReview-box mt-10">
							<div class="showReview-box-top flex justify-start" style="width: 655px;">
								<div>프로필img</div>
								<div class="flex justify-between" style="width: 655px;">
									<div class="company-box">
										<div class="ml-3 mb-1">
											<span class="text-gray-400">숙소 이름 : &nbsp;&nbsp;</span>
											<span class="text-xl font-bold">${review.extra__compName }</span>
										</div>
										<div class="ml-3 mb-1">
											<span class="text-gray-400">방 타입 : &nbsp;&nbsp;</span>
											<span class="text-lg font-bold">${review.extra__prodRoomType }</span>
										</div>
									</div>
									<div class="dropdown">
										<button class="btn btn-circle btn-ghost btn-sm">
											<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
										</button>
										<ul tabindex="0" class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-20">
											<li>
												<a onclick="ReviewModify__getForm(${review.id }, ${status.count });">수정</a>
											</li>
											<li>
												<a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="../review/doDelete?id=${review.id }&comp_id=${review.comp_id}">삭제</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="showReview-box-bottom -ml-2">
								<div class="ml-20 showReview-rating-box">
									<span class="text-yellow-400">${ratingOptions.get(review.rating) }</span>
									<span class="ml-1">${review.rating }</span>
								</div>
								<div class="ml-20 mt-4 text-gray-400">리뷰 번호 : ${review.id }</div>
								<div class="ml-20 mt-1 text-gray-400">${review.extra__writerName }</div>
								<div class="ml-20 mt-1">${review.getForPrintBody() }</div>
								<div class="img-box ml-20 mt-2">
									<img src="https://image.goodchoice.kr/resize_490x348/affiliate/2019/07/16/5d2d61e24506b.jpg" alt="" />
								</div>
								<div class="flex justify-between">
									<div class="mt-5 text-gray-400 ml-20">${review.updateDate }</div>
									<a href="../product/detail?comp_id=${review.comp_id }" class="text-center btn btn-active btn-secondary mt-3">숙소 상세보기</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
</section>

<script>
// 체크박스 선택 후 삭제 함수 시작
	$('.btn-delete-selected-reviews').click(function() {
		const values = $('.checkbox-review-id:checked').map((index, el) => el.value).toArray();
		if (values.length == 0) {
			alert('선택한 리뷰가 없습니다');
			return;
		}
		if (confirm('선택한 리뷰를 삭제하시겠습니까?') == false) {
			return;
		}
		$('input[name=ids]').val(values.join(','));
		$('form[name=do-delete-reviews-form]').submit();
	})
// 체크박스 선택 후 삭제 함수 끝

//리뷰 수정 함수 시작
	originalForm = null;
	originalId = null;

	function ReviewModify__getForm(reviewId, i) {	
	
		if(originalForm != null){
			ReviewModify__cancel(originalId);
		}
		
		$.get('../review/getReviewContent', {
			id : reviewId,
			ajaxMode : 'Y'
		}, function(data){
			let reviewContent = $('#review' + i);
			originalId = i;
			originalForm = reviewContent.html();
			
			let addHtml = `
				<div class="writeReview-box mx-2">
					<form action="../review/doModify" onsubmit="submitFormReviewModify(this); return false;">
						<input type="hidden" id="id2" name="id" value="\${data.data1.id }" />
						<input type="hidden" id="memberId2" name="memberId" value="\${data.data1.memberId }" />
						<input type="hidden" id="comp_id2" name="comp_id" value="\${data.data1.comp_id }" />
						<div class="text-sm text-gray-400 mb-2">리뷰를 남겨주세요.</div>
						<div class="text-sm text-gray-400 mb-2">\${data.data1.extra__writerName }</div>
						<div class="writeReview-rating-box mb-2">
							<c:forEach begin="1" end="5" var="writeStar" varStatus="status">
								<a id="star${status.count }" style="cursor: pointer;" class="text-yellow-400" onclick="change_star(${status.count });">☆</a>
							</c:forEach>
							<input id="rating2" name="rating" class="writeRating ml-1" type="text" readonly/>
						</div>
						<input id="booking_id2" name="booking_id" class="booking_id-box mb-3 border-gray" type="text" placeholder="   예약번호 : \${data.data1.booking_id}"/>
						<div class="toast-ui-editor2">
							<script type="text/x-template"><\/script>
						</div>
						<input id="body2" type="hidden" name="body" />
						<div class="flex justify-end">
							<a onclick="ReviewModify__cancel(\${i})" class="text-center btn btn-active btn-secondary mt-3 mr-3">취소</a>
							<button class="text-center btn btn-active btn-secondary mt-3">수정</button>
						</div>
					</form>
				</div>`;
				
			reviewContent.empty().html("");
			reviewContent.append(addHtml);
			
			// 아마 클래스명이 toast-ui-editor인 태그가 두 개여서 수정 폼에서는 안먹는 것 같아서 뒤에 2 붙여서 하니까 됨 
			$('.toast-ui-editor2').each(function(index, node) {
			    const $node = $(node);
			    const $initialValueEl = $node.find(' > script');
			    const initialValue = $initialValueEl.length == 0 ? '' : $initialValueEl.html().trim();
			    const editor = new toastui.Editor({
			      el: node,
			      previewStyle: 'tab',
			      initialValue: initialValue,
			      height:'200px',
			      plugins: [
			        [toastui.Editor.plugin.chart, ToastEditor__chartOptions],
			        [toastui.Editor.plugin.codeSyntaxHighlight, {highlighter:Prism}],
			        toastui.Editor.plugin.colorSyntax,
			        toastui.Editor.plugin.tableMergedCell,
			        toastui.Editor.plugin.uml,
			        katexPlugin,
			        youtubePlugin,
			        codepenPlugin,
			        replPlugin
			      ],
			      customHTMLSanitizer: html => {
			        return DOMPurify.sanitize(html, { ADD_TAGS: ["iframe"], ADD_ATTR: ['width', 'height', 'allow', 'allowfullscreen', 'frameborder', 'scrolling', 'style', 'title', 'loading', 'allowtransparency'] }) || ''
			      }
			    });
			    $node.data('data-toast-editor', editor);
			  });
			
		}, 'json');
	}

// toast-ui-editor2를 위한 함수
	function submitFormReviewModify(form){
	  
	  form.memberId2.value = form.memberId2.value.trim();
		  
	  if(form.memberId2.value.length == 0){
	  	alert('로그인 후 이용해주세요.');
	    return;
	  }
	  
	  form.comp_id2.value = form.comp_id2.value.trim();
		  
	  if(form.comp_id2.value.length == 0){
	  	alert('사업장 번호를 입력해주세요.');
	    return;
	  }
	  
	  form.rating2.value = form.rating2.value.trim();
		  
	  if(form.rating2.value.length == 0){
	  	alert('별점을 체크해주세요.');
	    return;
	  }
	  
	  if(form.booking_id2.value.length == 0){
		  	alert('예약 번호를 입력해주세요.');
		  	form.booking_id2.focus();
		    return;
	  }
	  
	  const editor = $(form).find('.toast-ui-editor2').data('data-toast-editor');
	  const markdown2 = editor.getMarkdown().trim();
	  
	  if(markdown2.length < 2){
	    alert('리뷰 내용을 2글자 이상 입력해주세요');
	    editor.focus();
	    return;
	  }
	  
	  form.booking_id.value = form.booking_id.value.trim();
	  
	  document.getElementById('body2').value = markdown2;
	  
	  form.submit();
	}

	function ReviewModify__cancel(i) {
		let reviewContent = $('#review' + i);
		reviewContent.html(originalForm);
		
		originalForm = null;
		originalId = null;
	}
//리뷰 수정 함수 끝
</script>

<%@ include file="../common/foot.jspf"%>