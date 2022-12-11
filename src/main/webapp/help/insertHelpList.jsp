<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	//Controller
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
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
	<h3>문의등록</h3>
	<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table>
			<tr>
				<th>문의내용</th>
			</tr>
			<tr>
				<td>
					<textarea rows="10" cols="50" name="helpMemo">내용입력</textarea>
				</td>
			</tr>
		</table>
		<button type="submit" class="btn btn-primary">등록</button>
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