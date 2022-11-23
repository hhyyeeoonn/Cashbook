<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
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