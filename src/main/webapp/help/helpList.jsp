<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<%
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId=loginMember.getMemberId();
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpList</title>
</head>
<body>
	<h1>QnA</h1>
	<div>
		<a href="<%=request.getContextPath()%>/help/insertHelpList.jsp">문의등록</a>
	</div>
	<table>
		<tr>
			<th>문의내용</th>
			<th>문의등록일</th>
			<th>답변내용</th>
			<th>답변등록일</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
		</tr>
		<%
			for(HashMap<String, Object> m:list) {
		%>
			<tr>
				<td><%=m.get("helpMemo")%></td>
				<td><%=m.get("helpCreatedate")%></td>
				<%	
					String createdate=null;
					String commentMemo=null;
					if(m.get("commentCreatedate") == null && m.get("commentMemo") == null && m.get("commentNo") == null) {
						createdate="-";
						commentMemo="답변 전";
					} else {
						createdate=(String)(m.get("commentCreatedate"));
						commentMemo=(String)(m.get("commentMemo"));
					}
				%>
						<td>&nbsp;&nbsp;<%=commentMemo%></td>
						<td><%=createdate%></td>
				<%
					if(m.get("commentCreatedate") == null && m.get("commentMemo") == null && m.get("commentNo") == null) {
				%>
						<td>
							<a href="<%=request.getContextPath()%>/help/updateHelpList.jsp?helpNo=<%=m.get("helpNo")%>">수정</a>
						</td>
						<td>
							<a href="<%=request.getContextPath()%>/help/deleteHelpList.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>
						</td>
				<%
					} else {
				%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
				<% 
					}
				%>
			</tr>
		<%
			}
		%>
	</table>
</body>
</html>