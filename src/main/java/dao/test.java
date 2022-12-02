package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import vo.*;

import util.DBUtil;

public class CashDao {

	// 호출 : cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_memo cashMemo, c.cash_price cashPrice, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no=ct.category_no WHERE c.member_id=? AND YEAR(c.cash_date)=? AND MONTH(c.cash_date)=? AND DAY(c.cash_date)=? ORDER BY c.cash_date ASC, ct.category_kind ASC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs= stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
	         // m.put()
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
	      }
		conn.close();
		return list;
	}
	
	// 호출 : cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_memo cashMemo, c.cash_price cashPrice, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no=ct.category_no WHERE c.member_id=? AND YEAR(c.cash_date)=? AND MONTH(c.cash_date)=? ORDER BY c.cash_date ASC, ct.category_kind ASC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs= stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
	         // m.put()
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
	      }
		conn.close();
		return list;
	}
	
	// 가계부 내용 추가 insertCashAction.jsp
	public int insertCashList(String memberId, Cash cash) throws Exception {
		int resultRow = 0;
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) values(?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getMemberId());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
		resultRow = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return resultRow;
	}
	
	// 가계부 수정폼 cashUpdateForm.jsp
	public ArrayList<HashMap<String, Object>> selectCashList(String memberId, int cashNo) throws Exception {
		ArrayList<HashMap<String, Object>> list2 = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT cash_price cashPrice, cash_date cashDate, cash_memo cashMemo FROM cash WHERE cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs= stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			list2.add(m);
	      }
		dbUtil.close(rs, stmt, conn);
		return list2;
	}
	
	// 가계부 내역수정 cashUpdateAction.jsp
	public int updateCashList(String memberId, Cash cash) throws Exception {
		int resultRow = 0;
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE cash SET category_no=?, cash_date=?, cash_price=?, cash_memo=?, updatedate=CURDATE() WHERE cash_no=? AND member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getCashDate());
		stmt.setLong(3, cash.getCashPrice());
		stmt.setString(4, cash.getCashMemo());
		stmt.setInt(5, cash.getCashNo());
		stmt.setString(6, cash.getMemberId());
		resultRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return resultRow;
	}
	
	// 가계부내역삭제 deleteCashListAction.jsp
	public int deleteCashList(String memberId, Cash cash) throws Exception {
		int deleteResult = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM cash WHERE cash_no=? AND member_id=?";
		PreparedStatement stmt=conn.prepareStatement(sql);  
		stmt.setInt(1, cash.getCashNo());
		stmt.setString(2, cash.getMemberId());
		deleteResult=stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return deleteResult;
	}
}
