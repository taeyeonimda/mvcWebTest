package kr.or.iei.notice.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.JDBCTemplate;
import kr.or.iei.notice.model.vo.Notice;
import kr.or.iei.notice.model.vo.NoticeComment;

public class NoticeDao {

	public ArrayList<Notice> selectNoticeList(Connection conn, int start, int end) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Notice> list = new ArrayList<>();
		String query = "select * from (select rownum as rnum,  "
				+ " n.* from (SELECT*FROM NOTICE order by notice_no desc)n) "
				+ " where rnum between ? and ?";
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rset=pstmt.executeQuery();
			while(rset.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rset.getInt("notice_no"));
				n.setNoticeTitle(rset.getString("notice_title"));
				n.setNoticeWriter(rset.getString("notice_writer"));
				n.setNoticeContent(rset.getString("notice_content"));
				n.setReadCount(rset.getInt("read_count"));
				n.setRegDate(rset.getString("reg_date"));
				n.setFilename(rset.getString("filename"));
				n.setFilepath(rset.getString("filepath"));
				list.add(n);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public int selectNoticeCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalCount = 0;
		String query = "select count(*) as cnt from notice";
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalCount = rset.getInt("cnt");
			}
			} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return totalCount;
	}

	public int insertNotice(Connection conn, Notice n) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into notice values(notice_seq.nextval,  "
				+ " ?, ?, ?, 0, to_char(sysdate,'yyyy-mm-dd'), ?, ?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, n.getNoticeTitle());
			pstmt.setString(2, n.getNoticeWriter());
			pstmt.setString(3, n.getNoticeContent());
			pstmt.setString(4, n.getFilename());
			pstmt.setString(5, n.getFilepath());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public Notice selectOneNotice(Connection conn, int noticeNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Notice n = null;
		String query = "select * from notice where notice_no = ? ";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1,noticeNo);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				n = new Notice();
				n.setFilename(rset.getString("filename"));
				n.setFilepath(rset.getString("filepath"));
				n.setNoticeContent(rset.getString("notice_content"));
				n.setNoticeNo(rset.getInt("notice_no"));
				n.setNoticeTitle(rset.getString("notice_title"));
				n.setNoticeWriter(rset.getString("notice_writer"));
				n.setReadCount(rset.getInt("read_count"));
				n.setRegDate(rset.getString("reg_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return n;
	}

	public int updateReadCount(Connection conn, int noticeNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query= "update notice set read_count = read_count+1"
				+ " where notice_no = ? ";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1,noticeNo);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int deleteNotice(Connection conn, int noticeNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from notice where notice_no = ? ";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int updateNotice(Connection conn, Notice n) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "update notice  "
				+ " set notice_title=?, "
				+ " notice_content=?, filename=?, filepath=? "
				+ " where notice_no = ? ";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,n.getNoticeTitle());
			pstmt.setString(2,n.getNoticeContent());
			pstmt.setString(3, n.getFilename());
			pstmt.setString(4, n.getFilepath());
			pstmt.setInt(5, n.getNoticeNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int insertNoticeComment(Connection conn, NoticeComment nc) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into NOTICE_COMMENT values"
				+ " (nc_seq.nextval, ? ,?, to_char(sysdate,'yyyy-mm-dd'),?, ?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, nc.getNcWritier());
			pstmt.setString(2, nc.getNcContent());
			pstmt.setInt(3, nc.getNoticeRef());
//			if(nc.getNcRef()==0) {
//				pstmt.setString(4, null);
//			}else {
//				pstmt.setInt(4, nc.getNcRef());
//			}
			pstmt.setString(4, (nc.getNcRef()==0)?null:String.valueOf(nc.getNcRef()));
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public ArrayList<NoticeComment> selectNoticeCommentList(Connection conn, int noticeNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<NoticeComment>list = new ArrayList<NoticeComment>();
		String query= "select * from notice_comment where notice_ref=? and nc_ref is null order by 1";
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			rset=pstmt.executeQuery();
			while(rset.next()) {
				NoticeComment nc = new NoticeComment();
				nc.setNcContent(rset.getString("nc_content"));
				nc.setNcDate(rset.getString("nc_date"));
				nc.setNcNo(rset.getInt("nc_no"));
				nc.setNcRef(rset.getInt("nc_ref"));
				nc.setNcWritier(rset.getString("nc_writer"));
				nc.setNoticeRef(rset.getInt("notice_ref"));
				list.add(nc);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public ArrayList<NoticeComment> selectNoticeReCommentList(Connection conn, int noticeNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<NoticeComment>list = new ArrayList<NoticeComment>();
		String query= "select * from notice_comment where notice_ref=? and nc_ref is not null order by 1";
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			rset=pstmt.executeQuery();
			while(rset.next()) {
				NoticeComment nc = new NoticeComment();
				nc.setNcContent(rset.getString("nc_content"));
				nc.setNcDate(rset.getString("nc_date"));
				nc.setNcNo(rset.getInt("nc_no"));
				nc.setNcRef(rset.getInt("nc_ref"));
				nc.setNcWritier(rset.getString("nc_writer"));
				nc.setNoticeRef(rset.getInt("notice_ref"));
				list.add(nc);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public int updateNoticeComment(Connection conn, NoticeComment nc) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "update notice_comment set nc_content=? where nc_no=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, nc.getNcContent());
			pstmt.setInt(2, nc.getNcNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int deleteNoticeComment(Connection conn,int ncNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete notice_comment where nc_no=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, ncNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

}
