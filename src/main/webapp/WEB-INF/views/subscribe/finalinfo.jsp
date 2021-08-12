<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sub" tagdir="/WEB-INF/tags/subscribe" %>
<!DOCTYPE html>
<html>
<head>

<link href="${appRoot }/resources/favicon/brand_logo.png" rel="shortcut icon" type="image/x-icon">

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Subscription Information File</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Prata&display=swap" rel="stylesheet">

<style TYPE="text/css">
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

#logo {
	padding: 50px;
}

body {
	scrollbar-face-color: #F6F6F6;
	scrollbar-highlight-color: #bbbbbb;
	scrollbar-3dlight-color: #FFFFFF;
	scrollbar-shadow-color: #bbbbbb;
	scrollbar-darkshadow-color: #FFFFFF;
	scrollbar-track-color: #FFFFFF;
	scrollbar-arrow-color: #bbbbbb;
	margin-left: "0px";
	margin-right: "0px";
	margin-top: "0px";
	margin-bottom: "0px";
}

td {
	font-size: 9pt;
	color: #595959;
}

th {
	font-size: 9pt;
	color: #000000;
}

select {
	font-size: 9pt;
	color: #595959;
}

.divDotText {
	overflow: hidden;
	text-overflow: ellipsis;
}

A:link {
	font-size: 9pt;
	color: #000000;
	text-decoration: none;
}

A:visited {
	font-size: 9pt;
	color: #000000;
	text-decoration: none;
}

A:active {
	font-size: 9pt;
	color: red;
	text-decoration: none;
}

A:hover {
	font-size: 9pt;
	color: red;
	text-decoration: none;
}

.day {
	width: 100px;
	height: 30px;
	font-weight: bold;
	font-size: 15px;
	font-weight: bold;
	text-align: center;
}

.sat {
	color: #529dbc;
}

.sun {
	color: red;
}

.today_button_div {
	float: right;
}

.today_button {
	width: 100px;
	height: 30px;
}

.calendar {
	width: 80%;
	margin: auto;
}

.navigation {
	margin-top: 100px;
	margin-bottom: 30px;
	text-align: center;
	font-size: 25px;
	vertical-align: middle;
}

.calendar_body {
	width: 100%;
	background-color: #FFFFFF;
	border: 1px solid white;
	margin-bottom: 50px;
	border-collapse: collapse;
}

.calendar_body .today {
	border: 1px solid white;
	height: 120px;
	background-color: #88c9f2;
	text-align: left;
	vertical-align: top;
}

.calendar_body .date {
	font-weight: bold;
	font-size: 15px;
	padding-left: 3px;
	padding-top: 3px;
}

.calendar_body .sat_day {
	border: 1px solid white;
	height: 120px;
	background-color: #EFEFEF;
	text-align: left;
	vertical-align: top;
}

.calendar_body .sat_day .sat {
	color: #529dbc;
	font-weight: bold;
	font-size: 15px;
	padding-left: 3px;
	padding-top: 3px;
}

.calendar_body .sun_day {
	border: 1px solid white;
	height: 120px;
	background-color: #EFEFEF;
	text-align: left;
	vertical-align: top;
}

.calendar_body .sun_day .sun {
	color: red;
	font-weight: bold;
	font-size: 15px;
	padding-left: 3px;
	padding-top: 3px;
}

.calendar_body .normal_day {
	border: 1px solid white;
	height: 120px;
	background-color: #EFEFEF;
	vertical-align: top;
	text-align: left;
}

.before_after_month {
	margin: 10px;
	font-weight: bold;
}

.before_after_year {
	font-weight: bold;
}

.this_month {
	margin: 10px;
}

.subdate, .normal_day.subdate {
	text-decoration: underline;
	background-color: #FFC0D5;
}

.shadow-container {
	box-shadow: 5px 3px 20px gray;
}
.jinah-layout {
	box-shadow: 1px 1px 20px #A3A3A3;
	padding-top: 30px;
	padding-bottom: 50px;
	margin-top: 50px;
	margin-bottom: 10px;
}

li {
	font-family: 'Prata', serif;
	font-size: 22px;
	line-height: 2;
}

</style>
<!-- script src="${appRoot }/resources/js/subscribe/subscribe-calendar.js" -->
</head>
<body>
	
	<!-- 상위 내비게이션 -->
	<sub:navbar></sub:navbar>
	
	<div class="container">
		
	
		<div class="container">
			<div class="row justify-content-center">
				<a href="${appRoot }/member/main"> <img id="logo" alt="jinah-logo"
					src="${appRoot }/resources/image/others/brand_logo_400px.png">
				</a>
			</div>
			<br><br>
			<div class="row justify-content-center">
				<span style="font-size: 30px; background-color: #EBEEFF;">스케줄 설계 완료</span>
			</div>
		</div>

	<div class="jinah-layout">
			<form name="calendarFrm" id="calendarFrm" action="" method="GET">

			<div class="calendar">
				<!--날짜 네비게이션  -->
				<div class="navigation">
					<a class="before_after_year"
						href="${appRoot }/subscribe/finalinfo?year=${today_info.search_year - 1}&month=${today_info.search_month - 1}">
						&lt;&lt; <!-- 이전해 -->
					</a> <a class="before_after_month"
						href="${appRoot }/subscribe/finalinfo?year=${today_info.before_year}&month=${today_info.before_month}">
						&lt; <!-- 이전달 -->
					</a> <span class="this_month"> &nbsp;${today_info.search_year}.
						<c:if test="${today_info.search_month < 10}">0</c:if>${today_info.search_month}
					</span> <a class="before_after_month"
						href="${appRoot }/subscribe/finalinfo?year=${today_info.after_year}&month=${today_info.after_month}">
						<!-- 다음달 --> &gt;
					</a> <a class="before_after_year"
						href="${appRoot }/subscribe/finalinfo?year=${today_info.search_year + 1}&month=${today_info.search_month - 1}">
						<!-- 다음해 --> &gt;&gt;
					</a>
				</div>

				<!-- <div class="today_button_div"> -->
				<!-- <input type="button" class="today_button" onclick="javascript:location.href='/calendar.do'" value="go today"/> -->
				<!-- </div> -->
				<div class="shadow-container">
				<table class="calendar_body">

					<thead>
						<tr bgcolor="#0583f2">
							<td class="day sun">일</td>
							<td style="color: white;" class="day">월</td>
							<td style="color: white;" class="day">화</td>
							<td style="color: white;" class="day">수</td>
							<td style="color: white;" class="day">목</td>
							<td style="color: white;" class="day">금</td>
							<td style="color: white;" class="day sat">토</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<c:forEach var="dateList" items="${dateList}"
								varStatus="date_status">
								<c:choose>
									<c:when test="${dateList.value =='today'}">
										<td class="today">
											<div id="today" value="${dateList.date }" class="date">${dateList.date}</div>
											<div></div>
										</td>
									</c:when>
									<c:when test="${date_status.index % 7 == 6}">
										<td class="sat_day">
											<div class="sat datelist-date">${dateList.date}</div>
											<div></div>
										</td>
									</c:when>
									<c:when test="${date_status.index % 7 == 0}">
										<td class="sun_day">
											<div class="sun datelist-date">${dateList.date}</div>
											<div></div>
										</td>
									</c:when>
									<c:otherwise>
										<td
											id="normal-day"
											class="normal_day 
												<c:if test='${subDateList.contains(dateList.fullDate)}'>
												  subdate
												</c:if>		
											">
											<div
												class="date
												<c:if test='${subDateList.contains(dateList.fullDate)}'>
												  subdate
												</c:if>
											
											">${dateList.date}</div>
											<input hidden class="datelist-date" value="${dateList.date }">
									</c:otherwise>
								</c:choose>
								<c:if test="${date_status.index% 7 == 6}">
								<%-- 토요일에 tr 끝 --%>
						</tr>
						<tr>
							</c:if>
							</c:forEach>
						</tr>
				</table>
				</div>

				<div style="margin: 30px; font-size: 20px;" class="row justify-content-center">
					<div class="col sub-date-list">
					<ul style="font-family: 'Abril Fatface', cursive;">
						<c:forEach var="subDate" items="${subDateList }" varStatus="status">
								<li>${subDate }</li>
								
							<c:if test="${Math.floor(fn:length(subDateList) / 2 -1 ) == status.index }"	>
								</ul>
								</div> 
								<div class="col">
								<ul>
							</c:if>
								
						</c:forEach>
					</div>
					</ul>
				</div>
			</div>
		</form>
	</div>
</div>

 <script type="text/javascript">
$(function() {
	$.ajax({
		type : "POST",
		url : "${appRoot}/subscribe/ABCD" ,
		data : { userid : "${pinfo.member.userid}"},
		success : function(data) {
			console.log(data);
			$("#sub-input1").val(data.subsName);
			$("#sub-input2").val(data.subsAddress);
			$("#sub-input3").val(data.userPhonenum);
			$("#sub-input4").val(data.userNickname);
			$("#sub-input5").val(data.subsAmount);
			$("#sub-input6").val(data.subsOptions);
			$("#sub-input7").val(data.storename);
			$("#sub-input8").val(data.storeaddress);
			$("#sub-input9").val(data.storePhonenum);
			
		},
		error : function() {
			console.log("실패");
		}
	})
})
</script>   
		<br>	
		<hr>
		<!-- 구독회원의 구독 최종 결과 정보 -->
		<div id="re-write-content" class="container">
			<div class="row justify-content-center">
				<div class="col-8">
						<span style="font-size: 30px; background-color: #EBEEFF;">상세 이용 정보</span>
						<form id="finalSubsInfo" action="${appRoot}/subscribe/finalinfo" method="get">
							<!-- data : userid -->
							<input type="hidden" name="userid" value="${pinfo.member.userid }"  readonly>
						</form>
						<div style="margin-top: 30px;" class="item form-group">
							<label for="sub-input1">이름</label> 
							<input id="sub-input1" class="form-control" readonly>
						</div>
						
						<div class="item form-group">
							<label for="sub-input2">나의 주소</label> 
							<input id="sub-input2" class="form-control" readonly>
						</div>
						
						<div class="item form-group">
							<label for="sub-input3">연락처</label> 
							<input id="sub-input3" class="form-control"  readonly>
						</div>
						
						<div class="item form-group">
							<label for="sub-input4">닉네임</label> 
							<input id="sub-input4" class="form-control"  readonly>
						</div>
						
						
						<hr><br>
						
						<!-- 결제 금액 -->
					<!-- subsAmount -->
						<div class="item form-group">
							<label for="sub-inpu5">결제 금액</label> 
							<input id="sub-input5" class="form-control" readonly>
						</div>
						
						<!-- 결제 옵션 -->
						<div class="item form-group">
							<label for="sub-input6">선택한 구독 옵션</label> 
							<input id="sub-input6" class="form-control" readonly>
						</div>
						<hr><br>
						<!-- 이용한 세탁소 위치 정보 -->
						<div class="item form-group">
							<label for="sub-input7">구독 세탁소 이름</label> 
							<input id="sub-input7" class="form-control"  readonly>
						</div>
						
						<div class="item form-group">
							<label for="sub-input8">구독 세탁소 주소</label> 
							<input id="sub-input8" class="form-control"  readonly>
						</div>
						
						<div class="item form-group">
							<label for="sub-input9">구독 세탁소 연락처</label> 
							<input id="sub-input9" class="form-control" readonly>
						</div>
						
				</div>
			</div>
		</div>
</body>
</html>