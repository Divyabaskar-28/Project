<%-- 
    Document   : HospitalApproval
    Created on : 30 Apr, 2025, 3:41:55 PM
    Author     : RAJASEKARAN
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hospital Approval</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--<link href="./bootstrap1.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <!--<script src="./script.js"></script>-->
        <!--<script src="./happroval.js"></script>-->
        <style>
            body{
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
                font-weight:bold;
            }

            .content {
                margin-left: 230px;
                padding: 20px;
                height: calc(100vh - 50px);
                overflow-y: auto;
            }

            .table-container {
                max-width: 1060px;
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


            .btn-approve {
                background-color: green;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-reject {
                background-color: red;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-approve:hover {
                background-color: darkgreen;
            }

            .btn-reject:hover {
                background-color: darkred;
            }
        </style>
    </head>
    <body> 
        <%@ include file="ADashboard.jsp" %> 
        <div class="content">
            <div class="table-container" style="color:#624aa1; font-weight:bold;margin-right:20px;">
                <h2>Hospital Approval</h2>
                <table>
                    <thead>
                        <tr>
                            <th style="border:1px solid #624aa1; padding:10px;color:black;">#</th>
                            <th style="border:1px solid #624aa1; padding:10px;color:black;">Applied Date</th>
                            <th style="border:1px solid #624aa1; padding:10px;color:black;">Profile Photo</th>
                            <th style="border:1px solid #624aa1; padding:10px;color:black;">Hospital Name</th>
                            <th style="border:1px solid #624aa1; padding:10px;color:black;">Hospital Branch</th>
                            <th style="border:1px solid #624aa1; padding:10px; color:black;">Registration ID</th>
                            <th style="border:1px solid #624aa1; padding:10px; color:black;">Email</th>
                            <th style="border:1px solid #624aa1;padding:8px; color:black;">Mobile</th>
                            <th style="border:1px solid #624aa1;padding:8px; color:black;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int count = 1;
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM hospital_details WHERE status='pending'");

                                while (rs.next()) {
                                    java.sql.Timestamp appliedOn = rs.getTimestamp("applied_on");
                                    String formattedDate = new java.text.SimpleDateFormat("dd-MM-yyyy").format(appliedOn);
                        %>
                        <tr>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;"><%= count++%></td>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;"><%= formattedDate%></td>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;">
                                <%
                                    String profilePhoto = rs.getString("photo");
                                    String finalPhoto = (profilePhoto != null && !profilePhoto.trim().isEmpty())
                                            ? profilePhoto
                                            : "Picture/Hospitals/defaultProfile.png";
                                %>
                                <img src="<%= request.getContextPath() + "/" + finalPhoto%>" alt="Profile Photo" height="40" width="40" class="rounded-circle">
                            </td>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;"><%= rs.getString("hospital_name")%></td>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;"><%= rs.getString("branch")%></td>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;"><%= rs.getString("registration_id")%></td>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;"><%= rs.getString("email")%></td>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;"><%= rs.getString("mobile")%></td>
                            <td style="border:1px solid #624aa1;padding:8px; color:black; font-weight:lighter;">
                                <div class="btn-container" style="display: flex; justify-content: space-between; gap: 10px;">
                                    <form action="ApproveHospitalServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="hospitalId" value="<%= rs.getInt("id")%>">
                                        <input type="hidden" name="action" value="approve">
                                        <button type="submit" class="btn-approve">Approve</button>
                                    </form>
                                    <form action="ApproveHospitalServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="hospitalId" value="<%= rs.getInt("id")%>">
                                        <input type="hidden" name="action" value="reject">
                                        <button type="submit" class="btn-reject">Reject</button>
                                    </form>
                                </div>
                            </td>
                        </tr>

                        <%   }
                                rs.close();
                                stmt.close();
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>

                    </tbody>
                </table>
            </div>
        </div>
        <script>
            function approveHospital(button) {
                let row = button.closest("tr");
                row.style.backgroundColor = "#d4edda";
                alert("Hospital Approved!");
            }

            function rejectHospital(button) {
                let row = button.closest("tr");
                row.style.backgroundColor = "#f8d7da";
                alert("Hospital Rejected!");
            }
        </script>
    </body>

</html>

