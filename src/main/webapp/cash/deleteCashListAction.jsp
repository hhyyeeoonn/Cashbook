<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@	page import = "util.*" %>

<%
	// C
	request.setCharacterEncoding("utf-8");
	String memberId=request.getParameter("memberId");
	int cashNo=Integer.parseInt(request.getParameter("cashNo"));
	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month"));
	int date=Integer.parseInt(request.getParameter("date"));
	
	Cash cash=new Cash();
	cash.setMemberId(memberId);
	cash.setCashNo(cashNo);
	
	
	// M
	CashDao cashDao = new CashDao(); // C
	int row = cashDao.deleteCashList(cash);
	if(row == 1) { 
		System.out.println("삭제성공:deleteCashListAction");
	}
	response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
%>