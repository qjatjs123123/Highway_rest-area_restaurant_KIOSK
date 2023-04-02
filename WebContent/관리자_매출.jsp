<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	try {
		String driverName= "org.gjt.mm.mysql.Driver";
		String dbURL= "jdbc:mysql://192.168.55.150:3306/kiosk?useUnicode=true&characterEncoding=UTF-8";
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "root1", "0199");
		Statement stmt = con.createStatement();
		
		String id = request.getParameter("ID");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String target = request.getParameter("target");
		String query = "";
		if(target == "3"){
			query = "SELECT * FROM "+id+"_kitchen WHERE YEAR(time) = " + year + " AND MONTH(time) = " +
		 				month + " AND DAY(time) = "+ day;
		}
		else if(target == "2"){
			query = "SELECT * FROM "+id+"_kitchen WHERE YEAR(time) = " + year + " AND MONTH(time) = " + month ;
		}
		else{
			query = "SELECT * FROM "+id+"_kitchen WHERE YEAR(time) = " + year;
		}
		String cnt = "SELCT COUNT(*) FROM "+id+"_kitchen";
		ResultSet rs = stmt.executeQuery(query);	
		String str = "";
		while(rs.next()){
			str += rs.getString("menu")+",";
			str += rs.getString("time")+",";
			str += rs.getString("count")+",";
			str += rs.getString("cost")+",";
		}
		out.println(str);
	} catch (Exception e) {
		e.printStackTrace();
    }
	
%>