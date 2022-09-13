package kr.or.iei.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.member.model.service.MemberService;
import kr.or.iei.member.model.vo.Member;

/**
 * Servlet implementation class SigninServlet
 */
@WebServlet(name = "CheckedChangeLevel", urlPatterns = { "/checkedChangeLevel.do" })
public class CheckedChangeLevelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckedChangeLevelServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 인코딩
		request.setCharacterEncoding("utf-8");
		//2. 값추출
		String num = request.getParameter("num");
		String level = request.getParameter("level");
		//3. 비즈니스로직
		MemberService service = new MemberService();
		boolean result = service.checkedChangeLevel(num,level);
		//4. 결과처리
		RequestDispatcher view = 
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		if(result) {
			request.setAttribute("title", "변경완료" );
			request.setAttribute("msg","요청이 처리 되었습니다.");
			request.setAttribute("icon","success");
		}else {
			request.setAttribute("title", "변경실패" );
			request.setAttribute("msg","요청이 처리 실패하였습니다..");
			request.setAttribute("icon","warning");
		}
		//4-1. 결과처리할 페이지를 지정
		request.setAttribute("loc", "/adminPage.do");
		view.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
