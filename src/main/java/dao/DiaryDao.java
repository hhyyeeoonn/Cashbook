package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.*;

public class DiaryDao {
		
	/*
	public ArrayList<Member> list selectDiaryAndCashList(String memberId, int year, int month, int date) {
		ArrayList<Member> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null; 
		ResultSet rs = null;
	
		try {
			String sql = "SELECT diary_no diaryNo"
					+ " di"
			dbUtil = new DBUtil();
		}
	
	}
	*/
	
	public ArrayList<HashMap<String, Object>> selectDiaryListByDate(String memberId, int year, int month, int date) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
	
		try {
			list = new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT diary_no diaryNo,"
					+ " diary_memo diaryMemo,"
					+ " diary_date diaryDate,"
					+ "	updatedate"
					+ " FROM diary"
					+ " WHERE member_id = ?"
					+ " AND YEAR(diary_date) = ?"
					+ " AND MONTH(diary_date) = ?"
					+ " AND DAY(diary_date) = ?"
					+ " ORDER BY diary_no DESC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> d = new HashMap<String, Object>();
				d.put("diaryNo", rs.getInt("diaryNo"));
				d.put("diaryMemo", rs.getString("diaryMemo"));
				d.put("diaryDate", rs.getString("diaryDate"));
				d.put("updatedate", rs.getString("updatedate"));
				list.add(d);
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
	
	public ArrayList<HashMap<String, Object>> selectDiaryListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
	
		try {
			list = new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT diary_no diaryNo,"
					+ " diary_memo diaryMemo,"
					+ " diary_date diaryDate"
					+ " FROM diary"
					+ " WHERE member_id = ?"
					+ " AND YEAR(diary_date) = ?"
					+ " AND MONTH(diary_date) = ?"
					+ " ORDER BY diary_no DESC";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> d = new HashMap<String, Object>();
				d.put("diaryNo", rs.getInt("diaryNo"));
				d.put("diaryMemo", rs.getString("diaryMemo"));
				d.put("diaryDate", rs.getString("diaryDate"));
				list.add(d);
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
	
	
	
	// diary입력
	public int inserDiarytMemo(Diary diary) {
		int row=0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			dbUtil = new DBUtil();	
			conn = dbUtil.getConnection();
			String sql="INSERT INTO diary("
					+ "diary_memo, member_id, diary_date, updatedate, createdate)"
					+ " VALUES(?, ?, ?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, diary.getDiaryMemo());
			stmt.setString(2, diary.getMemberId());
			stmt.setString(3, diary.getDiaryDate());
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
				stmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// diary 수정
	public int updateDiaryMemo(Diary diary) {
		int row=0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql="UPDATE diary"
					+ " SET diary_memo=?, updatedate=NOW()"
					+ " WHERE member_id=? AND diary_no=?";
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, diary.getDiaryMemo());
			stmt.setString(2, diary.getMemberId());
			stmt.setInt(3, diary.getDiaryNo());
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
				stmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// diary 삭제
	public int deleteDiaryList(Diary diary) {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql="DELETE FROM diary"
					+ " WHERE diary_no=? AND member_id=?";
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, diary.getDiaryNo());
			stmt.setString(2, diary.getMemberId());
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
				stmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}	
}
