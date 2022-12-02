package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Comment;

public class CommentDao {
	
	// 문의글 답변 입력
	public int insertComment(Comment comment) {
		int row=0;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		String sql="INSERT INTO comment("
				+ "help_no, comment_memo, member_id, updatedate, createdate)"
				+ " VALUES(?, ?, ?, NOW(), NOW())";
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
			row=stmt.executeUpdate();
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
		
	// 수정
	public Comment selectCommentOne(int commentNo) {
		Comment comment=null;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null; 
		String sql="SELECT comment_memo commentMemo, member_id memberId"
				+ " FROM comment"
				+ " WHERE comment_no=?";
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			rs=stmt.executeQuery();
			if(rs.next()) {
				comment=new Comment();
				comment.setCommentMemo(rs.getString("commentMemo"));
				comment.setMemberId(rs.getString("memberId"));
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
			return comment;
	}
		
	public int updateComment(Comment comment) throws Exception {
		int row=0;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		String sql="UPDATE comment"
				+ " SET comment_memo=?, updatedate=NOW()"
				+ " WHERE help_no=? AND comment_no=? AND member_id=?";
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getHelpNo());
			stmt.setInt(3, comment.getCommentNo());
			stmt.setString(4, comment.getMemberId());
			row=stmt.executeUpdate();
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
	
	// 삭제
	public int deleteComment(Comment comment) throws Exception {
		int row=0;
		String sql="DELETE FROM comment"
				+ " WHERE help_no=? AND comment_no=?";
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setInt(2, comment.getCommentNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}	
}
