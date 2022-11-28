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
	
	request.setCharacterEncoding("utf-8");
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	
	
	//M
	NoticeDao noticeDao=new NoticeDao();
	String noticeMemo=noticeDao.selectOneNoticeList(noticeNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeList</title>
</head>
<body>
	<h2>공지사항 수정페이지</h2>
	<br>
	<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
		<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
		<table>
			<tr>
				<th>내용</th>
				<td>
					<input type="text" name="noticeMemo" value="<%=noticeMemo%>">
				</td>
			</tr>
		</table>
		<button type="submit">등록</button>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
	</form>
</body>
</html>