package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Cash;
import vo.Category;

public class test2 {
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list=null;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		String sql = "SELECT c.cash_no cashNo"
				+ ", c.cash_date cashDate"
				+ ", c.cash_memo cashMemo"
				+ ", c.cash_price cashPrice"
				+ ", ct.category_kind categoryKind"
				+ ", ct.category_name categoryName"
				+ " FROM cash c INNER JOIN category ct"
				+ " ON c.category_no=ct.category_no"
				+ " WHERE c.member_id=?"
				+ " AND YEAR(c.cash_date)=?"
				+ " AND MONTH(c.cash_date)=?"
				+ " AND DAY(c.cash_date)=?"
				+ " ORDER BY c.cash_date ASC, ct.category_kind ASC;";
		try {
			list=new ArrayList<HashMap<String, Object>>();
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs=stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
			     // m.put()
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				list.add(m);
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
		return list;
	}
	
	/// cashUpdateForm.jsp
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
	
		// 가계부 내용 추가 insertCashAction.jsp
		public int insertCashList(String memberId, Cash cash) {
			int resultRow = 0;
			DBUtil dbUtil=null;
			Connection conn=null;
			PreparedStatement stmt=null;
			String sql = "INSERT INTO cash("
					+ "category_no, member_id"
					+ ", cash_date, cash_price"
					+ ", cash_memo, updatedate, createdate)"
					+ " values(?, ?, ?, ?, ?, CURDATE(), CURDATE())";
			try {
				dbUtil=new DBUtil();
				conn=dbUtil.getConnection();
				stmt=conn.prepareStatement(sql);
				stmt.setInt(1, cash.getCategoryNo());
				stmt.setString(2, cash.getMemberId());
				stmt.setString(3, cash.getCashDate());
				stmt.setLong(4, cash.getCashPrice());
				stmt.setString(5, cash.getCashMemo());
				resultRow = stmt.executeUpdate();
			} catch(Exception e) {
		         e.printStackTrace();
		      } finally {
		         try {
		        	 dbUtil.close(null, stmt, conn);
		         } catch(Exception e) {
			            e.printStackTrace();
			         }
		      }
			return resultRow;
		}
	
		
		
		
		
		public int countRow (String loginMember, ) {
			int row=0;
			
			
			return row;
		}
		
		
		
		
		
		
		<%
		for (int i=1; i<totalTd; i++) {
	%>
			<td>
	<%
				int date = i-beginBlank;
				if(date > 0 && date <= lastDate) {
	%>
				
				<div><%=date%></div>
				<div>
			
					<%
						int num=0;
						String cate=null;
						for(HashMap<String, Object> m:list2) {
							String cashDate=(String)(m.get("cashDate"));
							if(Integer.parseInt(cashDate.substring(8)) == date) {
								if(cashListCnt != 0) {
									cate="Cash";
									num=1;
								}
								if(cate != null || num != 0) {
									
					%>
									+<%=cate%> <%=num+1%>
									<br>	
				<%	
								}
							}
						}
					}
				%>
				</div>
			</td>
	<% 
			if(i % 7 == 0 && i != totalTd) {
	%>
			</tr><tr> <!-- td 7개 만들고 테이블 줄바꿈 -->
	<%
			}
		}
	%>
		
		
		
		
		

		
		
		
		
		
