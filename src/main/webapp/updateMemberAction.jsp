<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import = "util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	// C
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if((loginMember.getMemberId()) == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	String memberId=request.getParameter("memberId");
	String memberPw=request.getParameter("memberPw");
	String memberName=request.getParameter("memberName");
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberName(memberName);
	
	
	// M
	MemberDao updateMember = new MemberDao();
	int row = updateMember.updateMember(loginMember, paramMember);
	// 수정확인 및 cashList로 보내기
	if(row==1) { 
		session.setAttribute("loginMember", loginMember);
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		System.out.println("수정성공");
	} else {
		String msg=URLEncoder.encode("wrong", "utf-8");
		response.sendRedirect(request.getContextPath() + "/updateMemberForm.jsp?msg="+msg);
		System.out.println("수정실패");
	}
%>