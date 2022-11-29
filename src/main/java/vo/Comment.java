package vo;

public class Comment {
	private int helpNo;
	private int commentNo;
	private String memberId; // 답변한 관리자 아이디
	private String commentMemo;
	private String updatedate;
	private String createdate;
	public int getHelpNo() {
		return helpNo;
	}
	public void setHelpNo(int helpNo) {
		this.helpNo = helpNo;
	}
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getCommentMemo() {
		return commentMemo;
	}
	public void setCommentMemo(String commentMemo) {
		this.commentMemo = commentMemo;
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
