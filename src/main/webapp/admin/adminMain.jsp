<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
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
	
	int currentPage=1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	
	// Model 호출
	int rowPerPage=5;
	int beginRow=(currentPage-1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); // 출력될 페이지내용들
	int noticeLastPage = noticeDao.selectNoticeCount(rowPerPage); // -> lastPage 
	
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList=memberDao.selectMemberlistByPage(beginRow, rowPerPage);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
</head>
<body>
	<div>
	
	<!-- 최근 알림사항 -->
		<div>
			<table style="float:left;">
				<tr>
					<th>최근 공지사항</th>
				</tr>
				<%
					for(Notice n:list) {
				%>
					<tr>
						<td>
							<%=n.getNoticeMemo()%>
						</td>
					</tr>
				<%
					}
				%>
			</table>
			<table>
				<tr>
					<th>새로운 회원</th>
				</tr>
				<%
					for(Member m:memberList) {
				%>
					<tr>
						<td>
							<%=m.getMemberId()%> <%=m.getMemberName()%> <%=m.getCreatedate()%>
						</td>
					</tr>
				<%
					}
				%>
			</table>
		</div>
	<!-- 목록표 -->
		<table>
			<tr>
				<th colspan="3">관리자메뉴</th>
			</tr>
			<tr>
				<td>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원관리</a>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a>
				</td>
			</tr>
			<tr>
				<th colspan="3">개인메뉴</th>
			</tr>
			<tr>
				<td>
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp">내 가계부</a>
				</td>
			</tr>
		</table>
</body>
</html>