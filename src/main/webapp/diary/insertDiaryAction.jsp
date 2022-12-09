<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println(loginMember);
	
	if(loginMember == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}		
	
	request.setCharacterEncoding("utf-8");
	String diaryDate = request.getParameter("diaryDate");
	String diaryMemo = request.getParameter("memo");
	String memberId = request.getParameter("memberId");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = request.getParameter("date");
	System.out.println("insertDiaryAction:y:"+year+"/m:"+month+"/d"+date);
	
	
	
	
	Diary diary = new Diary();
	diary.setDiaryMemo(diaryMemo);
	diary.setMemberId(memberId);
	diary.setDiaryDate(diaryDate);
	
	DiaryDao diaryDao = new DiaryDao();
	int row = diaryDao.inserDiarytMemo(diary);
		System.out.println("insertDiaryAction:입력성공");
	response.sendRedirect(request.getContextPath() + "/diary/diaryDateList.jsp?year="+year+"&month="+month+"&date="+date);

%>
