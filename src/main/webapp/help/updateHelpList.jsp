<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	//Controller
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	int helpNo=Integer.parseInt(request.getParameter("helpNo"));
	
	HelpDao helpDao=new HelpDao();
	ArrayList<HashMap<String, Object>> list=helpDao.selectHelpList(helpNo);
	Help help=new Help();
	for(HashMap<String, Object> h:list) {
		help.setMemberId((String)(h.get("memberId")));
		help.setHelpMemo((String)(h.get("helpMemo")));
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>문의수정</h3>
	<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp?helpNo=<%=helpNo%>" method="post">
		<input type="hidden" name="memberId" value="<%=help.getMemberId()%>">
		<table>
			<tr>
				<th>문의내용</th>
			</tr>
			<tr>
				<td>
					<textarea rows="10" cols="50" name="helpMemo"><%=help.getHelpMemo()%></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정등록</button>
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