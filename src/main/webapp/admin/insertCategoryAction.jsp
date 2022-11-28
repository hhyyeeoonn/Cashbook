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
	} else if(loginMember.getMemberLevel() < 1) { // 관리자가 아닐 때
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	String categoryName=request.getParameter("categoryName");
	String categoryKind=request.getParameter("categoryKind");
	/*
		System.out.println(categoryName);
		System.out.println(categoryKind);
	*/
	if((categoryName == null) || (categoryName.equals("")) || (categoryKind == null) || (categoryKind.equals(""))) {
		String msg=URLEncoder.encode("새로운 카테고리이름을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryList.jsp?msg="+msg);
		return;
	}
	
	Category category=new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	
	
	// Model
	CategoryDao categoryDao=new CategoryDao();
	String targetUrl=categoryDao.WrongCategory(category);
	
	if(targetUrl != null) {
		response.sendRedirect(request.getContextPath()+targetUrl);
		return;
	}
		System.out.println("insertCategoryAction:카테고리중복확인완료");
	
	int newCategory=categoryDao.insertCategory(category);
	if(newCategory == 1) {
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		System.out.println("insertCategoryAction:새로운카테고리추가완료");
	}
%>
