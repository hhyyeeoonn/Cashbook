<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println("insertDiary:session확인");
	
	if((loginMember.getMemberId()) == null) { // 로그인 되지 않은 상태
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
	<form action = "<%=request.getContextPath()%>/diary/insertDiaryAction.jsp" method = "post">
		<input type = "hidden" name = "memberId" value = "<%=loginMember.getMemberId()%>">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type = "text" name = "title">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name = "memo"></textarea>
				</td>
			</tr>
		</table>
		<button type = "submit">등록</button>
	</form>
</body>
</html>