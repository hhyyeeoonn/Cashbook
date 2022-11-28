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
	
	
	// Model 호출
	int rowPerPage=5;
	int beginRow=(currentPage-1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); // 출력될 페이지내용들
	int noticeLastPage = noticeDao.selectNoticeCount(rowPerPage); // -> lastPage 
	
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList=memberDao.selectMemberlistByPage(beginRow, rowPerPage);
	int memberLastPage=memberDao.selectMemberPageCount(rowPerPage);

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
			<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">공지관리</a>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a>
			<a href="">QnA</a>
		</li>
	</ul>
	
	<!-- memberList contents... -->
	<div>
		<h1>회원목록</h1>
			<br>
			<table>
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>레벨</th>
					<th>이름</th>
					<th>마지막수정날짜</th>
					<th>생성일자</th>
					<th></th> <!-- memberNo로 membeLevel 수정 -->
					<th></th>
				</tr>
				<%
					for(Member b:memberList) {
						String level="관리자";
						if((b.getMemberLevel()) == 0) {
							level="일반회원";
						}
				%>
						<tr>
							<td><%=b.getMemberNo()%></td>
							<td><%=b.getMemberId()%></td>
							<td><%=level%></td>
							<td><%=b.getMemberName()%></td>
							<td><%=b.getUpdatedate()%></td>
							<td><%=b.getCreatedate()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/updateMemberLevel.jsp?memberNo=<%=b.getMemberNo()%>">등급수정</a>
							</td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/deleteMemberList.jsp?memberNo=<%=b.getMemberNo()%>">회원추방</a>
							</td>
						</tr>
				<%
					}
				%>
			</table>
			<span>
			<%
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
		</span>
		<span><%=currentPage%></span>
		<span>
			<%
				if(currentPage < memberLastPage) { 
			%>
					<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>		
		</span>
		<span>
			<%
				if(currentPage < memberLastPage) {
			%>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=memberLastPage%>">마지막</a>
			<%
				}
			%>
		</span>
	</div>
</body>
</html>