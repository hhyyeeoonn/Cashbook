<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입</h2>
		<form action="<%=request.getContextPath()%>/insertLoginAction.jsp" method="post">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="id">
					<%
						if((request.getParameter("idMsg")) != null) {
					%>	
							<%=request.getParameter("idMsg")%>
					<%
						}
					%>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name"></td>
					
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pw"></td>
				</tr>
			</table>
			<button type="submit">가입</button>
		</form>
</body>
</html>