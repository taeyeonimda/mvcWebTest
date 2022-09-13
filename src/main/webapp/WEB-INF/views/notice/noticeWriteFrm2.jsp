<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<style type="text/css">
#noticeWrite td, #noticeWrite th {
	border: 1px solid #ccc;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">공지사항 작성 (에디터사용)</div>
		<form action="/noticeWrite.do" method="post"
			enctype="multipart/form-data">
			<table class="tbl" id="noticeWrite">
				<tr class="tr-1">
					<th class="td-3">제목</th>
					<td colspan="3">
						<input type="text" name="noticeTitle" class="input-form">
					</td>
				</tr>
				<tr class="tr-1">
					<th class="td-3">작성자</th>
					<td>
						<%=m.getMemberId() %>
						<input type="hidden" name="noticeWriter" value="<%=m.getMemberId() %>">
					</td>
					<th class="td-3">첨부파일</th>
					<td><input type="file" name="upfile"></td>
				</tr>
				<tr class="tr-1">
					<th class="td-3">내용</th>
					<td colspan="3" style="text-align:left;">
						<textarea id="noticeContent" name="noticeContent" class="input-form"></textarea>
					</td>
				</tr>
				<tr class="tr-1">
					<td colspan="4">
					<button type="submit" class="btn bc1 bs4">공지사항 작성</button>
				</tr>
			</table>
		</form>
	</div>
	<script>
	
	$(document).ready(function() {
		//여기 아래 부분
		$('#noticeContent').summernote({
			  height: 400,                 // 에디터 높이
			  minHeight: null,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",					// 한글 설정
			  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
			  callbacks:{
				  onImageUpload : function(files){
					  uploadImage(files[0],this);
				  }
			  }
		});
	});

	function uploadImage(file,editor){
		//ajax를 통해서 서버에 이미지를 업로드
		//업로드된 이미지의 경로를 받아오는 역할
		const form = new FormData();
		form.append("file",file);
		$.ajax({
			url : "/uploadImage.do",
			type:"post",
			data: form,
			contentType: false,
            processData: false,
            enctype	: 'multipart/form-data',
			success:function(data){
				$(editor).summernote("insertImage",data);
				console.log(data);
			}
			//process데이터 전송하면 데이터를 문자열로 전송하게 되있음 파일로 전송하기 위해 false
			
		})
	}
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>