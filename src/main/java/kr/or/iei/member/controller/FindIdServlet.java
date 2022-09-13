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
@WebServlet(name = "FindId", urlPatterns = { "/findId.do" })
public class FindIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindIdServlet() {
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
		String memberName = request.getParameter("memberName");
		String memberPhone = request.getParameter("memberPhone");
		//3. 비즈니스로직
		MemberService service = new MemberService();
		Member member = service.findId(memberName,memberPhone);
		//4. 결과처리
		RequestDispatcher view = 
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		if(member !=null) {
			request.setAttribute("findMember", member);
			request.setAttribute("title", "회원 님의 아이디는 "+member.getMemberId()+"입니다.");
			request.setAttribute("msg","");
			request.setAttribute("icon", "success");	
		}else {
			request.setAttribute("title","아이디 찾기 실패");
			request.setAttribute("msg", "없는 아이디 입니다.");
			request.setAttribute("icon", "error");
		}
		
		//4-1. 결과처리할 페이지를 지정	
		request.setAttribute("loc","/findIdFrm.do");
		
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
