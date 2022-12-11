<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember);
	
	if((loginMember.getMemberId()) == null) { // 로그인 되지 않은 상태
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
	}		
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteMemberForm</title>
</head>
<body>
	<h2>회원탈퇴</h2>
	<div>아이디와 비밀번호를 입력하세요</div>
	<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
		<div>
			<input type="text" name="memberId">
		</div>
		<div>
			<input type="password" name="memberPw">
		</div>
		<button type="submit" class="btn btn-primary">회원탈퇴</button>
	</form>
</body>
</html>