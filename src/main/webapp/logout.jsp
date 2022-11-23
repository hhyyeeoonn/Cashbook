<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 세션 초기화 모든 세션 정보를 한 번에 삭제
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>