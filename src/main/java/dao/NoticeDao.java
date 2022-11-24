package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	// lastPage구하기 마지막페이지를 구하려면 전체row를 구하라
	public int selectNoticeCount() {
		int count=0;
		return count;
	}
	
	
	
	
	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list=new ArrayList<Notice>(); 
		DBUtil dbUtil=new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs=stmt.executeQuery();
		while(rs.next()) {
			Notice n=new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		
		
		return list;
	}
}
