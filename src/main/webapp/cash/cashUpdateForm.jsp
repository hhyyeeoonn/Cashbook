<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
		System.out.println(year);
		System.out.println(month);
		System.out.println(date);
	
	String categoryNum=request.getParameter("categoryNo");
	String price=request.getParameter("cashPrice");
	String memberId=request.getParameter("memberId");
	String cashDate=request.getParameter("cashDate");
	String cashMemo=request.getParameter("cashMemo");
		System.out.println(">>"+year);
		System.out.println(">>"+month);
		System.out.println(">>"+date);
		System.out.println(">>"+memberId);
		System.out.println(">>"+cashDate);
		System.out.println(">>"+cashMemo);
	
	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println(loginMember);
	
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList= categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	//ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month);
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);


	// View
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashUpdateForm</title>
</head>
<body>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table border="1">
			<tr>
				<td></td>
				<td>
					<select name="categoryNo">
						<%
							for(Category c:categoryList) {
						%>
							<option value="<%=c.getCategoryNo()%>">
								<%=c.getCategoryKind()%>) <%=c.getCategoryName()%>
							</option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>cashPrice</td>
				<td>
					<input type="text" name="cashPrice" value="">
				</td>
			</tr>
			<tr>
				<td>cashDate</td>
				<td>
					<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"><%= %></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
		<%
			if(request.getParameter("Msg") != null) {
		%>
				<%=request.getParameter("Msg")%>
		<%
			}
		%>
	</form>
	<!-- cash 목록 출력 -->
	<div>
		<table>
			<tr>
				<th>날짜</th>
				<th>구분</th>
				<th>항목</th>
				<th>금액</th>
				<th>내용</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list) {
					//String cashDate=(String)(m.get("cashDate"));
					//if(Integer.parseInt(cashDate.substring(8)) == date)
			%>
					<tr>
						<td><%=(String)(m.get("cashDate"))%></td>
						<td><%=(String)(m.get("categoryKind"))%></td>
						<td><%=(String)(m.get("categoryName"))%></td>
						<td><%=(Long)(m.get("cashPrice"))%></td>
						<td><%=(String)(m.get("cashMemo"))%></td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>