<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String hospitalName = request.getParameter("hospitalName");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        if (hospitalName != null && !hospitalName.trim().isEmpty()) {
            Class.forName("com.mysql.jdbc.Driver"); // Updated driver
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
            ps = con.prepareStatement("SELECT branch FROM hospital_details WHERE TRIM(hospital_name) = ?");
            ps.setString(1, hospitalName);
            rs = ps.executeQuery();

            while (rs.next()) {
%>
<option value="<%= rs.getString("branch")%>"><%= rs.getString("branch")%></option>
<%
            }
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
