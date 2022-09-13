<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=vpkvkhu7rd&submodules=geocoder"></script>
<title>MAP API</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp"%>
	<div class="page-content">
		<div class="page-title">MAP-API</div>
		<h2>1. 다음 주소 찾기</h2>
		
		<input type ="text" name="postcode" id="postcode" class="input-form" readonly>
		<button class="btn bc1" onclick="searchAddr();">주소찾기</button>
		<input type="text" name="address" id="address" class="input-form" readonly>
		<input type="text" name="detailAddress" id="deatilAddress" class="input-form">
		<h2>네이버지도 API</h2>
		<div id="map" style="width:100%;height:400px;"></div>
		<button onclick="showMap();" class="btn bc1">지도옮기기</button>
	</div>

	<%@include file="/WEB-INF/views/common/footer.jsp"%>
	<script>
		
		var mapOptions = {
		    center: new naver.maps.LatLng(37.533837, 126.896836),
		    zoom: 18,
		    zoomControl:true,
		    zoomControlOptions :{
		    	position : naver.maps.Position.TOP_RIGHT,
		    	style : naver.maps.ZoomControlStyle.SMALL
		    },
		    
		};
		

		var map = new naver.maps.Map('map', mapOptions);
		
		const marker = new naver.maps.Marker({
			position : new naver.maps.LatLng(37.533837, 126.896836),
			map:map
		});
		
		let contentString = [
			"<div class='iw_inner'>",
			"	<h3>KH정보교육원</h3>",
			"	<p>서울시 영등포구 선유동2로 이레빌딩</p>",
			"</div>"
		].join("");	
		let infoWindow = new naver.maps.InfoWindow();
		
		naver.maps.Event.addListener(marker,"click",function(e){
			infoWindow = new naver.maps.InfoWindow({
				content : contentString
			});
			//생성된 infoWindow를 map의 marker위치에 생성
			infoWindow.open(map,marker);
		});
		
		naver.maps.Event.addListener(map,"click",function(e){
			marker.setPosition(e.coord);//해당위치로 마커이동
			//infoWindow가 맵에 있으면
			if(infoWindow.getMap()){
				infoWindow.close();
			}
			//위경도로를 통해서 해당위치의 주소를 알아내기
			naver.maps.Service.reverseGeocode({
				location : new naver.maps.LatLng(e.coord.lat(),e.coord.lng())
			},function(status,response){
				if(status != naver.maps.Service.Status.OK){
					return alert("주소를 찾을 수 없습니다.");
				}
				const address = response.result.items[1].address;
				contentString = [
					"<div class='iw_inner'>",
					"	<p>"+address+"</p>",
					"</div>"
				].join("");	
			});
		});
		
		function showMap(){
			const addr = $("#address").val();
			naver.maps.Service.geocode({address:addr},function(status,response){
				
				if(status ===naver.maps.Service.Status.ERROR){
					return alert("조회에러");
				}
				const lng = response.result.items[1].point.x;
				const lat = response.result.items[1].point.y;
				const latlng = new naver.maps.LatLng(lat,lng);
				map.setCenter(latlng);
				marker.setPosition(latlng);
			});
			
		}
		
    	function searchAddr() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 참고 항목 변수

                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                       extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraRoadAddr !== ''){
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = roadAddr;
                    if(document.getElementById("address").value==null){
                    	document.getElementById("address").value = data.jibunAddress;
                    }
                    //
                    
                   
                    
                    // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                   
                    var guideTextBox = document.getElementById("guide");
                    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                    if(data.autoRoadAddress) {
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                        guideTextBox.style.display = 'block';

                    } else if(data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                        guideTextBox.style.display = 'block';
                    }
                }
            }).open();
        }
    </script>
</body>
</html>