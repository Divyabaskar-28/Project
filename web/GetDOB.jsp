<%-- 
    Document   : GetDOB
    Created on : 27 Apr, 2025, 3:12:32 PM
    Author     : RAJASEKARAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String childName = request.getParameter("childName");
    String parentEmail = (String) session.getAttribute("parent_email");

    String url = "jdbc:mysql://localhost:3306/cvms";
    String user = "root";
    String pass = "";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
        String sql = "SELECT dob FROM child_details WHERE name = ? AND parent_email = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, childName);
        ps.setString(2, parentEmail);
        rs = ps.executeQuery();
        if (rs.next()) {
            out.print(rs.getString("dob"));
        } else {
            out.print("");  // No DOB found
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
