<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import = "util.*" %>
<%@ page import = "java.sql.*" %>
<%//@ page import="java.net.*" %>

<!-- 회원가입 로그인 로그아웃 -->
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String pw=request.getParameter("pw");
	String pw2=request.getParameter("pw2");
	
	
	// 입력누락 확인
	if((id == null) || (id.equals("")) || (name == null) || (name.equals("")) || (pw == null) || (pw.equals("")) || (pw2 == null) || (pw2.equals(""))) {	
		//String msg=URLEncoder.encode("빈칸에 내용을 입력하십시오.", "utf-8"); 
		String msg = "insert";
		response.sendRedirect(request.getContextPath() + "/insertLoginForm.jsp?msg="+msg);
		return;
	}
		System.out.println("insertLoginAction:입력누락확인");
	
	if(!pw.equals(pw2)) {
		//System.out.println("insertLoginAction:pw:"+pw+"/Pw2:"+pw2);
		//String msg2=URLEncoder.encode("pw", "utf-8");
		String msg2 = "wrong";
		response.sendRedirect(request.getContextPath() + "/insertLoginForm.jsp?msg2="+msg2);
		return;	
	}
		System.out.println("insertLoginAction:비밀번호일치여부확인");
	
		
		
	
	Member paramMember = new Member();
	paramMember.setMemberId(id);
	paramMember.setMemberPw(pw);
	paramMember.setMemberName(name);
		
	// 중복확인
	MemberDao memberDao = new MemberDao(); // 한 번만 써도 됨... 
	String targetUrl = memberDao.failLogin(paramMember);
	
	if(targetUrl != null) {
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}
		System.out.println("아이디 중복확인 완료");
		
	// 가입확인
	int row = memberDao.insertMember(paramMember);
		System.out.println(row + "<<-insertMemberAction.jsp:row");
	
	if(row == 1) {
		//String loginMsg=URLEncoder.encode("가입을 환영합니다. 로그인 하십시오.", "utf-8");
		String loginMsg = "enter";
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?loginMsg="+loginMsg);
	} 
%>
