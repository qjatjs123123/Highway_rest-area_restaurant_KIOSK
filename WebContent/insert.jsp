<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("utf-8");
	try {
		String driverName= "org.gjt.mm.mysql.Driver";
		String dbURL= "jdbc:mysql://192.168.55.150:3306/kiosk?useUnicode=true&characterEncoding=UTF-8";
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "root1", "0199");
		Statement stmt = con.createStatement();
		
		String id = request.getParameter("ID");
		String ps = request.getParameter("PS");
		String na = request.getParameter("NA");
		String em = request.getParameter("EM");
		
		String query = "INSERT INTO member(id, passwd, name, email) VALUES (?, ?, ?, ?);";
		
		PreparedStatement pstmt = null;
		pstmt = con.prepareStatement(query);
		pstmt.setString(1, id);
		pstmt.setString(2, ps);
		pstmt.setString(3, na);
		pstmt.setString(4, em);
		
		pstmt.executeUpdate();
		
		StringBuilder sb = new StringBuilder();
		String sql = sb.append("CREATE TABLE "+id+"_menu(")
				.append("menu varchar(50),")
				.append("price int,")
				.append("path varchar(10000)")
				.append(");").toString();
		stmt.execute(sql);
		StringBuilder sb2 = new StringBuilder();
		String sql2 = sb2.append("CREATE TABLE "+id+"_kitchen(")
				.append("menu varchar(50),")
				.append("count int,")
				.append("time DATETIME DEFAULT NOW(),")
				.append("cost int")
				.append(");").toString();
		
		stmt.execute(sql2);
	} catch (Exception e) {
			e.printStackTrace();
	}
%>