<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*" %>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null) { // 로그인 되지 않은 상태
		System.out.println("updateDiaryAction:session확인");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}	
	
	request.setCharacterEncoding("utf-8");
	int diaryNo = Integer.parseInt(request.getParameter("diaryNo"));
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = request.getParameter("date");
	
	Diary diary = new Diary();
	diary.setDiaryNo(diaryNo);
	diary.setMemberId(loginMember.getMemberId());
	
	// model
	DiaryDao diaryDao = new DiaryDao();
	diaryDao.deleteDiaryList(diary);
	System.out.println("deleteDiary:삭제완료");
	response.sendRedirect(request.getContextPath() + "/diary/diaryList.jsp");
%>