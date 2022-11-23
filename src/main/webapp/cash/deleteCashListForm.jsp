<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteCashListForm</title>
</head>
<body>
	<h2>가계부내역 삭제</h2>
	<div>아이디와 비밀번호를 입력하세요</div>
	<form action="<%=request.getContextPath()%>/deleteCashListAction.jsp" method="post">
		<div>
			<input type="text" name="memberId">
		</div>
		<div>
			<input type="password" name="memberPw">
		</div>
		<button type="submit">삭제</button>
	</form>
</body>
</html>