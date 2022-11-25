<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import = "util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>

<%
	// C
	Member loginMember=(Member)session.getAttribute("loginMember");
		System.out.println(loginMember + "<<loginMember");
	
	if((loginMember.getMemberId()) == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	
	
	request.setCharacterEncoding("utf-8");
	String categoryNum=request.getParameter("categoryNo");
	String price=request.getParameter("cashPrice");
	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month"));
	int date=Integer.parseInt(request.getParameter("date"));
	int cashNo=Integer.parseInt(request.getParameter("cashNo"));
	String cashDate=request.getParameter("cashDate");
	String cashMemo=request.getParameter("cashMemo");
	String categoryKind=request.getParameter("categoryKind");
		/*
		System.out.println(">>"+year);
		System.out.println(">>"+month);
		System.out.println(">>"+date);
		System.out.println(">>"+cashNo);
		System.out.println(">>"+memberId);
		System.out.println(">>"+cashDate);
		System.out.println(">>"+cashMemo);
		*/
	if((categoryNum == null) || (price == null) || (categoryNum.equals("")) || (price.equals(""))) {
		categoryNum="0";
		price="0";
	}
	
	int categoryNo=Integer.parseInt(categoryNum);
	long cashPrice=Long.parseLong(price);
		/*
		System.out.println(">>"+categoryNo);
		System.out.println(">>"+cashPrice);
		*/
	if((categoryNo == 0) || (cashPrice == 0) || (cashDate == null) || (cashDate.equals("")) || (cashMemo == null) || (cashMemo.equals(""))) {
		String msg=URLEncoder.encode("수정할 내용을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashUpdateForm.jsp?year="+year+"&month="+month+"&date="+date+"&cashNo="+cashNo+"&categoryKind="+categoryKind+"&msg="+msg);
		return;
	}		
		
	Cash cash = new Cash();
	cash.setMemberId(loginMember.getMemberId());
	cash.setCategoryNo(categoryNo);
	cash.setCashPrice(cashPrice);
	cash.setCashDate(cashDate);
	cash.setCashMemo(cashMemo);
	cash.setCashNo(cashNo);
	
	
	// Model
	CashDao cashDao = new CashDao();
	int row = cashDao.updateCashList(loginMember.getMemberId(), cash);
		System.out.println(row + "<<수정성공:cashUpdateAction");

	response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
%>