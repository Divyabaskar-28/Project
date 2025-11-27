<%-- 
    Document   : UpdateHospital
    Created on : 17 May, 2025, 7:32:38 PM
    Author     : RAJASEKARAN
--%>

<%@page import="java.sql.*"%>
<%
    String email = request.getParameter("email");
    String hospital_name = request.getParameter("hospital_name");
    String branch = request.getParameter("branch");
    String registration_id = request.getParameter("registration_id");
    String mobile = request.getParameter("mobile");
    String address = request.getParameter("address");
    String password = request.getParameter("password");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

        String query = "UPDATE hospital_details SET hospital_name=?, branch=?, registration_id=?, mobile=?, address=?, password=? WHERE email=?";
        ps = con.prepareStatement(query);
        ps.setString(1, hospital_name);
        ps.setString(2, branch);
        ps.setString(3, registration_id);
        ps.setString(4, mobile);
        ps.setString(5, address);
        ps.setString(6, password);
        ps.setString(7, email);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("HospitalInfo.jsp?msg=updated");
        } else {
            out.print("Update failed.");
        }
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    } finally {
        if (ps != null) {
            ps.close();
        }
        if (con != null) {
            con.close();
        }
    }
%>

