<%-- 
    Document   : ViewChildDetails
    Created on : 11 May, 2025, 3:00:30 PM
    Author     : RAJASEKARAN
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Child Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <style>
            body {
                 background-image: url("Images/homeimg3.jpg");
                background-size: cover;
            }
            .table-container {
                margin: 50px auto;
                width: 70%;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow:0px 4px 10px rgba(0, 0, 0, 0.2);
                margin-left: 320px;
                margin-top:100px;
            }
            h2 {
                text-align: center;
                color: #5a4ca1;
                font-weight: bold;
            }
            table {
                width: 100%;
                text-align: center;
                overflow-x: auto;
            }
            th, td {
                padding: 10px;
                border: 1px solid #624aa1;
                color: black;
            }

            .btn-back {
                background-color: #624aa1;
                color: white;
                margin-top: 20px;
            }
            .btn-back:hover {
                background-color: #4a368c;
            }
        </style>
    </head>
    <body>
        <%@ include file="ADashboard.jsp" %>
        <div class="table-container">
            <h3 style="color:#624aa1;text-align:center; font-weight:bold;">Children of Parent</h3>
            <table>
                <thead>
                    <tr>
                        <th style="border:1px solid #624aa1;padding:10px;">#</th>
                        <th style="border:1px solid #624aa1;padding:10px;">Child Name</th>
                        <th style="border:1px solid #624aa1;padding:10px;">Date of Birth</th>
                        <th style="border:1px solid #624aa1;padding:10px;">Gender</th>
                        <th style="border:1px solid #624aa1;padding:10px;">Age</th>
                        <th style="border:1px solid #624aa1;padding:10px;">Blood Group</th>
                        <th style="border:1px solid #624aa1;padding:10px;">Weight (kg)</th>
                        <th style="border:1px solid #624aa1;padding:10px;">Father's Name</th>
                        <th style="border:1px solid #624aa1;padding:10px;">Mother's Name</th>
                    </tr>
                </thead>
                <tbody>
                    <%            
                        
                        
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        int i = 1;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                            ps = con.prepareStatement("SELECT * FROM child_details WHERE parent_email = ?");
                            ps.setString(1, email);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                    %>
                    <tr>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= i++%></td>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= rs.getString("name")%></td>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= rs.getString("dob")%></td>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= rs.getString("gender")%></td>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= rs.getString("age")%></td>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= rs.getString("blood_group")%></td>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= rs.getString("weight")%></td>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= rs.getString("father_name")%></td>
                        <td style="border:1px solid #624aa1;padding:10px;"><%= rs.getString("mother_name")%></td>
                    </tr>
                    <%
                            }
                            if (i == 1) {
                                out.println("<tr><td colspan='9' class='text-center'>No children found.</td></tr>");
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='9'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (ps != null) {
                                    ps.close();
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
            <div class="text-center">
                <a href="ParentInfo.jsp" class="btn btn-back" style="background-color: #624aa1;
                   color: white;
                   margin-top: 20px;">Back to Parent Info</a>
            </div>
        </div>
    </body>
</html>
