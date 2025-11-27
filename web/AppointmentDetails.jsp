<%-- 
    Document   : AppointmentDetails
    Created on : 22 Apr, 2025, 4:20:38 PM
    Author     : RAJASEKARAN
--%>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Child Appointment Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <link href="./bootstrap1.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <!--<script src="./script.js"></script>-->
        <!--<script src="./capmtdetails.js"></script>-->
        <style>
            body{
                background-image: url("Images/homeimg3.jpg ");
                background-size: cover;
            }


            .container1 {
                margin-top: 80px;
                margin-left: 340px; /* Push container + table to the right */
                max-width: 900px;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            }

            h2 {
                text-align: center;
                color: #624aa1;
                font-weight: bold;
            }

            .table-container {
                max-width: 900px;
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

            .btn-status {
                background-color: #624aa1;
                color: white;
                border: none;
                padding: 5px 10px;
                font-size: 14px;
                border-radius: 5px;
            }

            .btn-status:hover {
                background-color: #7a5ecb;
            }
        </style>
    </head>
    <body>
        <%@ include file="ADashboard.jsp" %> 
        <div class="container1">
            <h2 style="color:#624aa1;font-weight:bold;">Appointment Details</h2>

            <table>
                <thead>
                    <tr>
                        <th style="border:1px solid #624aa1;">#</th>
                        <th style="border:1px solid #624aa1;">Appointment Date</th>
                        <th style="border:1px solid #624aa1;">Child Name</th>
                        <th style="border:1px solid #624aa1;">Hospital Name</th>
                        <th style="border:1px solid #624aa1;">Hospital Branch</th>
                        
                        <th style="border:1px solid #624aa1;">Vaccine</th>
                        <th style="border:1px solid #624aa1;">Parent Email</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                            stmt = con.createStatement();
                            String query = "SELECT * FROM book_appointments ORDER BY appointment_date DESC";

                            rs = stmt.executeQuery(query);
                            int i = 1;
                            while (rs.next()) {
                    %>
                    <tr>
                        <td style="border:1px solid #624aa1;"><%= i++%></td>
                         <td style="border:1px solid #624aa1;"><%= rs.getString("appointment_date")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("child_name")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("hospital")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("hospital_branch")%></td>
                       
                        <td style="border:1px solid #624aa1;"><%= rs.getString("vaccine")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("parent_email")%></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='9'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (stmt != null) {
                                    stmt.close();
                                }
                                if (con != null) {
                                    con.close();
                                }
                            } catch (Exception e) {
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>

    </body>
</html>

