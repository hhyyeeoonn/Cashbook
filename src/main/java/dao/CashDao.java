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
	// insertCashAction.jsp
	public int insertCashList(Cash paramCate) throws Exception {
		int resultRow = 0;
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) values(?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramCate.getCategoryNo());
		stmt.setString(2, paramCate.getMemberId());
		stmt.setString(3, paramCate.getCashDate());
		stmt.setLong(4, paramCate.getCashPrice());
		stmt.setString(5, paramCate.getCashMemo());
		resultRow = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return resultRow;
	}
	
	// 가계부내역수정 updateMemberAction.jsp
	public int updateMember(Member paramMember) throws Exception {
		int updateResultRow=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="UPDATE member SET member_name=?, createdate=CURDATE() WHERE member_id=? AND member_pw=PASSWORD(?)"; 
		PreparedStatement stmt=conn.prepareStatement(sql);  
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberId());
		stmt.setString(3, paramMember.getMemberPw());
		updateResultRow=stmt.executeUpdate();

		stmt.close();
		conn.close();
		return updateResultRow;
	}
		
		
	// 가계부내역삭제 deleteCashListAction.jsp
	public int deleteCash(Cash paramCate) throws Exception {
		int deleteResult = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM cash c INNER JOIN member m ON c.member_id=m.member_id WHERE m.member_id=? AND m.member_pw=PASSWORD(?)";
		PreparedStatement stmt=conn.prepareStatement(sql);  
		stmt.setString(1, paramCate.getMemberId());
		stmt.setint(2, paramCate.getMemberPw());
		deleteResult=stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return deleteResult;
	}
}
