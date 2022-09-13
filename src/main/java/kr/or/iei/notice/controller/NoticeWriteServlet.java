package kr.or.iei.notice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.or.iei.notice.model.service.NoticeService;
import kr.or.iei.notice.model.vo.Notice;
import kr.or.iei.notice.model.vo.NoticePageData;

/**
 * Servlet implementation class NoticeListServlet
 */
@WebServlet(name = "NoticeWrite", urlPatterns = { "/noticeWrite.do" })
public class NoticeWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeWriteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.인코딩
		request.setCharacterEncoding("utf-8");
		//2.값추출
		//multipart/form-data(파일업로드) 형식이면 꺼낸 후 추출
		//2-1 파일이 업로드될 경로를 지정
		String root = getServletContext().getRealPath("/");//webapp폴더의 절대 경로
		String saveDirectory = root+"upload/notice";
		//2-2 파일 업로드 최대 용량 설정
		int maxSize = 10*1024*1024;
		//2-3 multipart/form-data에서 데이터를 꺼내기위한 객체
		//request->MultipartRequest객체변환
		//매개변수 5개를 전달하면서 객체 생성
		// 1.request 2.파일저장경로 3.파일최대크기 4.인코딩타입 5.파일명 중복처리객체
		MultipartRequest mRequest=
		new MultipartRequest(request,saveDirectory,maxSize,"UTF-8",new DefaultFileRenamePolicy());
		String noticeTitle = mRequest.getParameter("noticeTitle");
		String noticeWriter = mRequest.getParameter("noticeWriter");
		String noticeContent = mRequest.getParameter("noticeContent");
		//실제로 화면에서 첨부한 원본파일 이름
		String filename = mRequest.getOriginalFileName("upfile");
		//실제 서버에 업로드된 파일 이름(중복처리 완료 후)
		String filePath = mRequest.getFilesystemName("upfile");
		Notice n = new Notice();
		n.setNoticeTitle(noticeTitle);
		n.setNoticeWriter(noticeWriter);
		n.setNoticeContent(noticeContent);
		n.setFilename(filename);
		n.setFilepath(filePath);
		//3.비즈니스로직
		NoticeService service = new NoticeService();
		int result = service.insertNotice(n);
		//4.결과처리
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		if(result>0) {
			request.setAttribute("title", "성공");
			request.setAttribute("msg","공지사항이 등록되었습니다");
			request.setAttribute("icon", "success");
		}else {
			request.setAttribute("title", "실패");
			request.setAttribute("msg","공지사항 등록에 실패하였습니다.");
			request.setAttribute("icon", "fail");
		}
		request.setAttribute("loc", "/noticeList.do?reqPage=1");
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
