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
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT c.cash_no cashNo"
					+ ", c.cash_date cashDate"
					+ ", c.cash_memo cashMemo"
					+ ", c.cash_price cashPrice"
					+ ", ct.category_kind categoryKind"
					+ ", ct.category_name categoryName"
					+ " FROM cash c INNER JOIN category ct"
					+ " ON c.category_no=ct.category_no"
					+ " WHERE c.member_id=?"
					+ " AND YEAR(c.cash_date)=?"
					+ " AND MONTH(c.cash_date)=?"
					+ " AND DAY(c.cash_date)=?"
					+ " ORDER BY c.cash_date ASC, ct.category_kind ASC;";
			list = new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
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
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(rs, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }

		return list;
	}
	
	// 호출 : cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT c.cash_no cashNo"
					+ ", c.cash_date cashDate"
					+ ", c.cash_memo cashMemo"
					+ ", c.cash_price cashPrice"
					+ ", ct.category_kind categoryKind"
					+ ", ct.category_name categoryName"
					+ " FROM cash c INNER JOIN category ct"
					+ " ON c.category_no=ct.category_no"
					+ " WHERE c.member_id=?"
					+ " AND YEAR(c.cash_date)=?"
					+ " AND MONTH(c.cash_date)=?"
					+ " ORDER BY c.cash_date ASC, ct.category_kind ASC;";
			list = new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
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
		} catch(Exception e) {
			e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(rs, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		return list;
	}
	
	// 가계부 내용 추가 insertCashAction.jsp
	public int insertCashList(String memberId, Cash cash) {
		int resultRow = 0;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			String sql = "INSERT INTO cash("
					+ "category_no, member_id"
					+ ", cash_date, cash_price"
					+ ", cash_memo, updatedate, createdate)"
					+ " values(?, ?, ?, ?, ?, CURDATE(), CURDATE())";
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getMemberId());
			stmt.setString(3, cash.getCashDate());
			stmt.setLong(4, cash.getCashPrice());
			stmt.setString(5, cash.getCashMemo());
			resultRow = stmt.executeUpdate();
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(null, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		return resultRow;
	}
	
	// 가계부 수정폼 cashUpdateForm.jsp
	public ArrayList<HashMap<String, Object>> selectCashList(String memberId, int cashNo) {
		ArrayList<HashMap<String, Object>> list2=null;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		try {
			String sql = "SELECT cash_price cashPrice,"
					+ " cash_date cashDate,"
					+ " cash_memo cashMemo"
					+ " FROM cash"
					+ " WHERE cash_no=?";
			list2=new ArrayList<HashMap<String, Object>>();
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			rs= stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				list2.add(m);
		      }
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(rs, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		return list2;
	}
	
	// 가계부 내역수정 cashUpdateAction.jsp
	public int updateCashList(String memberId, Cash cash)  {
		int resultRow = 0;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			String sql="UPDATE cash"
					+ " SET category_no=?"
					+ ", cash_date=?"
					+ ", cash_price=?"
					+ ", cash_memo=?"
					+ ", updatedate=CURDATE()"
					+ " WHERE cash_no=? AND member_id=?";
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getCashDate());
			stmt.setLong(3, cash.getCashPrice());
			stmt.setString(4, cash.getCashMemo());
			stmt.setInt(5, cash.getCashNo());
			stmt.setString(6, cash.getMemberId());
			resultRow = stmt.executeUpdate();
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(null, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		return resultRow;
	}
	
	// 가계부내역삭제 deleteCashListAction.jsp
	public int deleteCashList(String memberId, Cash cash) throws Exception {
		int deleteResult = 0;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		String sql = "DELETE FROM cash WHERE cash_no=? AND member_id=?";
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);  
			stmt.setInt(1, cash.getCashNo());
			stmt.setString(2, cash.getMemberId());
			deleteResult=stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(null, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		return deleteResult;
	}
}
