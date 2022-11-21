package vo;

public class Category { // 도메인객체
	private int categoryNo; // 접근제한자 -public, private,... 정보은닉 : 접근제한자로 정보를 숨기는 것 자바는 정보은닉 없이는 캡슐화가 될 수 없다 /객체지향에서 중요한 4가지 : 추상화 상속 다형성 캡슐화
	private String categoryKind;
	private String categoryName;
	private String updatedate;
	private String createdate; // 컬럼은 자주쓰는 순서로 정렬하는 것이 좋음
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryKind() {
		return categoryKind;
	}
	public void setCategoryKind(String categoryKind) {
		this.categoryKind = categoryKind;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}

}
