package dao;

import java.util.ArrayList;
import util.*;
import java.sql.*;
import vo.*;

public class CategoryDao {
	
	// cashDateList.jsp
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
}
