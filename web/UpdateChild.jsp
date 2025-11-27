<%-- 
    Document   : UpdateChild
    Created on : 14 Apr, 2025, 8:14:51 PM
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
        <title>Child Edit Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--     <link href="./bootstrap1.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <script src="./script.js"></script>


    </head>

    <body>
        <div class="container mt-5">

            <%
                String parentEmail = (String) session.getAttribute("parent_email");
                if (parentEmail == null) {
                    response.sendRedirect("ParentLogin.jsp");
                    return;
                }

                String id = request.getParameter("id");
                String name = request.getParameter("cname");

                String dob = request.getParameter("cdob");
                String formattedDob = "";  // Declare formattedDob outside of if block

                // Check if the dob is not empty before parsing
                if (dob != null && !dob.isEmpty()) {
                    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");  // Input format from the form
                    java.util.Date utilDate = inputFormat.parse(dob);  // Parse the input date
                    SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy"); // Output format for database
                    formattedDob = outputFormat.format(utilDate);  // Format the date as dd-MM-yyyy
                } else {
            %>
            <script>
                alert("Date of Birth is required!");
                window.location.href = "EditChild.jsp?id=<%=id%>";
            </script>
            <%
                    return;
                }

                String gender = request.getParameter("cgender");
                String age =request.getParameter("cage");
                String bloodGroup = request.getParameter("cblood");
                String weight = request.getParameter("cweight");
                String fatherName = request.getParameter("cfather");
                String motherName = request.getParameter("cmother");

                String url = "jdbc:mysql://localhost:3306/cvms";
                String user = "root";
                String pass = "";
                Connection con = DriverManager.getConnection(url, user, pass);

                PreparedStatement ps = con.prepareStatement("UPDATE child_details SET name=?, dob=?, gender=?, age=?, blood_group=?, weight=?, father_name=?, mother_name=?, parent_email=? WHERE id=?");
                ps.setString(1, name);
                ps.setString(2, formattedDob);
                ps.setString(3, gender);
                ps.setString(4, age);
                ps.setString(5, bloodGroup);
                ps.setString(6, weight);
                ps.setString(7, fatherName);
                ps.setString(8, motherName);
                ps.setString(9, parentEmail);
                ps.setInt(10, Integer.parseInt(id));

                int result = ps.executeUpdate();
                if (result > 0) {
                    out.print("<script>window.location.href='AddChild1.jsp';</script>");
                }
//               else
//               {
//                   out.print("<script>alert('Failed to Register.'); window.location.href='ParentRegistration.jsp';</script>");
//               }

                con.close();
            %>

        </div>

        <script src="AddChild.js"></script>
    </body>
</html>
