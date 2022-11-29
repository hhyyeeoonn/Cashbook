package dao;

import vo.*;
import util.DBUtil;
import java.util.ArrayList;
import java.util.HashMap;
import java.sql.*;

public class HelpDao {

	// 관리자 / selectHelpList 오브로딩 다 같은데 매개변수값만 다름
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+"		, h.member_id memberId"
					+"		, h.createdate helpCreatedate"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+"		, c.comment_no commentNo"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+" ORDER BY h.help_no DESC"
					+" LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("memberId", rs.getString("memberId"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentNo", rs.getInt("commentNo"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// 회원 아이디로 문의글데이터 리스트만들기
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception { // Object 최상위 타입 (다형성)
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>(); // 오른쪽의 <String, Object>는 생략 가능
		String sql="SELECT h.help_no helpNo, h.help_memo helpMemo, h.createdate helpCreatedate"
				+ ", c.comment_memo commentMemo, c.createdate commentCreatedate"	
				+ " FROM help h LEFT JOIN comment c"
				+ " ON h.help_no=c.help_no"
				+ " WHERE h.member_id=?"
				+ " ORDER BY h.help_no DESC";
		DBUtil dbUtil =new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs=stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m=new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo")); 
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	
	}
	
	// 문의글 번호로 회원 아이디와 문의글 내용을
	public ArrayList<HashMap<String, Object>> selectHelpList(int helpNo) throws Exception { // Object 최상위 타입 (다형성)
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>(); // 오른쪽의 <String, Object>는 생략 가능
		String sql="SELECT member_id memberId, help_memo helpMemo"
				+ " FROM help"
				+ " WHERE help_no=?";
		DBUtil dbUtil =new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		rs=stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m=new HashMap<String, Object>();
			m.put("memberId", rs.getString("memberId"));
			m.put("helpMemo", rs.getString("helpMemo"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// 문의글 등록 /help/insertHelpAction.jsp
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
