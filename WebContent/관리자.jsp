<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@ page import="java.sql.*" %>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.Date" %>
<%! int i=0; %>
<%
	String id = request.getParameter("id");
    String menu = request.getParameter("state");
    int price = Integer.parseInt(request.getParameter("state1"));
    String path = request.getParameter("state2");
    

    request.setCharacterEncoding("utf-8");

    String driverName= "org.gjt.mm.mysql.Driver";
	String dbURL= "jdbc:mysql://192.168.55.150:3306/kiosk?useUnicode=true&characterEncoding=UTF-8";
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "root1", "0199");
	Statement stmt = con.createStatement();
      
    String query = "INSERT INTO "+id+"_menu(path, menu, price) VALUES (?, ?, ?);";
      
    PreparedStatement pstmt = null;
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, path);
    pstmt.setString(2, menu);
    pstmt.setInt(3, price);

      
    pstmt.executeUpdate();
      
   
%>
추가되었습니다.



</body>
</html>

