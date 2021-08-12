<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="mem" tagdir="/WEB-INF/tags/member"%>
<%@ taglib prefix="bot" tagdir="/WEB-INF/tags/botnav"%>

<!DOCTYPE html>
<html>
<head>

<link href="${appRoot }/resources/favicon/brand_logo.png"
	rel="shortcut icon" type="image/x-icon">

<mem:mainpage></mem:mainpage>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>마이페이지</title>
</head>
<body style="overflow-x: hidden;">
	<style type="text/css">
.jumbotron {
	box-shadow: 5px 3px 10px gray;
	border: 3px solid #88C9F1;
	-webkit-border-radius: 40px;
	-moz-border-radius: 40px;
	border-radius: 5px;
	background-color: #88C9F1;
}

@font-face {
	font-family: 'GongGothicMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	font-family: 'GongGothicMedium';
}
</style>



     <!-- 로고 -->
	<div class="container">
		<div class="row justify-content-center">
			<a href="${appRoot }/member/main"> <img style="padding: 70px;"
				id="logo" alt="jinah-logo"
				src="${appRoot }/resources/image/others/brand_logo_400px.png">
			</a>
		</div>
		<br> <br>

		<!-- navbar 전에 권한처리
 <ul class="nav justify-content-end">
  
  <sec:authorize access="isAnonymous()">
		  		<form action="${appRoot }/member/login">
		  			<input class="btn btn-primary mr-1" type="submit" value="로그인"> 
	  			</form>
	  		
		  		<form action="${appRoot }/help/helpdesk">
		  			<input class="btn btn-primary mr-1" type="submit" value="고객센터"> 
	  			</form>
	  		</sec:authorize> -->

		<!--  로그인 했을때 -->
		<!--   12
	  		<sec:authorize access="isAuthenticated()">       
	  			<form action="${appRoot }/logout" method="post">
	  					<input class="btn btn-primary mr-1" type="submit" value="로그아웃"> 
	  			</form>
	  	
	  		
	  			<form action="${appRoot }/help/helpdesk">	
	  					<input class="btn btn-primary mr-1" type="submit" value="고객센터"> 
	  			</form>
	  		</sec:authorize>
</ul>  
 -->


         <!-- 메뉴list -->
		<div class="btn-group dropleft">
			<button class="btn btn-info btn-lg dropdown-toggle" type="button"
				id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false">CATEGORY</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a class="dropdown-item" href="${appRoot }/member/myget">내 정보 확인</a>
				<!--    <a class="dropdown-item" href="${appRoot }/member/subinfo">구독정보</a> -->
				<a class="dropdown-item" href="${appRoot}/searchstore/searchMap">매장
					찾기</a> <a class="dropdown-item" href="${appRoot }/help/askList">나의
					1:1문의내역</a> <a class="dropdown-item" href="${appRoot }/review/list">구독
					리뷰</a>
				<sec:authorize access="hasAnyRole('ROLE_B2BUSER', 'ROLE_EMPUSER')">
					<a class="dropdown-item"
						href="${appRoot }/searchstore/b2bIntroduceBoard">홍보페이지 관리</a>
				</sec:authorize>
				<a class="dropdown-item"
					href="${appRoot}/cancelSubs/cancelSubsBoard">구독 취소</a>
			</div>
		</div>



		<!-- 구독 신청 버튼 권한 부여 + subsoptions정보 불러오기 -->
		<script type="text/javascript">
			$(function() {
				let loginID = "${pinfo.member.userid}";
				$.ajax({
					type : "POST",
					url : "${appRoot}/member/getLoginInfo",
					data : {
						userid : loginID
					},
					success : function(data) {

						let confirmID = data;
						console.log(confirmID);

						if (data == '') {
							$(".mypage-subinfo2").show();
							$("#mypage-subinfo-2").show();
							$("#mypage-subinfo-21").show();

						} else if (data != '') {
							$.ajax({
								type : "post",
								url : "${appRoot}/member/getsubsoptions",
								data : {
									userid : loginID
								},
								success : function(data1) {
									$("#sub-options").text(" " + data1 + " ");
									console.log(data1);
								},
								error : function() {
									console.log("구독자 불러오기 실패!");
								}

							})

							$(".mypage-subinfo1").show();
							$("#mypage-subinfo-1").show();
							$("#mypage-subinfo-22").show();
						}
					},
					error : function() {
						console.log("실패");
					}
				})
			})
		</script>


        <!-- 내정보,이름,구독종류 -->
		<div class="jumbotron">
			<h1 class="display-4">안녕하세요 ${member.userName } 회원님</h1>
			<br>

			<sec:authorize access="hasRole('ROLE_USER')">
				<div style="display: none;" class="mypage-subinfo1">
					고객님이 이용중인 서비스는<span style="font-size: 30px; color: #0583F2;"
						id="sub-options"></span>입니다.
				</div>
				<div style="display: none;" class="mypage-subinfo2">
					혹시 아직 서비스를 이용하지 않고 계신가요~? <br> 서둘러 밑에 구독하기 버튼을 눌러주세요!
				</div>
				<hr class="my-4">


				<div class="row">
					<div class="col-sm-6">
						<div class="card">

							<div class="card-body" style="display: none;"
								id="mypage-subinfo-21">
								<h5 class="card-title">싱글 구독</h5>
								<p class="card-text">혼자 사는 싱글들을 위한 맞춤형 구독</p>
								<a href="${appRoot }/subscribe/subsregister"
									class="btn btn-info">1인 가구 구독</a>
							</div>
							<div class="card-body" style="display: none;"
								id="mypage-subinfo-22">
								<h5 class="card-title">${member.userName }님구독 완료</h5>
								<p class="card-text"></p>
								<a href="" class="btn btn-info"><i
									class="fas fa-hand-sparkles"></i> </a>
							</div>


						</div>
					</div>
					<div class="col-sm-6">
						<div class="card">

							<div class="card-body" style="display: none;"
								id="mypage-subinfo-2">
								<h5 class="card-title">대형 구독</h5>
								<p class="card-text">가족 구성원들과 함께 이용하는 구독 서비스</p>
								<a href="${appRoot }/subscribe/subsregister"
									class="btn btn-info">다세대 가구 구독</a>
							</div>

							<div class="card-body" style="display: none;"
								id="mypage-subinfo-1">
								<h5 class="card-title">${member.userName }님구독 정보</h5>
								<p class="card-text"></p>
								<a href="${appRoot }/subscribe/finalinfo" class="btn btn-info">
									<i class="fas fa-info"></i>
								</a>
							</div>

						</div>
					</div>
				</div>
			</sec:authorize>

		</div>

         <!-- 페이지 밑에 nav알림 -->
		<bot:botnav></bot:botnav>

	</div>





</body>
</html>

