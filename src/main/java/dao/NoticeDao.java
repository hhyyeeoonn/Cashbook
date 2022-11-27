package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	public int deleteNotice(Notice notice) throws Exception {
		String sql="DELETE FROM notice WHERE notice_no=?";
		return 0;
	}
	
	/*
	 int deleteResult = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt=conn.prepareStatement(sql);  
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		deleteResult=stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return deleteResult;
	 */
	
	
	
	public int updateNotice(Notice notice) throws Exception {
		String sql="UPDATE notice SET notice_memo=? WHWERE notice_no=?";
		return 0;
	}
	
	public int insertNotice(Notice notice) throws Exception {
		int resultRow=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())"; // datetime -> now() 시간까지 나옴
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		
		return resultRow;
	}
	/*
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
	 */
	
	
	
	
	
	
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
		return list;
	}
}
