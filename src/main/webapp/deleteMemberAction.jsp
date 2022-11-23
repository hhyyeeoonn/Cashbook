<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@	page import = "util.*" %>

<%
	// C
	request.setCharacterEncoding("utf-8");
	String memberId=request.getParameter("memberId");
	String memberPw=request.getParameter("memberPw");
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	
	// M
	MemberDao memberDao = new MemberDao(); // C
	int deleteMember = memberDao.deleteMember(paramMember); // login이라는 메서드 자체가 M
	
	if(deleteMember == 1) { 
		session.invalidate();
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		System.out.println("탈퇴성공");
	} else {
		System.out.println("탈퇴실패");
	}
%>