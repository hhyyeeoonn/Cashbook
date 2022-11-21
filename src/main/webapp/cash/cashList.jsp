<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

<%
	// Controller : session, request
	// request 년 + 월
	int year = 0; 
	int month = 0;
	
	if ((request.getParameter("year") == null) || (request.getParameter("month")) == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH); // 우리가 생각하는 달보다 1 작다
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12일 경우
		if (month == -1) {
			month = 11;
			year -= 1;	
		}
		if(month == 12) {
			month = 0;
			year += 1;
		}
	}

	// 출력하고자 하는 연도와 달과 그 달 1일의 요일 (일=1, 월=2, 화=3,...,토=7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);
	// beginBlank 개수는 firstDat-1
	
	// 마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);	
	
	// 달력 출력 테이블의 시작 공백셀(td)과 마지막 공백섹(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // 7로 나누어 떨어진다 /beginBlank + lastDate + endBlank = 7
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank; 
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month+1);

	// View : 달력 출력 + 일별 cash 목록 출력
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
</head>
<body>
	<div>
		<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
	</div>
	
	<div>
		<%=year%>년 <%=month + 1%> 월 
	</div>
	<div>
		<!-- 달력 -->
		<table border=1>
			<tr>
				<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
			</tr>
			<tr>
		<%
			for (int i=1; i<totalTd; i++) {
		%>
				<td>
		<%
					int date = i-beginBlank;
					if(date > 0 && date <= lastDate) {
		%>
					<%=date %>
		<%
				}
		%>
				</td>
		<% 
				if(i % 7 == 0 && i != totalTd) {
		%>
				</tr><tr> <!-- td 7개 만들고 테이블 줄바꿈 -->
		<%
				}
			}
		%>
			</tr>
		</table>
	</div>
	<div>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<%=(Integer)m.get("cashNo") %>
		<%
			}
		%>
	</div>

</body>
</html>