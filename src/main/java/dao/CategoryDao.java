package dao;

import java.util.ArrayList;
import util.*;

import java.net.URLEncoder;
import java.sql.*;
import vo.*;

public class CategoryDao {
	// 삭제
	public int deleteCatory(int categoryNo) throws Exception {
		int row = 0;
		String sql = "DELETE FROM category WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	
	// 수정: 수정폼(select)과 수정액션(action)으로 구성
	// /admin/updateCategoryAction.jsp
	public int updateCategoryName(Category category) throws Exception {
		int row = 0;
		String sql = "UPDATE category"
					+" SET category_name = ?, updatedate = CURDATE()"
					+" WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// /admin/updateCategory.jsp
	public Category selectCategoryOne(int categoryNo) throws Exception {
		Category category = null;
		String sql = "SELECT category_kind categoryKind, category_name categoryName"
					+" FROM category"
					+" WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			category = new Category();
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return category;
	}
	
	
	// /admin/insertCategoryAction.jsp
	public int insertCategory(Category category) throws Exception {
		int row=0;
		String sql="INSERT INTO category ("
				+ " category_kind"
				+ ", category_name"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?, ?, CURDATE(), CURDATE())";
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row=stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 카테고리 중복확인 /admin/insertCategoryAction.jsp 
	public String WrongCategory(Category category) throws Exception {
		String NmMsg=null;
		String targetUrl=null;
		DBUtil dbUtil = new DBUtil();
		String NmSql="SELECT category_name FROM category WHERE category_name=? AND category_kind=?";
		Connection conn = dbUtil.getConnection();
		PreparedStatement NmStmt = conn.prepareStatement(NmSql);
		NmStmt.setString(1, category.getCategoryName());
		NmStmt.setString(2, category.getCategoryKind());
		ResultSet rs = NmStmt.executeQuery();
		if(rs.next()){
			NmStmt=conn.prepareStatement(NmSql);
			NmMsg=URLEncoder.encode("이미 존재하는 카테고리입니다", "utf-8"); 
			targetUrl="/admin/insertCategoryList.jsp?NmMsg="+NmMsg;
		}
		
		rs.close();
		NmStmt.close();
		conn.close();
		
		return targetUrl;
	}
	
	// 카테고리 중복확인 /admin/updateCategoryAction.jsp
	public String WrongCategory2(Category category) throws Exception {
		String NmMsg=null;
		String targetUrl=null;
		DBUtil dbUtil = new DBUtil();
		String NmSql="SELECT category_name FROM category WHERE category_name=? AND category_kind=?";
		Connection conn = dbUtil.getConnection();
		PreparedStatement NmStmt = conn.prepareStatement(NmSql);
		NmStmt.setString(1, category.getCategoryName());
		NmStmt.setString(2, category.getCategoryKind());
		ResultSet rs = NmStmt.executeQuery();
		if(rs.next()){
			NmStmt=conn.prepareStatement(NmSql);
			NmMsg=URLEncoder.encode("이미 존재하는 카테고리입니다", "utf-8"); 
			targetUrl="/admin/updateCategoryList.jsp?categoryNo="+(category.getCategoryNo())+"&NmMsg="+NmMsg;
		}
		rs.close();
		NmStmt.close();
		conn.close();
		
		return targetUrl;
	}
	
	// cash 입력시 카테고리 select목록 cashDateList.jsp
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_kind;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs= stmt.executeQuery();
		while(rs.next()) {
			Category c=new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			categoryList.add(c);
	      }
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
	
	// cashUpdateForm.jsp
	public ArrayList<Category> selectCategoryList2(String categoryKind) throws Exception {
		String sql=null;
		ArrayList<Category> categoryList2 = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		if(categoryKind.equals("지출")) {
			sql="SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_kind='지출' ORDER BY category_kind";
		} else {
			sql="SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_kind='수입' ORDER BY category_kind";
		}
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs= stmt.executeQuery();
		while(rs.next()) {
			Category c=new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			categoryList2.add(c);
	      }
		dbUtil.close(rs, stmt, conn);
		return categoryList2;
	}
	
	
	// admin -> 카테고리 관리-> 카테고리 목록
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> categoryList=null;
		categoryList=new ArrayList<Category>();
		String sql= "SELECT"
				+ "	category_no categoryNo"
				+ ", category_Kind categoryKind"
				+ ", category_name categoryName"
				+ ", updatedate"
				+ ", createdate"
				+ " FROM category";
		DBUtil dbUtil=new DBUtil();
		// db자원(jdbc api자원) 초기화
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		rs=stmt.executeQuery();
		
		while(rs.next()) {
			Category c=new Category();
			c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); <-1은 SELECT절의 순서
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate")); // DB의 날짜 타입이지만 자바단에서 문자열 타입으로 받는다 프로그램상에서 날짜 형태로 사용할 일이 없기 때문
			c.setCreatedate(rs.getString("createdate"));
			categoryList.add(c);
		}
		
		//Query->resultSet(테이블)반환 SELECT는 Query/Update 둘 다 쓸 수 있음
		//Update->행을 반환 //execute는 쿼리를 실행한다는 뜻 
		
		// db자원(jdbc api자원) 반납
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
}