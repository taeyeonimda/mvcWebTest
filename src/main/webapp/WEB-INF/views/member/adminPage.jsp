<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    	ArrayList<Member> list = (ArrayList<Member>)request.getAttribute("list");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>

	<div class="page-content">
		<div class="page-title">관리자 페이지</div>
		<table class="tbl tbl-hover">
			<tr class="tr-3">
				<th>선택</th>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>가입일</th>
				<th>회원등급</th>
				<th>등급변경</th>
			</tr>

			<%for (Member member:list){ %>
			<tr class="tr-1">
				<td><input type="checkbox" class="chk"></td>
				<td><%=member.getMemberNo() %></td>
				<td><%=member.getMemberId() %></td>
				<td><%=member.getMemberName() %></td>
				<td><%=member.getMemberPhone() %></td>
				<td><%=member.getMemberAddr() %></td>
				<td><%=member.getEnrollDate() %></td>
				<td>
					<%if(member.getMemberLevel()==1){ %> <select class="input-form">
						<option value="1" selected>관리자</option>
						<option value="2">정회원</option>
						<option value="3">준회원</option>
				</select> <%}else if(member.getMemberLevel()==2){ %> <select class="input-form">
						<option value="1">관리자</option>
						<option value="2" selected>정회원</option>
						<option value="3">준회원</option>
				</select> <%}else{ %> <select class="input-form">
						<option value="1">관리자</option>
						<option value="2">정회원</option>
						<option value="3" selected>준회원</option>
				</select> <%} %>

				</td>
				<td>
					<button class="btn bc5 changeLevel">등급 변경</button>
				</td>
			</tr>
			<%} %>
			<tr>
				<th colspan="9">
					<button class="btn bc44 bs4 checkedChangeLevel">선택회원 등급 변경</button>
			</tr>
		</table>
	</div>
	<script>
		$(".changeLevel").on("click",function(){
			//클릭한 버튼 기준으로 해당 회원의 번호
			const memberNo = $(this).parent().parent().children().eq(1).text();
			//클릭한 버튼 기준으로 선택한 등급
			const memberLevel = $(this).parent().prev().children().val();
			location.href = "/changeLevel.do?memberNo="+memberNo+"&memberLevel="+memberLevel;
		});
		
		$(".checkedChangeLevel").on("click",function(){
			const check = $(".chk:checked");
			if(check.length == 0){
				alert("선택된 회원이 없습니다");
				return;
			}
			const num = new Array();
			const level = new Array();
			check.each(function(index,item){
				const memberNo = $(item).parent().next().text();
				num.push(memberNo);
				const memberLevel = $(item).parent().parent().find("select").val();
				level.push(memberLevel);
			});
			location.href="/checkedChangeLevel.do?num="+num.join("/")+"&level="+level.join("/");
		});
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>