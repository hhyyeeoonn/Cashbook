package dao;

import java.sql.*;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;

import util.DBUtil;
import vo.Member;

public class MemberDao {
	public Member login(Member paramMember) throws Exception { // 다형성 : 부모타입으로 자식타입을 감싸는 것 
		Member resultMember = null;
		
		/*
		Class.forName("");
		Connection conn = DriverManager.getConnection()"jdbc..";
		-> DB를 연결하는 코드(명령들)가 Dao 메서드를 거의 공동으로 중복된다.
		-> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		-> 입력값과 반환값 결정해야 한다
		-> 입력값은 없고 반환값은 Connection타입의 결과값이 남아야 한다.
		*/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id=? AND member_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
		
		rs.close(); // rs그 자체를 return하려면 실행되고 있어야 하는 코드가 너무 많아짐 그래서 ArrayList에 복사해서 return 하는 것
		stmt.close();
		conn.close();
		return resultMember;
	}
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		/*
		Class.forName("");
		Connection conn = DriverManager.getConnection()"jdbc..";
		*/
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_name) values(?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		resultRow = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return resultRow;
	}
}






