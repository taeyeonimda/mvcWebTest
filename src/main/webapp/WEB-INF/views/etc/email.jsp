<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EMAIL API</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">EMAIL-API</div>
		<h3>Email 접속하기</h3>
		<form action="/mailSend1.do" method="post">
			<table class="tbl">
				<tr class="tr-1">
					<th class="td-2">제목</th>
					<td><input type="text" name="mailTitle" class="input-form"></td>
				</tr>
				<tr class="tr-1">
					<th class="td-2">수신자이메일</th>
					<td><input type="text" name="receiver" class="input-form"></td>
				</tr>
				<tr class="tr-1">
					<th class="td-2">내용</th>
					<td><textarea name ="mailContent" class="input-form"></textarea></td>
				</tr>
				<tr class="tr-1">
					<th colspan="2">
					<button class ="btn bc1 bs4" type="submit">전송</button>
					</th>
				</tr>
			</table>
		</form>
		<h3>이메일인증</h3>
		<input type="text" id="email" placeholder="이메일 입력">
		<button type="button" class="btn bc1" onclick ="sendMail();">인증메일전송</button>
		<div id="auth" style="display:none;">
			<input type="text" id="authCode" placeholder="인증코드입력">
			<button class="btn bc1" id="authBtn">인증하기</button>
			<span id="timeZone"></span>
			<span id="authMsg"></span>
		</div>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
	<script type="text/javascript">
	let mailCode;
		function sendMail(){
			const email = $("#email").val();
			$.ajax({
				url:"/sendMail2.do",
				data:{email:email},
				type:"post",
				success : function(data){
					if(data !=null){
						mailCode=data;
						$("#auth").show();
						authTime();
					}
				}
			});
			
		}
		let intervalId;
		function authTime(){
			$("#timeZone").html("<span id='min'>3</span>:<span id='sec'>00</span>");	
			intervalId = window.setInterval(function(){
				timeCount();
			},200);
		};
		
		function timeCount(){
			const min = Number($("#min").text());
			const sec = $("#sec").text();
			if(sec == "00"){
				if(min==0){
					mailCode = null;
					clearInterval(intervalId);
				}else{
					$("#min").text(min-1);
					$("#sec").text(59);
				}
			}else{
				const newSec = Number(sec)-1;
				if(newSec<10){
					$("#sec").text("0"+newSec);
				}else{
					$("#sec").text(newSec);
				}
			}
		}
		
		$("#authBtn").on("click",function(){
			const inputValue = $("#authCode").val();
			if(mailCode !=null){
				if(inputValue==mailCode){
					$("#authMsg").text("인증성공");
					$("#authMsg").css("color","blue");
					clearInterval(intervalId);
					//$("#timeZone").hide();
				}else{
					$("#authMsg").text("인증실패");
					$("#authMsg").css("color","red");
				}		
			}else{
				$("#authMsg").text("인증 시간 만료");
				$("#authMsg").css("color","red");
			}
		});
	</script>
</body>
</html>