<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	// Controller
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	int helpNo=Integer.parseInt(request.getParameter("helpNo"));
	
	
	// 공지 삭제
	HelpDao helpDao=new HelpDao();
	// memberId와 helpNo 정보 저장하기
	ArrayList<HashMap<String, Object>> list=helpDao.selectHelpList(helpNo);
	String memberId=null;
	for(HashMap<String, Object> h:list) {
		memberId=(String)(h.get("memberId"));
	}
	Help help=new Help(); // 변수초기화
	help.setHelpNo(helpNo);
	help.setMemberId(memberId);
		System.out.println("deleteHelpList:정보확인");
		//System.out.println(help.getHelpNo());
		//System.out.println(help.getMemberId());
	
	int row=helpDao.deleteHelpList(help);
	if(row == 1) {
		System.out.println("deleteHelpList:문의글삭제완료");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
	}
%>