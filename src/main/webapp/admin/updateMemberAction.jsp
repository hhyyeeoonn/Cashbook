<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*" %>

<%
	Member loginMember=(Member)session.getAttribute("loginMember"); 
	if(loginMember == null) { // 로그인이 안되어 있을 때
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 관리자가 아닐 때
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	int memberNo=Integer.parseInt(request.getParameter("memberNo"));
	String level=request.getParameter("memberLevel");
	// 받아온 회원등급정보
	int memberLevel=0;
	if(level == "일반회원" || level.equals("일반회원")) {
		memberLevel=0;
	} else {
		memberLevel=1;
	}
	
	
	//
	MemberDao memberDao = new MemberDao();
	// 수정할 회원 정보
	ArrayList<Member> theMemberList=memberDao.selectMember(memberNo);
	String memberId=null;
	for(Member m:theMemberList) {
		memberId=m.getMemberId();
	}
		System.out.println("updateMemberAction:수정할 회원");
	// 회원등급수정
	Member member=new Member();
	member.setMemberId(memberId);
	member.setMemberLevel(memberLevel);
	int row=memberDao.upadateMemberLevel(member);
	if(row == 1) {
		System.out.println("updateMemberAction:회원등급수정완료");
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}
%>