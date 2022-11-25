<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@	page import = "util.*" %>

<%
	// C
	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println(loginMember);
	
	if((loginMember.getMemberId()) == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}		
	
	request.setCharacterEncoding("utf-8");
	String memberId=request.getParameter("memberId");
	String memberPw=request.getParameter("memberPw");
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	
	// M
	MemberDao memberDao = new MemberDao(); // C
	int deleteMember = memberDao.deleteMember(loginMember, paramMember); // login이라는 메서드 자체가 M
	
	if(deleteMember == 1) { 
		session.invalidate();
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		System.out.println("탈퇴성공");
	} else {
		System.out.println("탈퇴실패");
	}
%>