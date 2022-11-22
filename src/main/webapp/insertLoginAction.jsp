<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import = "util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*" %>

<!-- 회원가입 로그인 로그아웃 -->
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	String name=request.getParameter("name");
	String pw=request.getParameter("pw");
	
	
	if((id == null) || (id.equals("")) || (name == null) || (name.equals("")) || (pw == null) || (pw.equals(""))) {
		String msg=URLEncoder.encode("빈칸에 내용을 입력하십시오.", "utf-8"); 
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?msg="+msg);
		return;
	}
		System.out.println("=빈칸 확인=");
	
	Member paramMember = new Member();
	paramMember.setMemberId(id);
	paramMember.setMemberPw(pw);
	paramMember.setMemberName(name);
		
	//
	String idSql="SELECT member_id FROM member WHERE member_id = ?";
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	PreparedStatement idStmt = conn.prepareStatement(idSql);
	idStmt.setString(1, id);
	ResultSet rs = idStmt.executeQuery();
	if(rs.next()){
		idStmt=conn.prepareStatement(idSql);
		String idMsg=URLEncoder.encode("사용할 수 없는 ID", "utf-8"); 
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?idMsg="+idMsg);
		
		rs.close();
		idStmt.close();
		conn.close();
		
		return; // 졸려죽겠네;
	} 
		System.out.println("=아이디 중복확인 완료=");

		
	// 가입확인
	MemberDao newbie = new MemberDao();
	int row = newbie( );

	
	if(row == 1) {
		String loginMsg=URLEncoder.encode("가입되었습니다. 로그인 하십시오.", "utf-8");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?loginMsg="+loginMsg);
		System.out.println("가입성공");
	} else {
		System.out.println("가입실패");
	}
	
	stmt.close();
	conn.close();
%>
