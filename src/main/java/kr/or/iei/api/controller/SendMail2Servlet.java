package kr.or.iei.api.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EmailControllerServlet
 */
@WebServlet(name = "SendMail2", urlPatterns = { "/sendMail2.do" })
public class SendMail2Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendMail2Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String email = request.getParameter("email");

		MailSender sender = new MailSender();
		String randomCode = sender.sendMail2(email);
		PrintWriter out = response.getWriter();
		out.print(randomCode);
		
//		RequestDispatcher view =
//				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
//		if(result) {
//			request.setAttribute("title", "메일전송");
//			request.setAttribute("msg", "성공");
//			request.setAttribute("icon", "success");
//		}else {
//			request.setAttribute("title", "메일전송");
//			request.setAttribute("msg", "실패");
//			request.setAttribute("icon", "error");
//		}
//		request.setAttribute("loc", "/");
//		view.forward(request, response);
	}	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
