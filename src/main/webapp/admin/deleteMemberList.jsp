<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	//
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
	
	
	// M
	// 추방할 회원 정보
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> theMemberList=memberDao.selectMember(memberNo);
	String memberId=null;
	for(Member m:theMemberList) {
		memberId=m.getMemberId();
	}
		System.out.println("deleteMemberList:수정할 회원");
	// 추방할 회원 정보 삭제
	Member member=new Member();
	member.setMemberNo(memberNo);
	member.setMemberId(memberId);
	int row=memberDao.deleteMember(member);
	if(row == 1) {
		System.out.println("deleteMemberList:회원추방완료");
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	}
%>