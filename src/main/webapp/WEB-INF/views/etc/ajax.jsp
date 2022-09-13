<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX</title>
<style type="text/css">
.ajaxResult {
	min-hieght: 100px;
	border: 2px solid #ccc;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<div class ="page-content">
		<div class="page-title">AJAX</div>
		<h3>1.서버 호출하기</h3>
		<button class="btn bc11" id="js">js방식</button>
		<button class="btn bc11" id="jQ1">jQuery방식</button>
		
		<h3>2.서버로 값 전송하기</h3>
		<input type="text">
		<button class="btn bc11" id="jQ2">전송</button>
		
		<h3>3.서버로 데이터 전송하고 서버에서 데이터 받기(기본형 데이터 받기)</h3>
		<input type="text" id="su1">
		<input type="text" id="su2">
		<button class="btn bc11" id="jQ3">더하기</button>
		<p class="ajaxResult" id="result1"></p>
		
		<h3>4. 서버로 데이터 전송하고 서버에서 객체 데이터 받기</h3>
		<input type="text" id="input4">
		<button class="btn4 bc11" id="jQ4">회원정보조회</button>
		<p class="ajaxResult" id="result4"></p>
		
		<h3>5. 서버에서 데이터 리스트로 받기</h3>
		<button class="btn bc11" id="jQ5">전체회원조회</button>
		<p class="ajaxResult" id="result5">
		
		<h3>6. 서버로 데이터 전송하고 서버에서 객체 데이터 받기</h3>
		<input type="text" id="input6">
		<button class="btn4 bc11" id="jQ6">회원정보조회(GSON)</button>
		<p class="ajaxResult" id="result6"></p>
		
		<h3>7. 서버에서 데이터 리스트로 받기</h3>
		<button class="btn bc11" id="jQ7">전체회원조회(GSON)</button>
		<p class="ajaxResult" id="result7"></p>
		
		<h3>8. 비동기 테스트</h3>
		<button class="btn bc11" id="jQ8">비동기호출테스트</button>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp" %>
	<script>
		$("#js").on("click",function(){
			//XMLHttpRequest생성
			const xhttp = new XMLHttpRequest();
			//요청정보 설정
			//요청메소드 url 비동기여부
			xhttp.open("GET","/ajaxTest1.do",true);
			//서버요청 처리에 따른 동작함수를 설정
			xhttp.onreadystatechange =function(){
			if(this.readyState ==4&&this.status==200){
					//요청이 다 끝나고 정상인 경우
				}else if(this.readyState ==4&& this.status==404){
					//404페이지설정
					console.log("주소를 찾을수 없습니다.");
				}
			}
			//서버에 요청
			xhttp.send();
		})
		
		$("#jQ1").on("click",function(){
			$.ajax({
				url : "/ajaxTest1.do",
				type: "get",
				success : function(){
					console.log("서버호출완료");
				},
				error: function(){
					console.log("에러발생");
				},
				complete:function(){
					console.log("무조건 호출");
				}
			})	
		});
		
		$("#jQ2").on("click",function(){
			const input = $(this).prev();
			const inputValue = input.val();
			$.ajax({
				url : "/ajaxTest2.do",
				type: "get",
				data : {input1 : inputValue},
				success : function(){
					console.log("서버로전송완료");
				},
				error: function(){
					console.log("에러발생");
				}
			})	
		});
		
		$("#jQ3").on("click",function(){
			const su1 = $("#su1").val();
			const su2 = $("#su2").val();
			$.ajax({
				url : "/ajaxTest3.do",
				type: "get",
				data:{su1:su1, su2:su2},
				success : function(result){
					$("#result1").text(result);
				},
				error: function(){
					$("#result1").text("잘못입력되었슴다");
				}
			})	
		});
		

		$("#jQ4").on("click",function(){
			const memberId = $("#input4").val();
			const result = $("#result4");
			$.ajax({
				url : "/ajaxTest4.do",
				type: "get",
				data:{memberId,memberId},
				dataType:"json",
				success : function(data){
					if(data ==null){
						result.append("회원정보를 조회 할수 없습니다.");
					}else{
						result.append("아이디: "+data.memberId+"<br>");
						result.append("이름: "+data.memberName+"<br>");
						result.append("전화번호 : "+data.memberPhone+"<br>");
					}
				}
			})	
		});
		
		
		$("#jQ5").on("click",function(){
			const result = $("#result5");
			result.empty();
			$.ajax({
				url : "/ajaxTest5.do",
				type: "get",
				dataType:"json",
				success : function(data){
					console.log(data);
					for(let i=0;i<data.length;i++){
					const div=$("<div></div>");
					div.append(data[i].memberId);
					div.append("/");
					div.append(data[i].memberName);
					div.append("/");
					div.append(data[i].memberAddr);
					result.append(div);
					}
				}
			})	
		});
		
		$("#jQ6").on("click",function(){
			const memberId = $("#input6").val();
			const result = $("#result6");
			result.text("");
			$.ajax({
				url : "/ajaxTest6.do",
				type: "get",
				data:{memberId,memberId},
				dataType:"json",
				success : function(data){
					if(data ==null){
						result.append("회원정보를 조회 할수 없습니다.");
					}else{
						result.append("아이디: "+data.memberId+"<br>");
						result.append("이름: "+data.memberName+"<br>");
						result.append("전화번호 : "+data.memberPhone+"<br>");
					}
				}
			})	
		});
		
		$("#jQ7").on("click",function(){
			const result = $("#result7");
			result.empty();
			$.ajax({
				url : "/ajaxTest7.do",
				type: "get",
				dataType:"json",
				success : function(data){
					console.log(data);
					for(let i=0;i<data.length;i++){
					const div=$("<div></div>");
					div.append(data[i].memberId);
					div.append("/");
					div.append(data[i].memberName);
					div.append("/");
					div.append(data[i].memberAddr);
					result.append(div);
					}
				}
			})	
		});		
		
		$("#jQ8").on("click",function(){
			let test=10;
			console.log("이벤트시작: "+test);
			$.ajax({
				url:"/ajaxTest8.do",
				success:function(data){
					test=data;
					console.log("ajax내부 : "+test);
				}
			}).then(function(){
				console.log("이벤트 then 끝 : "+ test);
			});
			console.log("이벤트 끝 :"+test);
		})
	</script>
</body>
</html>