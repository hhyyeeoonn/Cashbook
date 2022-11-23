package dao;

import java.util.ArrayList;
import util.*;
import java.sql.*;
import vo.*;

public class CategoryDao {
	
	// 
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
		conn.close();
		return categoryList;
	}
	
}
