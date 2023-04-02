var list = new Array();
var webSocket;
var xmlhttp = false;
var id;
var wait = 0;
window.onload = function(){
	id = getParameterByName('id');
	change();
	set_event();
	webSocket = new WebSocket('ws://192.168.55.150:8080/KIOSK_F/broadcasting');

	webSocket.onerror = function(event) {
		onError(event);
	};
	
	webSocket.onopen = function(event) {
	    onOpen(event);
	};
	
	webSocket.onmessage = function(event) {
	    onMessage(event);
	};
}
function getParameterByName(name) {
	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	results = regex.exec(location.search);
	return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
function change(){
	var text = document.querySelectorAll('.price');
	for(i = 0; i<text.length; i++){
	text[i].value = comma(text[i].value)+"원";
	}
}
function set_event(){
	var btn = document.querySelectorAll('.btn');
	for(i = 0; i<btn.length;i++){
		btn[i].addEventListener('click', add_);
	}
}

function comma(num){
	var len, point, str; 
                  
	num = num + "";
	point = num.length % 3 ;
	len = num.length; 
              
	str = num.substring(0, point); 
               
	while (point < len) { 
		if (str != "") str += ","; 
		str += num.substring(point, point + 3); 
                  
		point += 3;
	}          
	return str;           
}    
function add_(){
	var menu = this.id.split(',')[0];
	var cost = this.id.split(',')[1];
	var index = -1;
	
	for(i =0; i<list.length; i++){
		if(list[i][0] == menu){
			index = i;
		}
	}
	if(index != -1){
		list[index][2] = list[index][2]+1;
		var i = document.getElementById(menu+"_i");
		i.value = parseInt(i.value) +1;
		
		var c = document.getElementById(menu+ "_c");
		c.innerHTML = parseInt(cost) * list[index][2];
	}
	else{
		add_shopping(menu, cost, 1);
		var str = new Array();
		str.push(menu);
		str.push(cost);
		str.push(1);
		list.push(str);
	}
	update_sum();
}
function btn_add(){
	var menu = this.id.split('_')[0];
	var index;
	for(i = 0; i<list.length; i++){
		if(list[i][0] ==menu){
			index = i;
			break;
		}
	}
	list[index][2] = list[index][2]+1;
	var i = document.getElementById(menu+"_i");
		i.value = parseInt(i.value) +1;
	var c = document.getElementById(menu+ "_c");
		c.innerHTML = parseInt(list[index][1]) * list[index][2];
	update_sum();
}
function btn_minus(){
	var menu = this.id.split('_')[0];
	var index;
	for(i = 0; i<list.length; i++){
		if(list[i][0] ==menu){
			index = i;
			break;
		}
	}
	if(list[index][2] != 1){
		list[index][2] = list[index][2]-1;
		var i = document.getElementById(menu+"_i");
			i.value = parseInt(i.value) -1;
		var c = document.getElementById(menu+ "_c");
			c.innerHTML = parseInt(list[index][1]) * list[index][2];
	}
	update_sum();
}
function btn_del(){
	var menu = this.id.split('_')[0];
	var index;
	var modal = document.getElementById('divModal');
	var m =document.getElementById(menu);
	for(i = 0; i<list.length; i++){
		if(list[i][0] == menu){
			index = i;
			break;
		}
	}
	list.splice(index,1);
	divModal.removeChild(m);
	update_sum();
	
}
function add_shopping(menu, cost, count){
	var div = document.createElement("div");
		div.setAttribute("class", "LIST");
		div.setAttribute("id", menu);
	var del_button = document.createElement("input");
		del_button.setAttribute("type", "button");
		del_button.setAttribute("class", "del_btn");
		del_button.setAttribute("id", menu+"_d");
		del_button.setAttribute("value", "X");
	var name_div = document.createElement("div");
		name_div.setAttribute("class", "name_div");
		name_div.innerHTML = menu;
	var cost_div = document.createElement("div");
		cost_div.setAttribute("class", "cost_div");
		cost_div.setAttribute("id", menu+"_c");
		cost_div.innerHTML = cost;
	var m_button = document.createElement("input");
		m_button.setAttribute("class", "ms_btn");
		m_button.setAttribute("type", "button");
		m_button.setAttribute("value","-");
		m_button.setAttribute("id", menu+"_m");
	var count_txt = document.createElement("input");
		count_txt.setAttribute("class", "count_txt");
		count_txt.setAttribute("value" , count);
		count_txt.setAttribute("id", menu+"_i");
		count_txt.setAttribute("readonly", "true");
	var p_button = document.createElement("input");
		p_button.setAttribute("class", "ps_btn");
		p_button.setAttribute("type", "button");
		p_button.setAttribute("value","+");
		p_button.setAttribute("id", menu+"_p");
		
	div.appendChild(del_button);
	div.appendChild(name_div);
	div.appendChild(cost_div);
	div.appendChild(m_button);
	div.appendChild(count_txt);
	div.appendChild(p_button);
	
	var m =document.getElementById('divModal');
	
	m.appendChild(div);
	ps_event();
}
function ps_event(){
	var p = document.querySelectorAll(".ps_btn");
	var m = document.querySelectorAll(".ms_btn");
	var d = document.querySelectorAll(".del_btn");
	for(i = 0; i<p.length; i++){
		p[i].addEventListener('click', btn_add);
		m[i].addEventListener('click', btn_minus);
		d[i].addEventListener('click', btn_del);
	}
}
function update_sum(){
	var sum = document.getElementById("sum");
	var value = 0;
	if(list!=null){
		for(i = 0; i<list.length; i++){
			value = value +  (parseInt(list[i][1]) * list[i][2]);
		}
		sum.value = value;
	}
	else{
		sum.value = 0;
	}
}

function btn_order(){
	if(list.length != 0){
		var modal = document.getElementById("divModal");
		while( modal.hasChildNodes()){
			modal.removeChild(modal.firstChild);
		}
		
		offClick();
		var ddddddd;
		
		
		var local_wait = localStorage.getItem(id);
            var list1 = new Array();
            var date = new Date();
            var waiting = 0;
            if(local_wait != null){
                var local = JSON.parse(local_wait);
                var local_date = new Date(local[0]);
                if(local_date.getFullYear() == date.getFullYear() && local_date.getMonth() == date.getMonth()
                    && local_date.getDate() == date.getDate()){
                    waiting = local[1];
					wait = waiting;
					list1.push(date);
                    list1.push(waiting+1);
                    localStorage.setItem(id, JSON.stringify(list1));
                }
                else{
                    list1.push(date);
                    list1.push(1);
                    localStorage.setItem(id, JSON.stringify(list1));
                }
            }
            else{
                list1.push(date);
                list1.push(1);
                localStorage.setItem(id, JSON.stringify(list1));

            }
		var str =id;
				for(i = 0; i<list.length;i++){
					str = str+"," +(waiting+1)+ ","+list[i][0]+","+list[i][2];
				}
				//[id, 대기번호, 떡볶이, 2, 라면, 3]
				saveDB(list);
				list=[];
				send(str);
            var sum = document.getElementById("sum");
            sum.value =0;
		alert("주문이 완료되었습니다. \n대기번호는 "+(waiting+1)+"입니다.");
            
	}
	else{
		alert("주문목록이 없습니다.");
	}
}


function saveDB(list){

	xmlhttp= new XMLHttpRequest();
	// [[떡볶이, 5000, 2],[라면, 4900, 3]]
	var count_str = list.toString();
	// [떡볶이, 5000, 2, 라면, 4900, 3]
	
	var DBid = id;
	var url = "메뉴판_DB.jsp";
	var qry = "ID="+DBid+"&STR="+count_str;

	xmlhttp.open("POST",url,true); 
	
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");             
    xmlhttp.send(qry);


}       

function offClick(){
    document.querySelector('.modal_wrap').style.display ='none';
    document.querySelector('.black_bg').style.display ='none';
}
function onClick(){
	document.querySelector('.modal_wrap').style.display ='block';
    document.querySelector('.black_bg').style.display ='block';
	document.querySelector('.modal_close').addEventListener('click', offClick);	
}

function onMessage(event) {
}

function onOpen(event) {
}

function onError(event) {
	alert(event.data);
}

function send(str) {
    webSocket.send(str);
}

