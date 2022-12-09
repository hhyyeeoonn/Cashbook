<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println("insertDiary:session확인");
	
	if(loginMember == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	
	
	request.setCharacterEncoding("utf-8");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = request.getParameter("date");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "<%=request.getContextPath()%>/diary/insertDiaryAction.jsp" method = "post">
		<input type = "hidden" name = "memberId" value = "<%=loginMember.getMemberId()%>">
		<table>
			<tr>
				<td>
					<input type = "hidden" name="diaryDate" value="<%=year%>-<%=month%>-<%=date%>">
					<%=year%>년 <%=month%>월 <%=date%>일
				</td>
			</tr>
			<tr>
				<td>
					<textarea name = "memo"></textarea>
				</td>
			</tr>
		</table>
		<button type = "submit">등록</button>
		&nbsp;&nbsp;&nbsp;
		<a href = "<%=request.getContextPath()%>/diary/diaryList.jsp">
		<button type = "button">달력으로</button>
		</a>
	</form>
	
</body>
</html>