<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*
	public HashMap<String, Object> selectMaxMinYear(Connection conn) throws Exception {
		HashMap<String, Object> map = null;
		String sql = "SELECT"
					+ "	(SELECT MIN(YEAR(cash_date)) FROM cash) minYear"
					+ ", (SELECT MAX(YEAR(cash_date))FROM cash) maxYear"
					+ " FROM DUAL";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			map = new HashMap<String, Object>();
			map.put("minYear", rs.getInt("minYear"));
			map.put("maxYear", rs.getInt("maxYear"));
			
		}
		stmt.close();
		rs.close();
		return map;
	}




	
	
	
	
	public HashMap<String, Object> getMaxMinYear() {
		HashMap<String, Object> map = null;
		Connection conn = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			CashDao cashDao = new CashDao();
			map = cashDao.selectMaxMinYear(conn);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	// 페이징 사용할 최소년도와 최대년도
	HashMap<String, Object> map = cashService.getMaxMinYear();
	int minYear = (Integer)(map.get("minYear"));
	int maxYear = (Integer)(map.get("maxYear"));
	
	*/


	//import java.sql.SQLException;
	// java.sql.SQLException: 부적합한 열 이름
	
	/*
	dual 은 펑션이나 계산식을 테이블 생성없이 수행해 보기 위한 용도로 사용하는 일종의 'dummy' 테이블이다.
	어떤 값이 들어있는 것이 아니라 임시의 공간이라고 생각하면 된다.
	dual 테이블이 존재하는 이유는 SQL 함수에 대한 쓰임을 알고 싶을 때, 출력되는 데이터를 확인해보기 위함으로
	특정 테이블을 생성할 필요 없이 dual 테이블을 이용하여 함수의 값을 리턴(return) 받을 수 있다.
	*/
	/*
	[Mysql에서 dual 가상 테이블 사용하는 방법]
	1. 오라클 등 dbms에서는 가상 테이블을 사용하기 위해서 dual을 사용해야합니다
	2. mysql 에서는 dual 키워드가 없어도 select 절을 수행 (F9) 하면 결과를 확인할 수 있습니다
	3. as : 별칭을 지정합니다 (alias)
	*/
	
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>