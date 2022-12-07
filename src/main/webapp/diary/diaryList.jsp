<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//Controller : session, request
	if(session.getAttribute("loginMember") == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println(loginMember);

	
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
	
	
	// Model 호출 
	DiaryDao diaryDao = new DiaryDao();
	ArrayList<HashMap<String, Object>> list = diaryDao.selectDiaryListByMonth(loginMember.getMemberId(), year, month+1);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<meta name='viewport' content='width=device-width, initial-scale=1'>
	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

</head>
<body>
	<div>
		<a href="<%=request.getContextPath()%>/diary/diaryList.jsp?year=<%=year%>&month=<%=month-1%>">[< 이전달]</a>
		<%=year%>년 <%=month + 1%>월 
		<a href="<%=request.getContextPath()%>/diary/diaryList.jsp?year=<%=year%>&month=<%=month+1%>">[다음달 >]</a>
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
							<div><%=date%></div>
							<br>
			<%
								for(HashMap<String, Object> m : list) { 
									int diaryNo = (Integer)(m.get("diaryNo"));
									String diaryDate=(String)(m.get("diaryDate"));
									if(Integer.parseInt(diaryDate.substring(8)) == date) {
										if(diaryNo != 0) {
			%>
											<div>
												<a href="<%=request.getContextPath()%>/diary/diaryDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
													<button style='font-size:20px'><i class='fas fa-book'></i></button>	
												</a>
											</div>
											<br>
																	
			<% 
										}
									} else {
			%>
										<div>
											<a href = "<%=request.getContextPath()%>/diary/insertDiary.jsp">
												<button style='font-size:20px'><i class='fas fa-pencil-alt'></i></button>
											</a>
										</div>
										<br>
			<%
									
									}
								}
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
</body>
</html>