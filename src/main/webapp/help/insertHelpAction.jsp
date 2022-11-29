<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.*" %>

<%
	//Controller
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	String helpMemo=request.getParameter("helpMemo");
	String memberId=request.getParameter("memberId");
	
	if(helpMemo == null || helpMemo.equals("")) {
		String msg=URLEncoder.encode("비어있는 문의글은 등록할 수 없습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/insertHelpList.jsp?msg="+msg);
		return;
	}
		System.out.println("insertHelpAction:문의글내용확인");
	
	Help help=new Help();
	help.setHelpMemo(helpMemo);
	help.setMemberId(memberId);
	
	// Model
	HelpDao helpDao=new HelpDao();
	int row=helpDao.insertHelpMemo(help);
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		System.out.println("insertHelpAction:새로운문의글추가완료");
	}
%>
