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
	int helpNo=Integer.parseInt(request.getParameter("helpNo"));
	int commentNo=Integer.parseInt(request.getParameter("commentNo"));
	String commentMemo=request.getParameter("commentMemo");
	String memberId=request.getParameter("memberId");
	
	if(commentMemo == null || commentMemo.equals("")) {
		String msg=URLEncoder.encode("비어있는 글은 등록할 수 없습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/adminHelp/updateCommentList.jsp?msg="+msg);
		return;
	}
		System.out.println("updateCommentAction:답변내용확인");
		
	Comment comment=new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentNo(commentNo);
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(memberId);
	
	
	// M
	CommentDao commentDao=new CommentDao();
	int row=commentDao.updateComment(comment);
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/adminHelp/helpListAll.jsp");
		System.out.println("updateCommentAction:답변수정완료");
	}
%>