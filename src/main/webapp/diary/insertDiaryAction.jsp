<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println(loginMember);
	
	if((loginMember.getMemberId()) == null) { // 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}		
	
	request.setCharacterEncoding("utf-8");
	
	String diaryTitle = request.getParameter("title");
	String diaryMemo = request.getParameter("memo");
	String memberId = request.getParameter("memberId");
	
	Diary diary = new Diary();
	diary.setDiaryTitle(diaryTitle);
	diary.setDiaryMemo(diaryMemo);
	diary.setMemberId(memberId);
	
	DiaryDao diaryDao = new DiaryDao();
	int row = diaryDao.inserDiarytMemo(diary);
		System.out.println("insertDiaryAction:입력성공");
	response.sendRedirect(request.getContextPath() + "/diary/diaryList.jsp");

%>
