package dao;

import java.util.ArrayList;
import util.*;

import java.net.URLEncoder;
import java.sql.*;
import vo.*;

public class CategoryDao {
	
	// 삭제
	public int deleteCatory(int categoryNo) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "DELETE FROM category WHERE category_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			row = stmt.executeUpdate();
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
	
	
	// 수정: 수정폼(select)과 수정액션(action)으로 구성
	// /admin/updateCategoryAction.jsp
	public int updateCategoryName(Category category) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE category"
					+" SET category_name = ?, updatedate = CURDATE()"
					+" WHERE category_no = ?";
		try {
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setInt(2, category.getCategoryNo());
			row = stmt.executeUpdate();
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
	
	// /admin/updateCategory.jsp
	public Category selectCategoryOne(int categoryNo) {
		Category category = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT category_kind categoryKind, category_name categoryName"
					+" FROM category"
					+" WHERE category_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				category = new Category();
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
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
		return category;
	}
	
	
	// /admin/insertCategoryAction.jsp
	public int insertCategory(Category category) {
		int row=0;
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		String sql="INSERT INTO category ("
				+ " category_kind"
				+ ", category_name"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?, ?, CURDATE(), CURDATE())";
		try {
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			row=stmt.executeUpdate();
		}  catch(Exception e) {
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
	
	// 카테고리 중복확인 /admin/insertCategoryAction.jsp 
	public String WrongCategory(Category category) {
		String NmMsg=null;
		String targetUrl=null;
		DBUtil dbUtil = new DBUtil();
		Connection conn=null;
		String NmSql="SELECT category_name FROM category WHERE category_name=? AND category_kind=?";
		try {
			conn=dbUtil.getConnection();
			PreparedStatement NmStmt = conn.prepareStatement(NmSql);
			NmStmt.setString(1, category.getCategoryName());
			NmStmt.setString(2, category.getCategoryKind());
			ResultSet rs = NmStmt.executeQuery();
			if(rs.next()){
				NmStmt=conn.prepareStatement(NmSql);
				NmMsg=URLEncoder.encode("이미 존재하는 카테고리입니다", "utf-8"); 
				targetUrl="/admin/insertCategoryList.jsp?NmMsg="+NmMsg;
			}
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(null, null, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		
		return targetUrl;
	}
	
	// 카테고리 중복확인 /admin/updateCategoryAction.jsp
	public String WrongCategory2(Category category) {
		String NmMsg=null;
		String targetUrl=null;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement NmStmt=null;
		ResultSet rs=null;
		String NmSql="SELECT category_name FROM category WHERE category_name=? AND category_kind=?";
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			NmStmt=conn.prepareStatement(NmSql);
			NmStmt.setString(1, category.getCategoryName());
			NmStmt.setString(2, category.getCategoryKind());
			rs=NmStmt.executeQuery();
			if(rs.next()){
				NmMsg=URLEncoder.encode("이미 존재하는 카테고리입니다", "utf-8"); 
				targetUrl="/admin/updateCategoryList.jsp?categoryNo="+(category.getCategoryNo())+"&NmMsg="+NmMsg;
			}
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(rs, NmStmt, conn);
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		return targetUrl;
	}
	
	// cash 입력시 카테고리 select목록 cashDateList.jsp
	public ArrayList<Category> selectCategoryList() {
		ArrayList<Category> categoryList=null;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		String sql="SELECT category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ " FROM category ORDER BY category_kind";
		try {
			dbUtil = new DBUtil();
			categoryList = new ArrayList<Category>();
			conn = dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			rs= stmt.executeQuery();
			while(rs.next()) {
				Category c=new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				categoryList.add(c);
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
		return categoryList;
	}
	
	// cashUpdateForm.jsp
	public ArrayList<Category> selectCategoryList2(String categoryKind) {
		String sql=null;
		ArrayList<Category> categoryList2=null;
		PreparedStatement stmt=null;
		DBUtil dbUtil=null;
		Connection conn=null;
		ResultSet rs=null;
		if(categoryKind.equals("지출")) {
			sql="SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_kind='지출' ORDER BY category_kind";
		} else {
			sql="SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_kind='수입' ORDER BY category_kind";
		}
		try {
			dbUtil=new DBUtil();
			categoryList2=new ArrayList<Category>();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			rs= stmt.executeQuery();
			while(rs.next()) {
				Category c=new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				categoryList2.add(c);
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
		return categoryList2;
	}
	
	
	// admin -> 카테고리 관리-> 카테고리 목록
	public ArrayList<Category> selectCategoryListByAdmin() {
		ArrayList<Category> categoryList=null;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		String sql= "SELECT"
				+ "	category_no categoryNo"
				+ ", category_Kind categoryKind"
				+ ", category_name categoryName"
				+ ", updatedate"
				+ ", createdate"
				+ " FROM category";
		try {
			categoryList=new ArrayList<Category>();
			dbUtil=new DBUtil(); // db자원(jdbc api자원) 초기화
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
		} catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	        	 dbUtil.close(rs, stmt, conn); // db자원(jdbc api자원) 반납
	         } catch(Exception e) {
		            e.printStackTrace();
		         }
	      }
		//Query->resultSet(테이블)반환 SELECT는 Query/Update 둘 다 쓸 수 있음
		//Update->행을 반환 //execute는 쿼리를 실행한다는 뜻 
		return categoryList;
	}
}