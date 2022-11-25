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
	
	int currentPage=1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	
	
	// Model 호출 : notice list
	int rowPerPage=10;
	int beginRow=(currentPage-1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); // 출력될 페이지내용들
	int noticeLastPage = noticeDao.selectNoticeCount(rowPerPage); // -> lastPage 
	
	
	// 최근 공지 5개, 최근 멤버 5명
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
</head>
<body>
	<ul>
		<li>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">회원관리</a>
		</li>
	</ul>
	
	<!--  noticeList contents -->
	<div>
		<h1>공지</h1>
	</div>
	<div>
		<table>
			<tr>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n:list) {
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/admin.jsp">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/admin.jsp">삭제</a></td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
	
	<!-- 페이징 -->
	<div>
		<span>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
		</span>
		<span><%=currentPage%></span>
		<span>
			<%
				if(currentPage < noticeLastPage) { 
			%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>		
		</span>
		<span>
			<%
				if(currentPage < noticeLastPage) {
			%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>
			<%
				}
			%>
		</span>
	</div>
</body>
</html>