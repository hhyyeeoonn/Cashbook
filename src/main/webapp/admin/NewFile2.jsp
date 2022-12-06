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
	

	// Model 호출
	CategoryDao categoryDao=new CategoryDao();
	ArrayList<Category> categoryList=categoryDao.selectCategoryListByAdmin();
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
			<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원관리</a>
			<a href="">QnA</a>
		</li>
	</ul>
	
	<!-- categoryList contents... -->
	<div>
		<h1>카테고리 목록</h1>
		<br>
		<div>
			<a href="<%=request.getContextPath()%>/admin/insertCategoryList.jsp">카테고리 추가</a>
		</div>
		<table>
			<tr>
				<th>수입/지출</th>
				<th>이름</th>	
				<th>마지막 수정날짜</th>
				<th>생성날짜</th>
				<th></th>	
				<th></th>		
			</tr>
			<%
				for(Category c:categoryList) {
			%>
				<tr>
					<td><%=c.getCategoryKind()%></td>
					<td><%=c.getCategoryName()%></td>
					<td><%=c.getUpdatedate()%></td>
					<td><%=c.getCreatedate()%></td>
					<td>
						<a href="<%=request.getContextPath()%>/admin/updateCategoryList.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a>
					</td>
					<td>
						<a href="<%=request.getContextPath()%>/admin/deleteCategoryList.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a>
					</td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>