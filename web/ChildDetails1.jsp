<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Child Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center text-primary">Child Details</h2>
    <hr>
<%
    String childName = request.getParameter("child_name");
    String parentEmail = request.getParameter("parent_email");

    String url = "jdbc:mysql://localhost:3306/cvms";
    String user = "root";
    String pass = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, pass);

        String sql = "SELECT * FROM child_details WHERE name = ? AND parent_email = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, childName);
        ps.setString(2, parentEmail);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>
    <table class="table table-bordered">
        <tr><th>Name</th><td><%= rs.getString("name") %></td></tr>
        <tr><th>Date of Birth</th><td><%= rs.getString("dob") %></td></tr>
        <tr><th>Gender</th><td><%= rs.getString("gender") %></td></tr>
        <tr><th>Age</th><td><%= rs.getString("age") %></td></tr>
        <tr><th>Blood Group</th><td><%= rs.getString("blood_group") %></td></tr>
        <tr><th>Weight</th><td><%= rs.getString("weight") %></td></tr>
        <tr><th>Father's Name</th><td><%= rs.getString("father_name") %></td></tr>
        <tr><th>Mother's Name</th><td><%= rs.getString("mother_name") %></td></tr>
    </table>
    <a href="ClosedAppointment.jsp" class="btn btn-secondary">Back</a>
<%
        } else {
%>
    <div class="alert alert-danger">No child details found for this record.</div>
    <a href="ClosedAppointment.jsp" class="btn btn-secondary">Back</a>
<%
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
%>
    <div class="alert alert-danger">Error loading child details.</div>
    <a href="ClosedAppointment.jsp" class="btn btn-secondary">Back</a>
<%
    }
%>
</div>
</body>
</html>
