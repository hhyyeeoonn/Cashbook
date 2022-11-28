package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	public int deleteNotice(int noticeNo) throws Exception {
		int row = 0;
		String sql="DELETE FROM notice WHERE notice_no=?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 수정할 공지내용 고르기 /admin/updateNoticeList.jsp
	public String selectOneNoticeList(int noticeNo) throws Exception {
		String noticeOne=null;
		String sql="SELECT"
				+ " notice_memo noticeMemo"
				+ " FROM notice"
				+ " WHERE notice_no=?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			noticeOne=rs.getString("noticeMemo");
		}
		
		dbUtil.close(rs, stmt, conn);
		return noticeOne;
	}
	
	// /admin/updateNoticeAction.jsp
	public int updateNotice(Notice notice) throws Exception {
		int row = 0;
		String sql="UPDATE notice"
				+ " SET notice_memo=?"
				+ ", updatedate=CURDATE()"
				+ " WHERE notice_no=?";
		DBUtil dbUtil=new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		row=stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	public int insertNotice(String noticeMemo) throws Exception {
		int resultRow=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())"; // datetime -> now() 시간까지 나옴
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, noticeMemo);
		resultRow=stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return resultRow;
	}

	
	// lastPage구하기 마지막페이지를 구하려면 전체row를 구하라
	public int selectNoticeCount(int rowPerPage) throws Exception {
		int lastPage=0;
		int cnt=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="SELECT COUNT(*) cnt From notice"; // (*)는 COUNT와 붙여쓸 것 띄어쓰기 하면 오류남
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs=stmt.executeQuery();
		if(rs.next()) {
			cnt=rs.getInt("cnt");
		}
		lastPage=(int)(Math.ceil((double)cnt / (double)rowPerPage));
		
		dbUtil.close(rs, stmt, conn);
		return lastPage;
	}

	// 페이지에 출력될 내용 
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
					+ " FROM notice ORDER BY createdate DESC"
					+ " LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
}
