package kr.or.iei.notice.model.vo;

public class NoticeComment {
	private int ncNo;
	private String ncWritier;
	private String ncContent;
	private String ncDate;
	private int noticeRef;
	private int ncRef;
	
	public NoticeComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public NoticeComment(int ncNo, String ncWritier, String ncContent, String ncDate, int noticeRef, int ncRef) {
		super();
		this.ncNo = ncNo;
		this.ncWritier = ncWritier;
		this.ncContent = ncContent;
		this.ncDate = ncDate;
		this.noticeRef = noticeRef;
		this.ncRef = ncRef;
	}
	
	public int getNcNo() {
		return ncNo;
	}
	public void setNcNo(int ncNo) {
		this.ncNo = ncNo;
	}
	public String getNcWritier() {
		return ncWritier;
	}
	public void setNcWritier(String ncWritier) {
		this.ncWritier = ncWritier;
	}
	public String getNcContent() {
		return ncContent;
	}
	public void setNcContent(String ncContent) {
		this.ncContent = ncContent;
	}
	public String getNcDate() {
		return ncDate;
	}
	public void setNcDate(String ncDate) {
		this.ncDate = ncDate;
	}
	public int getNoticeRef() {
		return noticeRef;
	}
	public void setNoticeRef(int noticeRef) {
		this.noticeRef = noticeRef;
	}
	public int getNcRef() {
		return ncRef;
	}
	public void setNcRef(int ncRef) {
		this.ncRef = ncRef;
	}

}
