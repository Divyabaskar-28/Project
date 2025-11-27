<%-- 
    Document   : DelayedAppointment1
    Created on : 16 May, 2025, 7:26:43 PM
    Author     : RAJASEKARAN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delayed Appointments - Admin View</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            body {
                background-image: url("./homeimg3.jpg");
                background-size: cover;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            h2 {
                text-align: center;
                color: #624aa1;
                margin-bottom: 20px;
                font-weight: bold;
            }
            .content {
                margin-left: 250px;
                margin-top: 120px;
                padding: 20px;
                height: calc(100vh - 50px);
                overflow-y: auto;
            }
            .table-container {
                width:1000px;
                margin: auto;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }
            table {
                width: 100%;
                text-align: center;
            }
            th, td {
                padding: 10px;
                border: 1px solid #624aa1;
            }
        </style>
    </head>
    <body>
        <%@ include file="ADashboard.jsp" %>  <!-- include admin dashboard -->

        <div class="content" style="margin-top:100px;">
            <div class="table-container table-responsive">
                <h2 style="color:#624aa1;font-weight:bold;">Delayed Appointments</h2>
                <table>
                    <thead>
                        <tr>
                            <th style="border: 1px solid #624aa1; padding: 8px;">#</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Appointment Date</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Child Name</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Hospital Name</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Branch</th>

                            <th style="border: 1px solid #624aa1; padding: 8px;">Vaccine</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Parent Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String url = "jdbc:mysql://localhost:3306/cvms";
                            String user = "root";
                            String pass = "";

                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            int i = 1;
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection(url, user, pass);

                                // Query to get all completed appointments (no hospital filter)
                                String sql = "SELECT appointment_date, child_name, hospital, hospital_branch, vaccine, parent_email "
                                        + "FROM book_appointments WHERE LOWER(status) = 'incompleted' "
                                        + "ORDER BY appointment_date DESC";

                                ps = conn.prepareStatement(sql);
                                rs = ps.executeQuery();

                                boolean found = false;
                                while (rs.next()) {
                                    found = true;
                        %>
                        <tr>
                            <td  style="border: 1px solid #624aa1; padding: 8px;"><%= i++%></td>
                            <td  style="border: 1px solid #624aa1; padding: 8px;"><%= rs.getString("appointment_date")%></td>
                            <td  style="border: 1px solid #624aa1; padding: 8px;"><%= rs.getString("child_name")%></td>
                            <td  style="border: 1px solid #624aa1; padding: 8px;"><%= rs.getString("hospital")%></td>
                            <td style="border: 1px solid #624aa1; padding: 8px;"><%= rs.getString("hospital_branch")%></td>

                            <td style="border: 1px solid #624aa1; padding: 8px;"><%= rs.getString("vaccine")%></td>
                            <td style="border: 1px solid #624aa1; padding: 8px;"><%= rs.getString("parent_email")%></td>
                        </tr>
                        <%
                            }
                            if (!found) {
                        %>
                        <tr><td colspan="7" style="color:red;">No completed appointments found.</td></tr>
                        <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        %>
                        <tr><td colspan="7" style="color:red;">Error loading appointments.</td></tr>
                        <%
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
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>

