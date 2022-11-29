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
	
	int rowPerPage=10;
	int beginRow=(currentPage-1) * rowPerPage;
	HelpDao helpDao=new HelpDao();
	ArrayList<HashMap<String, Object>> list=helpDao.selectHelpList(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpListAll</title>
</head>
<body>
	<!-- header include -->
	<ul>
		<li>
			<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원관리</a>
		</li>
	</ul>
	
	<!-- QnA 문의 목록 -->
	<table>
		<tr>
			<th>문의내용</th>
			<th>회원ID</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>답변수정/삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m:list) {
		%>
				<tr>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("memberId")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<%
						String memo=null;
						String createdate=null;
						if(m.get("commentMemo") == null && m.get("commentCreatedate") == null) {
							memo="답변등록 전";
							createdate="-";
					%>
							<td><%=memo%></td>
							<td><%=createdate%></td>
							<td>
								<a href="<%=request.getContextPath()%>/adminHelp/insertCommentList.jsp?helpNo=<%=m.get("helpNo")%>">답변입력</a>	
							</td>
					<%
						} else {
							memo=(String)(m.get("commentMemo"));
							createdate=(String)(m.get("commentCreatedate"));
					%>
							<td><%=memo%></td>
							<td><%=createdate%></td>
							<td>
								<a href="<%=request.getContextPath()%>/adminHelp/updateCommentList.jsp?helpNo=<%=m.get("helpNo")%>&commentNo=<%=m.get("commentNo")%>">답변수정</a>
								&nbsp;/&nbsp;
								<a href="<%=request.getContextPath()%>/adminHelp/deleteCommentList.jsp?helpNo=<%=m.get("helpNo")%>&commentNo=<%=m.get("commentNo")%>">답변삭제</a>
							</td>
					<%
						}
					%>
				</tr>
		<%
			}
		%>
	</table>
	<!-- footer include -->
</body>
</html>