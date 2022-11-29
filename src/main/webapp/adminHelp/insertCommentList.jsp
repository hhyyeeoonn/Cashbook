<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
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
	int helpNo=Integer.parseInt(request.getParameter("helpNo"));
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>답변등록</h3>
	<form action="<%=request.getContextPath()%>/adminHelp/insertCommentAction.jsp?helpNo=<%=helpNo%>" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table>
			<tr>
				<th>답변내용</th>
			</tr>
			<tr>
				<td>
					<textarea rows="10" cols="50" name="commentMemo"></textarea>
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