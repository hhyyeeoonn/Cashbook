<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	//Controller : session, request
	if(session.getAttribute("loginMember") == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/updateMemberAction.jsp">
		<table class="table table-borderless">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="memberName" value="<%=loginMember.getMemberName()%>"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="text" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-secondary">회원정보 수정</button>
		<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
	</form>
	<%
		if(request.getParameter("msg") != null) {
	%>
			<%=request.getParameter("msg")%>
	<%
		}
	%>
</body>
</html>