<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<%
String driverName= "org.gjt.mm.mysql.Driver";
String dbURL= "jdbc:mysql://192.168.55.150:3306/kiosk?useUnicode=true&characterEncoding=UTF-8";
Class.forName(driverName);
Connection con = DriverManager.getConnection(dbURL, "root1", "0199");
Statement stmt = con.createStatement();
   
   String id = request.getParameter("id").trim();
   String query = "SELECT * FROM "+ id + "_menu";
   ResultSet rs = stmt.executeQuery(query);
   
%>

	<meta charset="utf-8">
	<script type="text/javascript" src="111.js?ver123"></script>
	<link rel= "stylesheet" type="text/css" href="메뉴판.css">
	<title>메뉴</title>
	<div class="black_bg"></div>
        <div class="modal_wrap" id = "modal">
            <div class="modal_close"><a href="#">close</a></div>
            <hr>
            <h1>장바구니</h1>
            <hr>
            <div id = "divModal">
            </div>
            
            <span id = "sum_span">총 </span><input type="text" class = "sum" id="sum" readonly = "true" value = "0"><span id = "won">원</span>
            <hr>
            <input type="button" id = "btn_order" value="주문하기" onclick="btn_order()">
            
            
            
            
            
    	</div>
</head>

<body>
   	<header>
   		<img src="https://i.ibb.co/xM2VyKj/Kakao-Talk-20201214-040955315.png"class="cart" onclick="onClick()">
   		<span class="title"><%= id %></span>
   		<div class ="no"></div>
    </header>
    
    <section>
        <% while(rs.next()){%>
            <article class="menu">
                <div class="group">
                    <img src="<%=rs.getString("path")%>" class="pic">
                    <input type="text" class = "name" value = "<%= rs.getString("menu")%>">
                    <input type="text" class = "price" value = "<%= rs.getString("price")%>"><br>
                    <input type="button" class= "btn" value="담아두기" id = "<%= rs.getString("menu")%>,<%= rs.getString("price")%>">
                   </div>
                
            </article>
        <%} %>
    </section>
    <aside>
    	
    </aside>
    
    
    
   
   
   
   
   
   
   
    
</body>
</html>