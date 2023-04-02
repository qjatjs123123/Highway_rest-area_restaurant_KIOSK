<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>번호</title>
</head>
<script>
window.onload=function(){
    webSocket = new WebSocket('ws://192.168.55.150:8002/KIOSK_F/broadcasting');
    webSocket.onerror = function(event) {
	  	
	  };
	  	
	  webSocket.onopen = function(event) {
	  	
	  };	
	  webSocket.onmessage = function(event) {
	  	onMessage(event)
	  };
	 	  
 }
 
	function onMessage(event) {
		var text = event.data
		var orderArray = text.split(",");
		if (orderArray.length > 1){
			return;
		}
		var parent = document.getElementById("number viewer");
		parent.innerHTML = text;
	}


</script>
<body>
	<div id="number viewer" style = "text-align:center; font-size : 30vw; width : 100%; height:600px" >
	</div>

</body>
</html>