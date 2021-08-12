<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="pinfo" scope="request" />
</sec:authorize>

<!-- 구독 신청 버튼 권한 부여 -->
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
				if (confirmID == "") {
					$("#main-subscribe").show();
				}
			},
			error : function() {
				console.log("실패")
			}
		})
	})
</script>


<div class="container">
	<nav
		class="navbar fixed-top navbar-expand-lg navbar-light justify-content-end"
		style="background-color: white;">
		<a id="main-subscribe" style="display: none;" class="navbar-brand"
			href="${appRoot }/subscribe/subsregister"">구독하기</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarScroll" aria-controls="navbarScroll"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse flex-grow-0  navbar-collapse justify-content-end"
			id="navbarScroll">
			<ul class="navbar-nav my-2 my-lg-0 navbar-nav-scroll"
				style="max-height: 1000px;">
				<li class="nav-item active"><a class="nav-link"
					href="${appRoot }/member/main">Main <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item active"><a class="nav-link"
					href="${appRoot }/help/helpdesk">고객센터 <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item active"><a class="nav-link"
					href="${appRoot }/help/ask">1:1 문의 <span class="sr-only">(current)</span></a>
				</li>
				<sec:authorize access="isAuthenticated()">
					<li class="nav-item active"><a class="nav-link"
						href="${appRoot }/logout">Logout<span class="sr-only">(current)</span></a>
					</li>
				</sec:authorize>
				<sec:authorize access="!isAuthenticated()">
					<li class="nav-item active"><a class="nav-link"
						href="${appRoot }/member/login">Login<span class="sr-only">(current)</span></a>
					</li>
				</sec:authorize>
			</ul>
		</div>
	</nav>
</div>
