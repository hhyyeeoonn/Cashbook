<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

<%
	// Controller : session, request
	if(session.getAttribute("loginMember") == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// session안에 저장된 멤버(현재 로그인 사용자) 
	Member loginMember = (Member)session.getAttribute("loginMember");
	
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
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	// View : 달력 출력 + 일별 cash 목록 출력
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
</head>
<body>

	<!-- 회원정보 -->
	<div>
		<h4><%=loginMember.getMemberName()%>(<%=loginMember.getMemberId()%>)님 반갑습니다.</h4>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">회원정보수정</a>
			<%
				if(loginMember.getMemberLevel() > 0) {
			%>
				<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
			<%
				}
			%>
		<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	</div>
	<br>
	
	<!-- 달력 -->
	<div>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">[< 이전달]</a>
		<%=year%>년 <%=month + 1%>월 
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">[다음달 >]</a>
	</div>
	<div>
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
					<div>
						<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>"><%=date%></a>
					</div>
					<div>
						<%
							for(HashMap<String, Object> m:list) {
								String cashDate=(String)(m.get("cashDate"));
								if(Integer.parseInt(cashDate.substring(8)) == date) {
						%>
									[<%=(String)(m.get("categoryKind"))%>]  <!-- object타입으로 들어가있어서 형변환필요 -->
									<%=(String)(m.get("categoryName"))%>
									&nbsp;
									<%=(Long)(m.get("cashPrice"))%>원
									<br>	
						<%
								}
							}
						}
							System.out.println(date);
						%>
					</div>
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
			<!-- integer는 int의 참조타입(래퍼클래스 박싱 언박싱) int는 기본타입--> 
		</table>
	</div>
</body>
</html>