<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import = "util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	// C
	request.setCharacterEncoding("utf-8");
	String memberId=request.getParameter("memberId");
	String memberPw=request.getParameter("memberPw");
	String memberName=request.getParameter("memberName");
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberName(memberName);
	
	
	// 수정 확인
	MemberDao updateMember = new MemberDao();
	int row = updateMember.updateMember(paramMember);
	
	if(row==1) { 
		session.setAttribute("loginMember", paramMember);
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		System.out.println("수정성공");
	} else {
		System.out.println("수정실패");
	}
%>