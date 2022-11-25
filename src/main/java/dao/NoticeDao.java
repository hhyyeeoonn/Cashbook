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
	
	public int updateNotice(Notice notice) throws Exception {
		String sql="UPDATE notice SET notice_memo=? WHWERE notice_no=?";
		return 0;
	}
	
	public int insertNotice(Notice notice) throws Exception {
		String sql="INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())"; // datetime -> now() 시간까지 나옴
		return 0;
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
		return list;
	}
	/*
	 페이징 참고

	int currentPage=1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage=10;
	int beginRow=(currentPage-1) * rowPerPage; 
			
	String cntSql="SELECT COUNT(*) cnt FROM salaries";
	PreparedStatement cntStmt=conn.prepareStatement(cntSql);
	ResultSet cntRs=cntStmt.executeQuery();
	int cnt=0; //전체 행의 수
	if(cntRs.next()) {
		cnt=cntRs.getInt("cnt");
	}	
	int lastPage=(int)(Math.ceil((double)cnt / (double)rowPerPage)); 마지막페이지는 전체행 나누기 한번에 출력될 페이지 수
	  
	 */
}
