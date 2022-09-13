<%@page import="kr.or.iei.notice.model.vo.NoticeComment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.iei.notice.model.vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    	Notice n = (Notice)request.getAttribute("n");
		ArrayList<NoticeComment> commentList=
		(ArrayList<NoticeComment>)request.getAttribute("commentList");
		ArrayList<NoticeComment> reCommentList=
		(ArrayList<NoticeComment>)request.getAttribute("reCommentList");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#noticeView th, #noticeView td {
	border: 1px solid #eee;
}

#noticeContent {
	min-height: 300px;
	text-align: left;
	font-family: ns-light
}

.inputCommentBox {
	margin: 50px;
}

.inputCommentBox>form>ul {
	list-style-type: none;
	display: flex;
}

.inputCommentBox>form>ul>li:first-child {
	display: flex;
	width: 15%;
	justify-content: center;
	align-items: center
}

.inputCommentBox>form>ul>li:first-child>span {
	font-size: 80px;
	color: #ccc;
}

.inputCommentBox>form>ul>li:nth-child(2) {
	width: 75%;
}

.inputCommentBox>form>ul>li:nth-child(2)>textarea.input-form {
	height: 96px;
	min-height: 96px
}

.inputCommentBox>form>ul>li:last-child {
	width: 10%;
}

.inputReCommentBox {
	margin: 30px 0px;
	display:none;
}

.inputReCommentBox>form>ul {
	display: flex;
	list-style-type: none;
}

.inputReCommentBox>form>ul>li:first-child {
	width: 15%;
	display: flex;
	justify-content: center;
	align-items: center;
}
.inputReCommentBox>form>ul>li:first-child>span{
	font-size:50px;
	color:#ccc;	
}
.inputReCommentBox>form>ul>li:nth-child(2) {
	width: 75%;
	
}
.inputReCommentBox>form>ul>li:nth-child(2)>textarea.input-form {
	height:96px;
	min-height:96px;
}
.inputReCommentBox>form>ul>li:last-child {
	width: 10%;
	
}
</style>
<title>공지사항</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">공지사항</div>
		<table class="tbl" id="noticeView">
			<tr class="tr-3">
				<th colspan="6"><%=n.getNoticeTitle() %>
			</tr>
			<tr>
				<th class="td-3">작성자</th>
				<td><%=n.getNoticeWriter()%></td>
				<th class="td-3">조회수</th>
				<td><%=n.getReadCount()%></td>
				<th class="td-3">작성일</th>
				<td><%=n.getRegDate()%></td>
			</tr>
			<tr class="tr-1">
				<th class="td-3">첨부파일</th>
				<td colspan="5">
					<%if(n.getFilename() != null){%> <img alt="" src="/img/file.png"
					width="16px"> <a
					href="/noticeFileDown.do?noticeNo=<%=n.getNoticeNo()%>"><%=n.getFilename() %></a>
					<%} %>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<div id="noticeContent" style="white-space: pre"><%=n.getNoticeContent() %></div>
				</td>
			</tr>
			<%if(m!=null&&n.getNoticeWriter().equals(m.getMemberId())){ %>
			<tr class="tr-1">
				<th colspan="6"><a class="btn bc44"
					href="/noticeUpdateFrm.do?noticeNo=<%=n.getNoticeNo()%>">수정</a>
					<button class="btn bc44"
						onclick="noticeDelete(<%=n.getNoticeNo() %>);">삭제</button></th>
			</tr>
			<%} %>
		</table>
		<%if(m!=null){ %>
		<div class="inputCommentBox">
			<form action="insertComment.do" method="post">
				<ul>
					<li><span class="material-symbols-outlined">
					account_box
					</span></li>
					<li>
					<input type="hidden" name="ncWriter"
					value="<%=m.getMemberId() %>"> 
					<input type="hidden" name="noticeRef" value="<%=n.getNoticeNo()%>"> 
					<input type="hidden" name="ncRef" value="0"> 
						<textarea class="input-form" name="ncContent"></textarea>
					</li>
					<li>
						<button type="submit" class="btn bc1 bs4">등록</button>
					</li>
				</ul>

			</form>

		</div>
		<%}%>
		<div class="commentBox">
			<%for(NoticeComment nc: commentList){%>
			<ul class="posting-comment">
				<li>
					<span class="material-icons">account_box</span>
				</li>
				<li>
					<p class="comment-info">
						<span><%=nc.getNcWritier()%></span>
						<span><%=nc.getNcDate() %></span>
					</p>
					<p class="comment-content"><%=nc.getNcContent() %></p>
						<textarea name="ncContent" class="input-form" style="min-height:96px;display:none;"><%=nc.getNcContent() %></textarea>
					<p class="comment-link">
						<%if(m !=null){%>
							<%if(m.getMemberId().equals(nc.getNcWritier())){ %>
								<a href="javascript:void(0)" onclick="modifyComment(this,<%=nc.getNcNo()%>,<%=n.getNoticeNo()%>);">수정</a>
								<a href="javascript:void(0)" onclick="deleteComment(this,<%=nc.getNcNo()%>,<%=n.getNoticeNo()%>);">삭제</a>
							<%} %>
						<a href="javascript:void(0)" class="recShow">답글달기</a>
						<%}//로그인했을때만보이게 %>
					</p>
				</li>
			</ul>
			<%for(NoticeComment ncc: reCommentList){ %>
				<%if(ncc.getNcRef()==nc.getNcNo()){ %>
				<ul class ="posting-comment reply">
					<li>
						<span class="material-icons">subdirectory_arrow_right</span>
						<span class="material-icons">account_box</span>
					</li>
					<li><p>
						<span><%=ncc.getNcWritier() %></span>
						<span><%=ncc.getNcDate() %></span>
						</p>
						<p class="comment-content"><%=ncc.getNcContent()%></p>
						<textarea name="ncContent" class="input-form" style="min-height:96px;display:none;"><%=ncc.getNcContent() %></textarea>
						<p class="comment-link">
						<%if(m !=null){%>
							<%if(m.getMemberId().equals(ncc.getNcWritier())){ %>
								<a href="javascript:void(0)" onclick="modifyComment(this,<%=ncc.getNcNo()%>,<%=n.getNoticeNo()%>);">수정</a>
								<a href="javascript:void(0)" onclick="deleteComment(this,<%=ncc.getNcNo()%>,<%=n.getNoticeNo()%>);">삭제</a>
							<%} %>
						<%}//로그인했을때만보이게 %>
					</p>
					</li>
				</ul>
				<%}//해당댓글의 대댓글인지 체크하는 if문 종료 %>
			<%}//대댓글 출력 for문 종료 %>
			<%if(m !=null){ %>
			<div class="inputReCommentBox">
				<form action="/insertComment.do" method="post">
				<ul>
					<li>
						<span class="material-icons">subdirectory_arrow_right</span>
					</li>
					<li>
						<input type="hidden" name="ncWriter" value="<%=m.getMemberId() %>">
						<input type="hidden" name="noticeRef" value="<%=n.getNoticeNo() %>">
						<input type="hidden" name="ncRef" value="<%=nc.getNcNo()%>">
						<textarea class="input-form" name="ncContent"></textarea>
					</li>
					<li>
					<button type="submit" class="btn bc1 bs4">등록</button>
					</li>
				</ul>
				</form>
			</div>
				
				<%}//대댓글달기 form 조건문 %>
			<%}//댓글반복문종료%>
			
		</div>
	</div>
	<script>
			function noticeDelete(noticeNo){
				if(confirm("공지사항을 삭제하시겠습니까?")){
					location.href="/noticeDelete.do?noticeNo="+noticeNo;
				}else{
					return;
				}
			}
			
			$(".recShow").on("click",function(){
				const idx = $(".recShow").index(this);
				if($(this).text()=="답글달기"){
					$(this).text("취소");
				}else{
					$(this).text("답글달기");
				}
				$(".inputReCommentBox").eq(idx).toggle();
				$(".inputReCommentBox").eq(idx).find("textarea").focus();
			})
			
			function modifyComment(obj,ncNo,noticeNo){
				$(obj).parent().prev().show();//textarea출력
				$(obj).parent().prev().prev().hide();//화면을 보여주던 p태그 숨김
				$(obj).text("수정완료");
				$(obj).attr("onclick","modifyComplete(this,"+ncNo+","+noticeNo+")");
				$(obj).next().text("수정취소");
				$(obj).next().attr("onclick","modifyCancel(this,"+ncNo+","+noticeNo+")");
				//답글달기버튼 숨김
				$(obj).next().next().hide();
			}
			function modifyComplete(obj,ncNo,noticeNo){
				//form태그를 생성해서 전송
				const form = $("<form action='/noticeCommentUpdate.do' method='post'>");
				const ncInput = $("<input type='text' name ='ncNo'>");
				ncInput.val(ncNo);
				form.append(ncInput);
				
				const noticeInput = $("<input type='text' name='noticeNo'>");
				noticeInput.val(noticeNo);
				form.append(noticeInput);
				
				const ncContent = $(obj).parent().prev();
				form.append(ncContent);
				//body태그에 생성한 form 태그를 추가
				$("body").append(form);
				form.submit();
			}
			
			function modifyCancel(obj,ncNo,noticeNo){
				$(obj).parent().prev().hide();//textarea출력
				$(obj).parent().prev().prev().show();//화면을 보여주던 p태그 숨김
				$(obj).prev().text("수정");
				$(obj).prev().attr("onclick","modifyComment(this,"+ncNo+","+noticeNo+")");
				$(obj).text("삭제");
				$(obj).attr("onclick","deleteComment(this,"+ncNo+","+noticeNo+")");
				$(obj).next().show();
			}
			
			function deleteComment(obj,ncNo,noticeNo){
				if(confirm("댓글을 삭제하시겠습니까?")){
					location.href="/deleteNoticeComment.do?ncNo="+ncNo+"&noticeNo="+noticeNo;
				}	
			}
		</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>