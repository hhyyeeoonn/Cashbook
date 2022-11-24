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
	int cashNo=Integer.parseInt(request.getParameter("cashNo"));
	String categoryKind=request.getParameter("categoryKind");
	
		System.out.println(">>"+year);
		System.out.println(">>"+month);
		System.out.println(">>"+date);
		System.out.println(">>"+cashNo);
		System.out.println(">>"+categoryKind);
		
	Member loginMember = (Member)session.getAttribute("loginMember");
		System.out.println(loginMember);

		
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList= categoryDao.selectCategoryList();
	ArrayList<Category> categoryList2= categoryDao.selectCategoryList2(categoryKind);
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	ArrayList<HashMap<String, Object>> list2=cashDao.selectCashList(cashNo);

	// View
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashUpdateForm</title>
</head>
<body>

	<!-- cash 수정 폼 -->
	<form action="<%=request.getContextPath()%>/cash/cashUpdateAction.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>&cashNo=<%=cashNo%>&categoryKind=<%=categoryKind%>" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table border="1">
			<tr>
				<td></td>
				<td>
					<select name="categoryNo">
						<%
							for(Category c:categoryList2) {
									
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
			<%
				for(HashMap<String, Object> a:list2) {
			%>
				<tr>
					<td>cashPrice</td>
					<td>
						<input type="text" name="cashPrice" value="<%=(Long)(a.get("cashPrice"))%>">
					</td>
				</tr>
				<tr>
					<td>cashDate</td>
					<td>
						<input type="text" name="cashDate" value="<%=(String)(a.get("cashDate")) %>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="3" cols="50" name="cashMemo"><%=(String)(a.get("cashMemo"))%></textarea>
					</td>
				</tr>
			<%
				}
			%>
		</table>
		<button type="submit">수정</button>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
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