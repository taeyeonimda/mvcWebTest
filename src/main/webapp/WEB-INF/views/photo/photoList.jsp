<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int totalCount = (Integer)request.getAttribute("totalCount");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 게시판</title>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">사진 게시판<%=totalCount %></div>
		<%if(m!=null){ %>
		<a href="/photoWriteFrm.do" class="btn bc4">글쓰기</a>
		<%} %>
		<div class="photoWrapper posting-wrap">
		
		</div>
		<button class="btn bc44 bs4" id="more-btn"
		totalCount="<%=totalCount %>" currentCount ="0" value="1">더보기</button>
		<!-- value:더보기 요청시 다음게시물 시작번호 --> 
		<!--  
		<div class="posting-wrap">
			<div class="posting-item">
				<div class="posing-img">
					<img alt="" src="/upload/photo/고독한얼굴.jpg" style="height:200px;">
				</div>
				<div class="posting-content">
					<p>내용내용</p>
					<p>내용내용</p>
				</div>
			</div>
		</div>-->
	</div>
	<script type="text/javascript">
		$("#more-btn").on("click",function(){
			const amount = 5;//더보기 클릭시 추가로 가져올 게시물 수 
			let start = $(this).val();
			$.ajax({
				url:"/photoMore.do",
				type:"post",
				data:{start:start,amount:amount},
				success: function(data){
					console.log(data);
					for(let i =0;i<data.length;i++){
						const p = data[i];
						const div = $("<div>");
						div.addClass("posting-item");
						
						const imgDiv = $("<div>");
						imgDiv.addClass("posting-img");
						
						const img = $("<img>")
						img.attr("src","/upload/photo/"+p.filePath);
						
						imgDiv.append(img);
						
						const titleDiv = $("<div>");
						titleDiv.addClass("posting-content");
						const title = $("<p>")
						title.append(p.photoTitle);
						
						titleDiv.append(title);
						
						div.append(imgDiv).append(titleDiv);
						$(".photoWrapper").append(div);
					}//for문끝
					//화면 추가 완료 후 다음 더보기를 위한 값 수정
					//value 증가 ->기존value +amount
					$("#more-btn").val(Number(start)+Number(amount));
					//currentCount값도 읽어온만큼만 수정
					const currentCount = Number($("#more-btn").attr("currentCount"))+data.length;
					$("#more-btn").attr("currentCount",currentCount);
					const totalCount = $("#more-btn").attr("totalCount");
					if(currentCount==totalCount){
						$("#more-btn").attr("disabled",true);
						
					}
				},
				error : function(e){
					console.log(e+"에러");
				}
			})//ajax끝
		})
		$("#more-btn").click();
	</script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>