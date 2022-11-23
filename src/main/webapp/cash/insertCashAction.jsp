<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import = "util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>

<%
	// C
	request.setCharacterEncoding("utf-8");
	String categoryNum=request.getParameter("categoryNo");
	String price=request.getParameter("cashPrice");
	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month"));
	int date=Integer.parseInt(request.getParameter("date"));
	String memberId=request.getParameter("memberId");
	String cashDate=request.getParameter("cashDate");
	String cashMemo=request.getParameter("cashMemo");
		/*
		System.out.println(">>"+year);
		System.out.println(">>"+month);
		System.out.println(">>"+date);
		System.out.println(">>"+memberId);
		System.out.println(">>"+cashDate);
		System.out.println(">>"+cashMemo);
		*/
	if((categoryNum == null) || (price == null) || (categoryNum.equals("")) || (price.equals(""))) {
		categoryNum="0";
		price="0";
	}
	
	int categoryNo=Integer.parseInt(categoryNum);
	int cashPrice=Integer.parseInt(price);
		/*
		System.out.println(">>"+categoryNo);
		System.out.println(">>"+cashPrice);
		*/
	if((categoryNo == 0) || (cashPrice == 0) || (memberId == null) || (memberId.equals(""))
			|| (cashDate == null) || (cashDate.equals("")) || (cashMemo == null) || (cashMemo.equals(""))) {
		String Msg=URLEncoder.encode("빈칸에 내용을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&Msg="+Msg);
		return;
	}		
	
	Member loginMember=(Member)session.getAttribute("loginMember");
		System.out.println(loginMember);
		
	Cash paramCate = new Cash();
	paramCate.setMemberId(memberId);
	paramCate.setCategoryNo(categoryNo);
	paramCate.setCashPrice(cashPrice);
	paramCate.setCashDate(cashDate);
	paramCate.setCashMemo(cashMemo);
	
	
	// Model
	CashDao insertCash = new CashDao();
	int row = insertCash.insertCashList(paramCate);
	
	if(row == 1) {
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}

%>