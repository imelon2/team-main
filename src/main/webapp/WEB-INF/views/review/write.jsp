<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec"	 uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="rev" tagdir="/WEB-INF/tags/review" %>
<%@ taglib prefix="bot" tagdir="/WEB-INF/tags/botnav" %>

<!DOCTYPE html>
<html>
<head>

<link href="${appRoot }/resources/favicon/brand_logo.png" rel="shortcut icon" type="image/x-icon">

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Review - write JSP File</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">

<style type="text/css">
@font-face {
	font-family: 'GongGothicMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'GongGothicMedium';
}

.jinah-layout {
	box-shadow: 1px 1px 20px #A3A3A3;
	display: block;
	margin-left: auto;
	margin-right: auto;
	width: 1110px;
	padding-top: 30px;
	padding-bottom: 50px;
	margin-top: 50px;
	margin-bottom: 10px;
}

.review-star-child {
	padding: 5px;
	background-color: white;
	border: none;
	outline: none;
}

#jinah-star1, #jinah-star2, #jinah-star3, #jinah-star4, #jinah-star5 {
	width: 50px;
	height: 50px;
	color: #ffe62e;
}

#re-write-content {
	display: flex;
	flex-direction: column;
	align-content: center;
}

#logo {
	padding: 50px;
}

#re-input2-label {
	padding: 6px 25px;
	background-color: #FF84A9;
	border-radius: 4px;
	color: white;
	cursor: pointer;
}

.write-btn:hover {
	background-color: #FF5289;
	color: #FFFFF;
}

</style>

<link rel="stylesheet" type="text/css"
	href="${appRoot }/resources/css/uploadajax.css">

<script>
	const appRoot = "${appRoot}";
</script>

<script src="${appRoot }/resources/js/review/uploadajax.js"></script>
<script src="${appRoot }/resources/js/review/reviewstar-write.js"></script>

<!-- 구독자 이용 세탁소 정보 JS -->
<script type="text/javascript">
	$(function() {

		var idVal = $("#write-userid").val();
		var data = {userid : idVal};
		
		$.ajax({
			type : "get",
			url : "${appRoot}/review/getaddress2",
			data : data,
			success : function(data) {
				console.log(idVal);
				if (idVal != "") {
					console.log(idVal);
					console.log("구독중");
					$("#re-input4").val(data.storename);
					$("#re-input5").val(data.storeaddress);
					
					// 운영자 글 작성 시 적용 사항
					if (idVal == 'admin') {
						console.log(idVal);
						$("#re-input4").attr("hidden", "hidden");
						$("#re-input5").attr("hidden", "hidden");
						$("#reinput-label4").attr("hidden", "hidden");
						$("#reinput-label5").attr("hidden", "hidden");
					}

				} else if (idVal == "") {
					console.log("구독중 아님");
					$("#re-input4").val("구독중이 아닙니다.");
					$("#re-input5").val("구독중이 아닙니다.");
				}

			},
			error : function() {
				console.log("구독 세탁소 이름 주소 불러오기 실패");
			}
		});
	});
</script>

</head>
<body style="overflow-x: hidden;">

	<rev:navbar></rev:navbar>

	<!-- 메인 로고 -->
	<div class="container">
		<div class="row justify-content-center">
			<a href="${appRoot }/member/main"> <img id="logo" alt="jinah-logo"
				src="${appRoot }/resources/image/others/brand_logo_400px.png">
			</a>
		</div>
	</div>

	<rev:search></rev:search>

<div class="jinah-layout">
	<!-- 리뷰 평점 -->
	<sec:authorize access="hasRole('ROLE_USER')">
		<div id="review-star-parent" style="display: inline;"
			class="container">
			<div
				class="review-star-parent row justify-content-center d-flex align-items-center">
				<button data-operation="like" type="button"
					class="item review-star-child">
					<i class="review-star-icon far fa-star" id="jinah-star1"></i>
				</button>
				<button data-operation="like" type="button"
					class="item review-star-child">
					<i class="review-star-icon far fa-star" id="jinah-star2"></i>
				</button>
				<button data-operation="like" type="button"
					class="item review-star-child">
					<i class="review-star-icon far fa-star" id="jinah-star3"></i>
				</button>
				<button data-operation="like" type="button"
					class="item review-star-child">
					<i class="review-star-icon far fa-star" id="jinah-star4"></i>
				</button>
				<button data-operation="like" type="button"
					class="item review-star-child">
					<i class="review-star-icon far fa-star" id="jinah-star5"></i>
				</button>
				<div>
					<input class="review-result btn btn-warning" type="submit"
						value="등록하기">
				</div>
			</div>
		</div>
		<div style="margin: 20px; font-family: 'Pacifico', cursive;" class="row justify-content-center">
					<span style="font-size: 30px; font-family: 'Pacifico', cursive;">Your grading is...</span>
					<span style="color: #0583F2; font-size: 30px; font-family: 'Pacifico', cursive;" id="reStars" name="reStars">${review.reStars }</span>
		</div>
	</sec:authorize>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<input hidden id="review-star-result" name="reviewStars" value="5">
	</sec:authorize>

	<!-- 리뷰 글 쓰기 input -->
	<div id="re-write-content" class="container">
		<div class="row justify-content-center">
			<div class="col-8">
				<form id="review-write-form1" action="${appRoot }/review/write"
					method="post" enctype="multipart/form-data">
					<!-- 제목 -->
					<div class="item form-group">
						<label for="re-input1">리뷰 제목</label> <input id="re-input1"
							class="form-control" name="reTitle" type="text" minlength="3"
							placeholder="제목을 입력해주세요." required>
					</div>
					<!-- 내용 -->
					<div class="item form-group">
						<label for="re-textarea1">리뷰 내용</label>
						<textarea class="form-control" name="reContent" cols="2" rows="10"
							placeholder="내용을 입력해주세요." required></textarea>
					</div>

					<!-- 이미지 파일 -->
					<div id="uploadDiv" class="item form-group">
						<label id="re-input2-label" for="re-input2">이미지 업로드</label> <input
							style="display: none;" id="re-input2" class="form-control"
							multiple="multiple" type="file" name="file" accept="image/*">
					</div>
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
					<!-- 작성자 -->
					<div class="item form-group">
						<label for="re-input3">리뷰 작성자</label> <input id="re-input3"
							class="form-control" value="${pinfo.member.userNickname }"
							readonly>
					</div>
					<!-- data : userid -->
					<input id="write-userid" type="hidden" name="reWriterName"
						value="${pinfo.member.userid }" readonly>

					<!-- 이용한 세탁소 위치 정보 -->
	               <div class="item form-group">
	                  <label id="reinput-label4" for="re-input4">나의 구독 세탁소 이름</label> <input id="re-input4"
	                     class="form-control" value="" name="storeName" readonly>
	               </div>
	               <div class="item form-group">
	                  <label id="reinput-label5" for="re-input5">나의 구독 세탁소 주소</label> <input id="re-input5"
                     class="form-control" value="" name="storeAddress" readonly>
					</div>
					<input class="write-btn btn btn-primary btn-lg" id="write-submit" type="submit"
						value="리뷰 등록하기">
					
					<!-- 평점 필수 입력 JS -->
					<script>
						$(function() {
							$("#write-submit").click(function(e) {
								console.log("write working");
								if ($("#stars-submit").val() == 0) {
									e.preventDefault();
									alert("리뷰 평점 평가는 필수 항목입니다.");
								} else {
									$("#review-write-form1").submit();
								}
							})
						})
					</script>

					<!-- 평점 Value 넣기 -->
					<input hidden id="stars-submit" value="" name="reStars"> <input
						hidden id="stars-admin" value="${pinfo.member.userid }">
				</form>
			</div>
		</div>
	</div>
</div>


	
	<div style="padding: 30px 0px;" class="container">
		<div class="row justify-content-center">
			<a href="${appRoot }/review/list"><button type="button"
					class="btn btn-info btn-lg">다른 리뷰 보러가기</button></a>
		</div>
	</div>
	
	<!-- Footer -->
	<div class="container">
		<bot:botnav></bot:botnav>
	</div>
</body>
</html>