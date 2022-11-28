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
	
	request.setCharacterEncoding("utf-8");
	int categoryNo=Integer.parseInt(request.getParameter("categoryNo"));
	
	
	// M
	CategoryDao categoryDao=new CategoryDao();
	Category category=categoryDao.selectCategoryOne(categoryNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp?categoryNo=<%=categoryNo%>" method="post">
		<div>
			categoryKind :&nbsp;
			<%
				if((category.getCategoryKind()) == "수입" || (category.getCategoryKind()).equals("수입")) {
			%>
					<input type="radio" name="categoryKind" value="수입" checked onclick="return(false);"><label>수입</label>
					<input type="radio" name="categoryKind" value="지출" onclick="return(false);"><label>지출</label>
			<%
				} else {
			%>
					<input type="radio" name="categoryKind" value="수입" onclick="return(false);"><label>수입</label>
					<input type="radio" name="categoryKind" value="지출" checked onclick="return(false);"><label>지출</label>
			<%
				}
			%>
		</div>
		<div>
			categoryName :&nbsp;
			<input type="text" name="categoryName" value="<%=category.getCategoryName()%>">
		</div>
		<button type="submit">카테고리 수정</button>
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