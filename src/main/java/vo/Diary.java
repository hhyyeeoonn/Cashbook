package vo;

public class Diary {
	private int diaryId;
	private String memberId;
	private String diaryMemo; // longtext
	private String updatedate;
	private String createdate;
	public int getDiaryId() {
		return diaryId;
	}
	public void setDiaryId(int diaryId) {
		this.diaryId = diaryId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getDiaryMemo() {
		return diaryMemo;
	}
	public void setDiaryMemo(String diaryMemo) {
		this.diaryMemo = diaryMemo;
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
