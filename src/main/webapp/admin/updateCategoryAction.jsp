<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Controller
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 관리자가 아닐 때
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName=request.getParameter("categoryName");
	String categoryKind=request.getParameter("categoryKind");	
	
	Category category=new Category();
	category.setCategoryNo(categoryNo);
	category.setCategoryName(categoryName);
	category.setCategoryKind(categoryKind);
	
	
	// M
	CategoryDao categoryDao=new CategoryDao();
	String targetUrl=categoryDao.WrongCategory2(category);
	if(targetUrl != null) {
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}
		System.out.println("updateCategoryAction:카테고리중복확인완료");
	
	int row=categoryDao.updateCategoryName(category);
	if(row == 1) {
		System.out.println("updateCategoryAction:수정성공");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
	}
%>
