<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	//
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 관리자가 아닐 때
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	
	
	// M
	// 공지 삭제
	NoticeDao noticeDao=new NoticeDao();
	int row=noticeDao.deleteNotice(noticeNo);
	if(row == 1) {
		System.out.println("deleteNoticeList:공지삭제완료");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
	}
%>