package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBUtil;
import vo.Help;

public class DiaryDao {
	public int insertHelpMemo(Help help) throws Exception {
		int row=0;
		String sql="INSERT INTO HELP("
				+ "help_memo, member_id, updatedate, createdate)"
				+ " VALUES(?, ?, NOW(), NOW())";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 문의글 수정 /help/updateHelpAction.jsp
	public int updateHelpMemo(Help help) throws Exception {
		int row=0;
		String sql="UPDATE help"
				+ " SET help_memo=?, updatedate=NOW()"
				+ " WHERE member_id=? AND help_no=?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		stmt.setInt(3, help.getHelpNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 문의글 삭제 /help/deleteHelpList.jsp
	public int deleteHelpList(Help help) throws Exception {
		int row = 0;
		String sql="DELETE FROM help"
				+ " WHERE help_no=? AND member_id=?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, help.getHelpNo());
		stmt.setString(2, help.getMemberId());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
}
