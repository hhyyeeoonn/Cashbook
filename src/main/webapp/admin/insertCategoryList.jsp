<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// Controller
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
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
		<div>
			categoryKind :&nbsp;
			<input type="radio" name="categoryKind" value="수입">수입
			<input type="radio" name="categoryKind" value="지출">지출
		</div>
		<div>
			categoryName :&nbsp;
			<input type="text" name="categoryName">
		</div>
		<button type="submit">새카테고리 입력</button>
		<%
			if((request.getParameter("msg")) != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
			
			if((request.getParameter("NmMsg")) != null) {
		%>
				<%=request.getParameter("NmMsg")%>
		<%
			}
		%>
	</form>
</body>
</html>