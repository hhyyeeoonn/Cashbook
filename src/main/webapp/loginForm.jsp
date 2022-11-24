<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	int currentPage=1;
	if(request.getParameter("currentPage") != null) {
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage=5;
	int beginRow=(currentPage - 1) * rowPerPage;
	// int lastPage=0;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<!-- 공지(5개) 페이징 -->
	<div>
		<table>
			<tr>
				<th>공지내용</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n: list) {
			%>
				<tr>
					<td><%=n.getNoticeMemo()%></td>
					<td><%=n.getCreatedate()%></td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
	
	<!-- 로그인폼 -->
	<h1>로그인</h1>
	<form action="<%=request.getContextPath()%>/loginAction.jsp">
		<table class="table table-borderless">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-secondary">로그인</button>
		<%
			if(request.getParameter("loginMsg") != null) {
		%>
				<%=request.getParameter("loginMsg")%>
		<%
			}
		
			if(request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
	</form>
	<div>
		<a href="<%=request.getContextPath()%>/insertLoginForm.jsp">회원가입</a>
	</div>
</body>
</html>