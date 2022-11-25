<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>\
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.*" %>
<%
	// 뷰가 없는 구조 M도 여기에 있는 것이 아니라 호출하는 것이라 실질적으로는 C만 있는 페이지
	// C
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");

	// request 유효성 검증
		if((memberId == null) || (memberId.equals("")) || (memberPw == null) || (memberPw.equals(""))) {
			String msg=URLEncoder.encode("아이디와 비밀번호를 확인하십시오.", "utf-8");
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
			return;
		}
			System.out.println("=빈칸확인=");
	
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);

	// 분리된 M(모델)을 호출
	MemberDao memberDao = new MemberDao(); // C
	Member resultMember = memberDao.login(paramMember); // login이라는 메서드 자체가 M
	
	String redirectUrl = "/cash/cashList.jsp";
	// 로그인 성공시 session에 로그인 정보 저장
	if((resultMember != null) && (resultMember.getMemberLevel() == 1)) {
		session.setAttribute("loginMember", resultMember);
		redirectUrl = "/admin/adminMain.jsp";
	} else if(resultMember != null) { 
		session.setAttribute("loginMember", resultMember);	
	}

	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>