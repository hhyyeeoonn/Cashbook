package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import vo.*;

import util.DBUtil;

public class CashDao {
	
	// 연도를(페이징) 매개값으로 입력받아 월별(수입/지출) 합, 평균
	public ArrayList<HashMap<String, Object>> selectMonthSumAvg(Member loginMember, int year) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT"
					+ "	MONTH(t2.cashDate) 월"
					+ ", COUNT(t2.importCash) 수입"
					+ ", IFNULL(SUM(t2.importCash), 0) 수입합계"
					+ ", IFNULL(ROUND(AVG(t2.importCash)), 0) 수입평균"
					+ ", COUNT(t2.exportCash) 지출"
					+ ", IFNULL(SUM(t2.exportCash), 0) 지출합계"
					+ ", IFNULL(ROUND(AVG(t2.exportCash)), 0) 지출평균"
					+ " FROM"
					+ "		(SELECT"
					+ "			memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "		FROM"
					+ "			(SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId"
					+ "			FROM cash cs"
					+ "			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
					+ " GROUP BY MONTH(t2.cashDate)"
					+ " ORDER BY MONTH(t2.cashDate) DESC;";
			list = new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, loginMember.getMemberId());
			stmt.setInt(2, year);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("월", rs.getInt("월"));
				m.put("수입", rs.getInt("수입"));
				m.put("수입합계", rs.getInt("수입합계"));
				m.put("수입평균", rs.getInt("수입평균"));
				m.put("지출", rs.getInt("지출"));
				m.put("지출합계", rs.getInt("지출합계"));
				m.put("지출평균", rs.getInt("지출평균"));
				list.add(m);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 연도별
	public ArrayList<HashMap<String, Object>> selectYearSumAvg(Member loginMember) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT"
					+ "		YEAR(t2.cashDate) 연도"
					+ "		, COUNT(t2.importCash) 수입"
					+ "		, IFNULL(SUM(t2.importCash), 0) 수입합계"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) 수입평균"
					+ "		, COUNT(t2.exportCash) 지출"
					+ "		, IFNULL(SUM(t2.exportCash), 0) 지출합계"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) 지출평균"
					+ "	FROM"
					+ "	(SELECT"
					+ "			memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "	FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId"
					+ "			FROM cash cs"
					+ "			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ "	WHERE t2.memberId = ?"
					+ "	GROUP BY YEAR(t2.cashDate)"
					+ "	ORDER BY YEAR(t2.cashDate) DESC;";
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, loginMember.getMemberId());
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("연도", rs.getInt("연도"));
				m.put("수입", rs.getInt("수입"));
				m.put("수입합계", rs.getInt("수입합계"));
				m.put("수입평균", rs.getInt("수입평균"));
				m.put("지출", rs.getInt("지출"));
				m.put("지출합계", rs.getInt("지출합계"));
				m.put("지출평균", rs.getInt("지출평균"));
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
	
	//
	public HashMap<String, Object> selectMaxMinYear(Member loginMember) {
		HashMap<String, Object> map = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT"
						+ "	(SELECT MIN(YEAR(cash_date)) FROM cash WHERE member_id = ?) minYear"
						+ ", (SELECT MAX(YEAR(cash_date))FROM cash WHERE member_id = ?) maxYear"
						+ " FROM DUAL";// DUAL 데이터 확인을 위한 임시 테이블
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, loginMember.getMemberId());
			stmt.setString(2, loginMember.getMemberId());
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("minYear", rs.getInt("minYear"));
				map.put("maxYear", rs.getInt("maxYear"));
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
		return map;
	}
	
	
	// 호출 : cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
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
