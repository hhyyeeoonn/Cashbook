<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
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
	int categoryNo=Integer.parseInt(request.getParameter("categoryNo"));
	
	
	//
	CategoryDao categoryDao=new CategoryDao();
	int row=categoryDao.deleteCatory(categoryNo);
	if(row == 1) {
		System.out.println("deleteCategoryList:삭제성공");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
	}
%>