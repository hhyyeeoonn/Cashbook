<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import = "util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>

<!-- 회원가입 로그인 로그아웃 -->
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String pw=request.getParameter("pw");
	
	
	if((id == null) || (id.equals("")) || (name == null) || (name.equals("")) || (pw == null) || (pw.equals(""))) {
		String msg=URLEncoder.encode("빈칸에 내용을 입력하십시오.", "utf-8"); 
		response.sendRedirect(request.getContextPath() + "/insertLoginForm.jsp?msg="+msg);
		return;
	}
		System.out.println("빈칸 확인");
	
	Member paramMember = new Member();
	paramMember.setMemberId(id);
	paramMember.setMemberPw(pw);
	paramMember.setMemberName(name);
		
	// 중복확인
	MemberDao failMember = new MemberDao();
	String targetUrl = failMember.failLogin(paramMember);
	
	if(targetUrl != null) {
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}
		System.out.println("아이디 중복확인 완료");
		
	// 가입확인
	MemberDao newbie = new MemberDao();
	int row = newbie.insertMember(paramMember);
	
	if(row == 1) {
		String loginMsg=URLEncoder.encode("가입을 환영합니다. 로그인 하십시오.", "utf-8");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?loginMsg="+loginMsg);
		System.out.println("가입성공");
	} else {
		System.out.println("가입실패");
	}
%>
