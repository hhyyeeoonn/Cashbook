<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Controller
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 관리자가 아닐 때
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertNoticeForm</title>
</head>
<body>
	<h2>새로운 공지사항 작성</h2>
	<br>
	<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
		<table>
			<tr>
				<th>내용</th>
				<td>
					<input type="text" name="noticeMemo">
				</td>
			</tr>
		</table>
		<button type="submit">등록</button>
		<%
			if((request.getParameter("msg")) != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
	</form>
</body>
</html>