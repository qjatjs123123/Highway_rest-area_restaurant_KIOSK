<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>주방</title>
<link rel= "stylesheet" type="text/css" href="주방.css">
<script>
	var id;	
	var order_list = new Array();
	
    window.onload=function(){
      for(i = 1; i<11; i++){
    	  
    	  document.querySelector(".menuList"+i).addEventListener("click", del);
      }
      id = getParameterByName('id');
      local_();
      display();
      textarea = document.getElementById("messageWindow");
      webSocket = new WebSocket('ws://192.168.55.150:8002/KIOSK_F/broadcasting');

	  webSocket.onerror = function(event) {
	  	onError(event)
	  };
	  	
	  webSocket.onopen = function(event) {
	  	onOpen(event)
	  };
	  	
	  webSocket.onmessage = function(event) {
	  	onMessage(event)
	  };
	  
   }
    function local_(){
    	// order_list = [[대기번호, 메뉴이름, 개수, 메뉴이름, 개수],[대기번호, 메뉴이름, 개수]]
    	// kiosk = [[시간],[대기번호, 메뉴이름, 개수]]
    	var locallist = localStorage.getItem(id+"_kitchen");
    	var list = new Array();
    	var date = new Date();
    	if(locallist != null){
    		var local = JSON.parse(locallist);
    		var local_date = new Date(local[0]);
    		if(local_date.getFullYear() == date.getFullYear() && local_date.getMonth() == date.getMonth()
                    && local_date.getDate() == date.getDate()){
    			for(i = 1; i<local.length; i++){
    				var s = new Array();
    				for(j = 0; j<local[i].length; j++){
    					if(j %3 == 0){
		    				s.push(local[i][j]);
		    				s.push(local[i][j+1]);
	    					s.push(local[i][j+2]);
    					}
    				}
    				order_list.push(s);
    			}
    		}
    		else{
    			var s = new Array();
    			s.push(date);
    			localStorage.setItem(id+"_kitchen", JSON.stringify(s));
    		}
    	}
    	else{
    		var s = new Array();
			s.push(date);
			localStorage.setItem(id+"_kitchen", JSON.stringify(s));
    	}
    }
    function getParameterByName(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		results = regex.exec(location.search);
		return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
   
   function order_menu(text){
      //var order = "대기번호,떡볶이,1,바나나,3,술,2";
      var orderArray = text.split(",");
      if(orderArray[0]==id){
	      var str = new Array();
	      for(var i=1; i<orderArray.length; i++){
	    	  
	         str.push(orderArray[i]);
	      }
	      order_list.push(str);
	      var t = order_list.slice();
	      var d = new Date();
	      t.unshift(d);
	      localStorage.setItem(id+"_kitchen", JSON.stringify(t));
      }
   }
   
   function display(){
	  for(i=0; i<10; i++){
		  var a=document.getElementById(i+1);
		  var b=document.getElementById("waiting_"+(i+1));
		  while( a.hasChildNodes()){
				a.removeChild(a.firstChild);
			}
		  while(b.hasChildNodes()){
			  b.removeChild(b.firstChild);
		  }
	  }
      for(i=0; i<order_list.length; i++){
         var a=document.getElementById(i+1);
         var b=document.getElementById("waiting_"+(i+1));
         var name =document.createElement("div");
         var count=document.createElement("div");
         var waiting=document.createElement("div");
         name.setAttribute("class","name");
         count.setAttribute("class", "count");
         waiting.setAttribute("class", "waiting");
         for(j=0; j<order_list[i].length; j++){
            if(j != 0){
            	if(j%3 == 0){
            		
            	}else if(j%3 == 1){
            		name.innerHTML += order_list[i][j] + "<br>";
	            }else{
	            	count.innerHTML += order_list[i][j] + "<br>";
	            	
	            }
            }else{
            	waiting.innerHTML = "대기번호 : " + order_list[i][j];
            }
         }
         a.appendChild(name);
         a.appendChild(count);
         b.appendChild(waiting);
         
      }
      
   } 
   
   function del(){
	   var target = this.id.split("_")[1] -1;
	   order_list.splice(target, 1);
	   var w_target = "waiting_" + (this.id.split("_")[1]).toString();
	   var parent = document.getElementById(w_target);
	   var text = parent.innerText;
	   var t = order_list.slice();
	   var d = new Date();
	   t.unshift(d);
	   localStorage.setItem(id+"_kitchen", JSON.stringify(t));
	   display();
	   if(text == ""){
		   return
	   }
	   send(text.split(" ")[2]);	   
   }
   
   
   function onMessage(event) {
	   
	   order_menu(event.data);
	   display();
   }

   function onOpen(event) {
   }

   function onError(event) {
   		alert(event.data);
   }

   function send(str) {
	   webSocket.send(str);
   }
</script>
</head>
<body>
<header>주방</header>
        <section class="menuList1" id = "s_1">
            <article class="number1">
                1번
            </article>
            <article id="waiting_1" class="waiting_number">
            	
            </article>
            <article id="1" class="menu">
               
            </article>
        </section>
        <section class="menuList2" id = "s_2">
            <article class="number2">
                2번
            </article>
            <article id="waiting_2" class="waiting_number">
            	
            </article>
            <article id="2"class="menu">

            </article>
        </section>
        <section class="menuList3"id = "s_3">
        	<article class="number3">
                3번
            </article>
            <article id="waiting_3" class="waiting_number">
            	
            </article>
            <article id="3" class="menu">

            </article>

        </section>
        <section class="menuList4"id = "s_4">
           	<article class="number4">
                4번
            </article>
            <article id="waiting_4" class="waiting_number">
            	
            </article>
            <article id="4" class="menu">

            </article>
        </section>
        <section class="menuList5"id = "s_5">
            <article class="number5">
                5번
            </article>
            <article id="waiting_5" class="waiting_number">
            	
            </article>
            <article id="5" class="menu">

            </article>
        </section>
        <section class="menuList6"id = "s_6">
            <article class="number6">
                6번
            </article>
            <article id="waiting_6" class="waiting_number">
            	
            </article>
            <article id="6" class="menu">

            </article>
        </section>
        <section class="menuList7"id = "s_7">
            <article class="number7">
                7번
            </article>
            <article id="waiting_7" class="waiting_number">
            	
            </article>
            <article id="7" class="menu">

            </article>
        </section>
        <section class="menuList8"id = "s_8">
            <article class="number8">
                8번
            </article>
            <article id="waiting_8" class="waiting_number">
            	
            </article>
            <article id="8" class="menu">

            </article>
        </section>
        <section class="menuList9"id = "s_9">
            <article class="number9">
                9번
            </article>
            <article id="waiting_9" class="waiting_number">
            	
            </article>
            <article id="9" class="menu">

            </article>
        </section>
        <section class="menuList10"id = "s_10">
           <article class="number10">
                10번
            </article>
            <article id="waiting_10" class="waiting_number">
            	
            </article>
            <article id="10" class="menu">

            </article>
        </section>
</body>
</html>