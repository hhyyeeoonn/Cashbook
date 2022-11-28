<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
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
	
	int memberNo=Integer.parseInt(request.getParameter("memberNo"));
	
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> theMemberList=memberDao.selectMember(memberNo);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>회원등급수정</div>
	<br>
	<div>	
		<form action="<%=request.getContextPath()%>/admin/updateMemberAction.jsp?memberNo=<%=memberNo%>" method="post">
			<table>
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>레벨</th>
					<th>이름</th>
					<th>마지막수정날짜</th>
					<th>생성일자</th>
				</tr>
				<%
					for(Member b:theMemberList) {
				%>
						<tr>
							<td><%=b.getMemberNo()%></td>
							<td><%=b.getMemberId()%></td>
							<td>
							<% 
								String level="관리자";
								String level2=null;
								if(b.getMemberLevel() == 0) {
									level="일반회원";
									level2="관리자";
								} else {
									level2="일반회원";
								}
							%>
								<select name="memberLevel">
									<option><%=level%></option>
									<option><%=level2%></option>
								</select>
							</td>
							<td><%=b.getMemberName()%></td>
							<td><%=b.getUpdatedate()%></td>
							<td><%=b.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</table>
			<button type="submit">회원등급수정</button>
		</form>
	</div>
</body>
</html>