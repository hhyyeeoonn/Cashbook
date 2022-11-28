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
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	String noticeMemo=request.getParameter("noticeMemo");
	
	if((noticeMemo == null) || (noticeMemo.equals(""))) {
		String msg=URLEncoder.encode("비어있는 글은 등록할 수 없습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/updateNoticeList.jsp?msg="+msg);
		return;
	}
		System.out.println("updateNoticeAction:글내용확인");
		
	Notice notice=new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeMemo(noticeMemo);
	
	// M
	NoticeDao noticeDao=new NoticeDao();
	int row=noticeDao.updateNotice(notice); 
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		System.out.println("updateNoticeAction:새로운공지작성완료");
	}
%>