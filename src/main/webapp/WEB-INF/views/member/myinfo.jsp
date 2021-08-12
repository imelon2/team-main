<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="mem" tagdir="/WEB-INF/tags/member"%>

<!DOCTYPE html>
<html>
<head>
 
<link href="${appRoot }/resources/favicon/brand_logo.png"
	rel="shortcut icon" type="image/x-icon">

<mem:mainpage></mem:mainpage>
<br>
<br>
<br>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>

<style type="text/css">
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

.control-label {
	color: #6464CD;
}

.label12 {
	color: #6464CD;
}
</style>



</head>
<body>





	<script>
		$(function() {
			var oldPasswordModal = $("#old-password-modal");
			var whichButton = "";
			// 모달의 확인 버튼 클릭시 
			$("#old-password-modal-btn").click(
					function() {
						switch (whichButton) {
						case "modify-button":
							$("#member-form").attr("action",
									"${appRoot}/member/modify").submit();
							alert("수정 완료");
							break;

						case "remove-button":
							$("#member-form").attr("action",
									"${appRoot}/member/remove").submit();
							alert("탈퇴 완료");
							break;
						}
					});

			// 수정 기능
			$("#btn-modify")
					.click(
							function(e) {
								var pw1 = $("#member-info-input2").val();
								var pw2 = $("#member-info-input4").val();

								if (pw1 != pw2) {
									alert("암호와 암호 확인이 일치하지 않습니다.");
									console.log("암호일치x");
									return false;

								}

								// 이메일 조건 + 비밀번호 조건
								var idE = $("#userEmail").val();
								var idR = $("#member-info-input2").val();
								var idR = $("#member-info-input4").val();
								console.log(idE);

								var $re = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
								var $regex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

								if (!$re.test(idE)) {
									alert("정확한 형식의 Email을 입력해 주세요");
									$("#email").focus();
									return false;

								} else if (!$regex.test(idR)) {
									alert("특수문자/숫자/문자 포함 형태의 8~15자리 이내의 암호 형태를 입력해 주세요.");
									return false;

								} else {
									e.preventDefault();
									whichButton = "modify-button";
									oldPasswordModal.modal('show');
								}
							});

			// 패스워드 일치 확인
			$("#member-info-input2, #member-info-input4").keyup(
					function() {
						var pw1 = $("#member-info-input2").val();
						var pw2 = $("#member-info-input4").val();
						var modifyBtn = $("#member-info-modify-btn1");

						if ((pw1 != pw2)) {
							modifyBtn.attr("disabled", "disabled");
							$("#member-info-password-message").text(
									"패스워드가 일치하지 않습니다.");
						} else {
							if (pw1 == "") {
								modifyBtn.attr("disabled", "disabled");
								$("#member-info-password-message").text(
										"패스워드를 입력해주세요.");
							} else {
								modifyBtn.removeAttr("disabled");
								$("#member-info-password-message").empty();
							}
						}
					});

			//탈퇴 기능
			$("#btn-remove").click(function() {
				var ans = confirm("탈퇴 하시겠습니까?");
				whichButton = "remove-button";

				if (ans) {
					oldPasswordModal.modal('show');
				}
				/*
				$("#member-form")
					.attr("action","${appRoot}/member/remove")
					.submit();
				 */
			})
		});
	</script>
	 <!-- 수정할 정보들 -->
	<div class="container">



		<div class="col align-self-center mt-3">
			<a href="${appRoot }/member/main"> <img
				src="${appRoot }/resources/image/others/brand_logo_300px.png"
				alt="...">
			</a>
		</div>
		<br> <br> <br> <br>
		<h1>내 정보수정</h1>

		<c:if test="${param.status == 'success' }">
			<div id="alert1" class="alert alert-primary" role="alert">회원
				정보를 수정하였습니다.</div>
		</c:if>

		<c:if test="${param.status == 'error' }">
			<div id="alert1" class="alert alert-danger" role="alert">회원 정보
				수정을 할 수 없습니다.</div>
		</c:if>

		<section id="container">
			<form id="member-form" action="${appRoot }/member/modify"
				method="post">
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">이름</label> <input
						value="${member.userName }" class="form-control" type="text"
						id="userName" name="userName" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">아이디</label> <input hidden
						class="form-control" value="${pinfo.member.userid}" readonly
						type="text" id="userId" name="userid" /> <input
						value="${pinfo.member.userid}" readonly class="form-control">
				</div>

				<div class="form-group has-feedback">
					<label class="control-label" for="userEmail">이메일주소</label> <input
						value="${member.userEmail}" class="form-control" type="text"
						id="userEmail" name="userEmail" />
				</div>

				<div class="form-group">
					<label class="control-label" for="member-info-input2">새
						패스워드</label>

					<div class="input-group">
						<input type="password" class="form-control"
							id="member-info-input2" name="userpw">
						<div class="input-group-append"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label" for="member-info-input4">새
						패스워드 확인</label> <input type="password" class="form-control"
						id="member-info-input4"> <small
						id="member-info-password-message" class="form-text text-danger"></small>
				</div>


				<div class="form-group has-feedback">
					<button class="btn btn-success" type="submit" id="btn-modify">정보
						수정</button>
					<button class="cencle btn btn-danger" type="button" id="btn-remove">회원
						탈퇴</button>
				</div>
			</form>
		</section>
</body>
</div>



<%-- 기존 패스워드 입력 모달 --%>
<div class="modal fade" id="old-password-modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fas fa-key"></i>
				</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span>&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<div class="form-group">
					<label class="label12" for="old-password-input">기존 패스워드를
						입력해주세요.</label> <input form="member-info-form1" name="oldPassword"
						type="password" class="form-control" id="old-password-input">
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">
					닫기</button>
				<button type="button" id="old-password-modal-btn"
					class="btn btn-warning">확인</button>
			</div>
		</div>
	</div>
</div>




</body>
</html>


