package kr.or.iei.notice.model.vo;

import java.util.ArrayList;

public class NoticeViewData {
	private Notice n;
	private ArrayList<NoticeComment> commentList;
	private ArrayList<NoticeComment>     recoomentList;
	public NoticeViewData() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NoticeViewData(Notice n, ArrayList<NoticeComment> commentList, ArrayList<NoticeComment> recoomentList) {
		super();
		this.n = n;
		this.commentList = commentList;
		this.recoomentList = recoomentList;
	}
	public Notice getN() {
		return n;
	}
	public void setN(Notice n) {
		this.n = n;
	}
	public ArrayList<NoticeComment> getCommentList() {
		return commentList;
	}
	public void setCommentList(ArrayList<NoticeComment> commentList) {
		this.commentList = commentList;
	}
	public ArrayList<NoticeComment> getRecoomentList() {
		return recoomentList;
	}
	public void setRecoomentList(ArrayList<NoticeComment> recoomentList) {
		this.recoomentList = recoomentList;
	}
	
}
