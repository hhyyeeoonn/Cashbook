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
	String noticeMemo=request.getParameter("noticeMemo");
	
	if((noticeMemo == null) || (noticeMemo.equals(""))) {
		String msg=URLEncoder.encode("비어있는 글은 등록할 수 없습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/insertNoticeForm.jsp?msg="+msg);
		return;
	}
		System.out.println("insertNoticeAction:글내용확인");
	
	// M
	NoticeDao noticeDao=new NoticeDao();
	int row=noticeDao.insertNotice(noticeMemo); 
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		System.out.println("insertNoticeAction:새로운공지작성완료");
	}
%>