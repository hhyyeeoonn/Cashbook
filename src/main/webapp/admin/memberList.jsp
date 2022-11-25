<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

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
	
	
	// Model 호출
	MemberDao memberDao=new MemberDao();
	ArrayList<Member> selectMemberlistByPage(int beginRow, int rowPerPage)
	// 최근 공지 5개, 최근 멤버 5명
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
</head>
<body>
	<ul>
		<li>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">관리자페이지</a>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">공지관리</a>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a>
		</li>
	</ul>
	<div>
		<!-- memberList contents... -->
		<h1>회원목록</h1>
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막수정날짜</th>
				<th>생성일자</th>
				<th>레벨수정</th> <!-- memberNo로 membeLevel 수정 -->
				<th>강제탈퇴</th>
			</tr>
	</div>
</body>
</html>