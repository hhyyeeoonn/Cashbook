<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
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
	
	// Model 호출
	

	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
</head>
<body>
	<ul>
		<li>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">회원관리</a>
		</li>
	</ul>
	<div>
		<!-- categoryList contents... -->
		<div>
			카테고리 추가
		</div>
		<div>
			카테고리 수정
		</div>
		<div>
			카테고리 삭제
		</div>
	</div>
</body>
</html>