<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
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
	request.setCharacterEncoding("utf-8");
	int helpNo=Integer.parseInt(request.getParameter("helpNo"));
	int commentNo=Integer.parseInt(request.getParameter("commentNo"));
	
	Comment comment=new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentNo(commentNo);
		System.out.println("deleteCommentList:정보확인");
		
	// 답변삭제
	CommentDao commentDao=new CommentDao();
	
	int row=commentDao.deleteComment(comment);
	if(row == 1) {
		System.out.println("deleteCommentList:답변삭제완료");
		response.sendRedirect(request.getContextPath()+"/adminHelp/helpListAll.jsp");
	}
%>