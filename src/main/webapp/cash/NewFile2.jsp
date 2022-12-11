<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	if(loginMember == null) { // 로그인 되지 않은 상태
		System.out.println("diaryDateList:session확인");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}		
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
		System.out.println("diaryDateList:y:"+year+"/m:"+month+"/d:"+date);
		
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList= categoryDao.selectCategoryList();
	
	DiaryDao diaryDao = new DiaryDao();
	ArrayList<HashMap<String, Object>> list = diaryDao.selectDiaryListByDate(loginMember.getMemberId(), year, month, date);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<%
			for(HashMap<String, Object> m : list) {
		%>
			<input type = "hidden" name = "diaryNo" value = "<%=(int)(m.get("diaryNo"))%>">	
			<table>
				<tr>
					<td>
						<h3><%=year%>년 <%=month%>월 <%=date%>일</h3>
					</td>
				</tr>
				<tr>
					<td><%=(String)(m.get("diaryMemo"))%></td>
				</tr>
				<tr>
					<td>
						작성일 : <%=(String)(m.get("updatedate"))%>
					</td>
				</tr>
			</table>
		<%
			}
		%>
	</div>
	<div>
		<button type = "button" class="btn btn-primary">수정</button>
		<button type = "button" class="btn btn-primary">삭제</button>
	</div>
</body>
</html>