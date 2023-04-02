<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
	try {
		String driverName= "org.gjt.mm.mysql.Driver";
		String dbURL= "jdbc:mysql://192.168.55.150:3306/kiosk?useUnicode=true&characterEncoding=UTF-8";
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "root1", "0199");
		Statement stmt = con.createStatement();
		
		String id = request.getParameter("ID");
		String str = request.getParameter("STR");
		
		//String id = "디지몬";
		//String str = "떡볶이,5000,2,라면,4900,3";
		System.out.println("i-------");
		System.out.println(id);
		System.out.println("s-------");
		System.out.println(str);
		System.out.println("--------");
		
		String[] arr = str.split(",");
		//[떡볶이,5000,2,라면,4900,3]
		System.out.println("1-------");
		String query = "INSERT INTO "+id+"_kitchen(menu, count, cost) VALUES (?, ?, ?)";
		//out.println(query);
		System.out.println("2-------");
		PreparedStatement pstmt = null;
		pstmt = con.prepareStatement(query);
		
		for(int i = 0; i<arr.length; i++){
			if(i % 3 == 0){
				//out.println(arr[i]);
				//out.println(arr[i+2]);
				//out.println(arr[i+1]);
				
				pstmt.setString(1, arr[i]);
				pstmt.setString(2, arr[i+2]);
				pstmt.setString(3, arr[i+1]);
				pstmt.addBatch();
				pstmt.clearParameters();
			}
		}
	
		pstmt.executeBatch();
	
		out.println("제발");
	} catch (Exception e) {
			e.printStackTrace();
	}
%>