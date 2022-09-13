<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>페이</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">페이</div>
		<input type="text" id="price" class="input-form">
		<button class="btn bc4 bs4" id="payBtn">결제하기</button>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
	<script type="text/javascript">
		$("#payBtn").on("click",function(){
			const price = $("#price").val();
			const d = new Date();
			const date = d.getFullYear()+""+(d.getMonth()+1)+""+d.getDate()+""
			+d.getHours()+""+d.getMinutes()+""+d.getSeconds();
			
			IMP.init("imp43256257");
			IMP.request_pay({
				merchat_uid : "상품코드_"+date, 			//거래아이디
				name :"결제 테스트",						//결제이름
				amount : price,	
				buyer_email : "taeyeonimda@gmail.com", //구매자  이메일
				buyer_name : "구매자",
				buyer_tel : "010-1234-1234",
				buyer_addr : "서울시 이레빌딩",
				buyer_postcode : "12345"               //우편번호
			},function(rsp){
				if(rsp.success){
					alert("결제성공");
				}else{
					alert("결제실패");
				}
			});
		});
	</script>
</body>
</html>