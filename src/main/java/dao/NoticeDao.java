package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	public int deleteNotice(int noticeNo) throws Exception {
		int row = 0;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		String sql="DELETE FROM notice"
				+ " WHERE notice_no=?";
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			row = stmt.executeUpdate();
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(null, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		
		return row;
	}
	
	// 수정할 공지내용 고르기 /admin/updateNoticeList.jsp
	public String selectOneNoticeList(int noticeNo) throws Exception {
		String noticeOne = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql="SELECT"
				+ " notice_memo noticeMemo"
				+ " FROM notice"
				+ " WHERE notice_no=?";
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				noticeOne=rs.getString("noticeMemo");
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
		return noticeOne;
	}
	
	// /admin/updateNoticeAction.jsp
	public int updateNotice(Notice notice) throws Exception {
		int row = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql="UPDATE notice"
				+ " SET notice_memo=?"
				+ ", updatedate=CURDATE()"
				+ " WHERE notice_no=?";
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setInt(2, notice.getNoticeNo());
			row = stmt.executeUpdate();
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(null, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		return row;
	}
	
	public int insertNotice(String noticeMemo) throws Exception {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql="INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())"; // datetime -> now() 시간까지 나옴
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, noticeMemo);
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

	
	// lastPage구하기 마지막페이지를 구하려면 전체row를 구하라
	public int selectNoticeCount(int rowPerPage) throws Exception {
		int lastPage=0;
		int cnt=0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		String sql="SELECT COUNT(*) cnt From notice"; // (*)는 COUNT와 붙여쓸 것 띄어쓰기 하면 오류남
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
			lastPage=(int)(Math.ceil((double)cnt / (double)rowPerPage));
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(null, stmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		return lastPage;
	}

	// 페이지에 출력될 내용 
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
					+ " FROM notice ORDER BY createdate DESC"
					+ " LIMIT ?, ?";
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
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
}
