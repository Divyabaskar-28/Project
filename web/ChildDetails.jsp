<%-- 
    Document   : ChildDetails
    Created on : 22 Apr, 2025, 3:41:47 PM
    Author     : RAJASEKARAN
--%>
<%@page import = "java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Child Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--<link href="./bootstrap1.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <!--<script src="./script.js"></script>-->
        <!--<script src="./childdetails.js"></script>-->
        <style>
            body{
                background-image: url("Images/homeimg3.jpg");
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
                max-width: 800px;
                margin: auto;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);

            }

            table {
                width: 100%;
                text-align: center;

            }

            th, td {
                padding: 7px;
                border: 1px solid #624aa1;
            }
            .btn-delete {
                background-color: red;
                color: white;
                border: none;
                padding: 5px 10px;
                font-size: 14px;
                border-radius: 5px;
            }

            .btn-delete:hover {
                background-color: darkred;
            }
        </style>
    </head>
    <body>
        <%@ include file="ADashboard.jsp" %> 
        <div class="container1">
            <h2 style="color:#624aa1;font-weight:bold;">Child Details</h2>

            <table style="border:1px solid #624aa1;">
                <thead>
                    <tr>
                        <th style="border:1px solid #624aa1;">#</th>
                        <th style="border:1px solid #624aa1;">Child Name</th>
                        <th style="border:1px solid #624aa1;">DOB</th>
                        <th style="border:1px solid #624aa1;">Gender</th>
                        <th style="border:1px solid #624aa1;">Age</th>
                        <th style="border:1px solid #624aa1;">Blood Group</th>
                        <th style="border:1px solid #624aa1;">Weight</th>
                        <th style="border:1px solid #624aa1;">Father Name</th>
                        <th style="border:1px solid #624aa1;">Mother Name</th>
                        <th style="border:1px solid #624aa1;">Parent Email</th>

                    </tr>
                </thead>
                <tbody>
                    <%  Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                            stmt = con.createStatement();
                            String query = "SELECT * FROM child_details";
                            rs = stmt.executeQuery(query);
                            int i = 1;
                            while (rs.next()) {
                    %>
                    <tr>
                        <td style="border:1px solid #624aa1;"><%= i++%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("name")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("dob")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("gender")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("age")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("blood_group")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("weight")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("father_name")%></td>
                        <td style="border:1px solid #624aa1;"><%= rs.getString("mother_name")%></td>
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
