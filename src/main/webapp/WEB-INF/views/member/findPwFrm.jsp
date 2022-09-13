<%@page import="kr.or.iei.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <% 
    	Member findM = (Member)request.getAttribute("findMember");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	label{
	height:80px;
	font-size:50px;
	text-align:center;
	width:1200px;
	display:inline-block;
	box-sizing:border-box;}
</style>
<title>비밀번호 찾기</title>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">비밀번호 찾기</div>
	<form action="/findPw.do">
		<label for="memberId">아이디</label>
		<input type="text" name ="memberId" id="memberId" class="input-form">
		<label for="memberPhone">휴대전화</label>
		<input type="text" name ="memberPhone" id="memberPhone" class="input-form"><br>
		<button type="submit" class="btn bc4 bs1">비밀번호 찾기</button>
		<button type="button" class="btn bc4 bs1" onclick="location.href='./'">홈으로 가기</button>
	</form>
	</div>
</body>
</html>