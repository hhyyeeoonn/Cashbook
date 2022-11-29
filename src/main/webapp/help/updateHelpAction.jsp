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
	} 
	
	request.setCharacterEncoding("utf-8");
	int helpNo=Integer.parseInt(request.getParameter("helpNo"));
	String memberId=request.getParameter("memberId");
	String helpMemo=request.getParameter("helpMemo");
	
	if(helpMemo == null || helpMemo.equals("")) {
		String msg=URLEncoder.encode("비어있는 문의글은 등록할 수 없습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/updateHelpList.jsp?helpNo="+helpNo+"&msg="+msg);
		return;
	}
		System.out.println("updateHelpAction:문의글내용확인");
		
	Help help=new Help();
	help.setMemberId(memberId);
	help.setHelpMemo(helpMemo);
	help.setHelpNo(helpNo);
	
	// M
	HelpDao helpDao=new HelpDao();
	int row=helpDao.updateHelpMemo(help); 
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		System.out.println("updateHelpAction:문의글수정완료");
	}
%>