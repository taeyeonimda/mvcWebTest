package kr.or.iei.notice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.notice.model.service.NoticeService;
import kr.or.iei.notice.model.vo.NoticeViewData;

/**
 * Servlet implementation class NoticeListServlet
 */
@WebServlet(name = "NoticeView", urlPatterns = { "/noticeView.do" })
public class NoticeViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NoticeViewServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1.인코딩
		request.setCharacterEncoding("utf-8");
		// 2.값추출
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		
		// 3.비즈니스로직
		NoticeService service = new NoticeService();
		NoticeViewData nvd = service.selectOneNotice(noticeNo);
		// 4.결과처리
		if (nvd == null) {
			RequestDispatcher view = request.getRequestDispatcher("WEB-INF/views/cmmon/msg.jsp");
			request.setAttribute("title", "조회실패");
			request.setAttribute("msg", "게시글이 존재하지않습니다");
			request.setAttribute("icon", "info");
			request.setAttribute("loc", "/noticeList.do?reqPage=1");
		} else {
			RequestDispatcher view = request.getRequestDispatcher("WEB-INF/views/notice/noticeView.jsp");
			request.setAttribute("n", nvd.getN());
			request.setAttribute("commentList", nvd.getCommentList());
			request.setAttribute("reCommentList", nvd.getRecoomentList());
			view.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
