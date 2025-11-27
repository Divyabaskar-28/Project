<%-- 
    Document   : UpdateVaccination
    Created on : 28 Apr, 2025, 3:15:31 PM
    Author     : RAJASEKARAN
--%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Vaccination Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./script.js"></script>
    </head>
    <body>
        <div class="container mt-5">

            <%
                String email = (String) session.getAttribute("email");
                if (email == null) {
                    response.sendRedirect("AdminLogin.jsp");
                    return;
                }

                String vaccinationId = request.getParameter("id");
                String age = request.getParameter("vage");
                String vaccinationName = request.getParameter("vname");
                String dose = request.getParameter("vdose");
               

                String url = "jdbc:mysql://localhost:3306/cvms";
                String user = "root";
                String pass = "";
                Connection con = DriverManager.getConnection(url, user, pass);

                // Check if vaccinationId, age, and vaccinationName are not empty or null
                if (vaccinationId == null || vaccinationId.isEmpty() || age == null || age.isEmpty() || vaccinationName == null || vaccinationName.isEmpty() || dose == null || dose.isEmpty()) {
                    out.print("<script>alert('Please fill all the required fields.'); window.location.href='AdminEditVaccination.jsp?id=" + vaccinationId + "';</script>");
                    return;
                }

                // SQL query to update vaccination details
                PreparedStatement ps = con.prepareStatement("UPDATE admin_schedule SET age=?, vaccination_name=?, dose=?, email=? WHERE id=?");
                ps.setString(1, age);
                ps.setString(2, vaccinationName);
                ps.setString(3, dose);
                ps.setString(4, email);
                ps.setInt(5, Integer.parseInt(vaccinationId));

                int result = ps.executeUpdate();
                if (result > 0) {
                    out.print("<script>window.location.href='AdminVaccination1.jsp';</script>");
                } else {
                    out.print("<script>alert('Failed to update vaccination details.'); window.location.href='AdminEditVaccination.jsp?id=" + vaccinationId + "';</script>");
                }

                con.close();
            %>

        </div>
    </body>
</html>
