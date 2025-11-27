<%-- 
    Document   : MyRemainder
    Created on : 21 Apr, 2025, 11:18:06 AM
    Author     : RAJASEKARAN
--%>


<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Child Appointment Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--<link href="./bootstrap1.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <!--<script src="./script.js"></script>-->
        <!--<script src="./remlayout.js"></script>-->
        <style>
            body {
                font-family: Arial, sans-serif;
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
                margin: 0;
                padding: 0;
                height: 100vh;

            }

            .container {
                margin-top: 20px;
                max-width: 900px;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                margin-right: 110px;

            }
            .table-container {
                max-width: 900px;
                margin: auto;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                margin-top:40px;

            }

            table {
                width: 100%;
                text-align: center;
                border-collapse: collapse;

            }

            th, td {
                padding: 10px;
                border: 1px solid #624aa1;
            }
            @media (max-width: 576px) {
                .container {
                    margin-top: 20px;
                }
                .table-container {
                    margin-top: 10px;
                }
            }

            @media (max-width: 576px) {
                h3 {
                    font-size: 1.2rem;  /* Smaller font size for smaller screens */
                }

                table th, td {
                    font-size: 0.9rem;  /* Adjusted font size for better readability */
                    padding: 8px;  /* Reduced padding for small screens */
                }
            }


        </style>
    </head>
    <body>
        <%@ include file="PDashboard.jsp" %> 
        <div class="container-fluid">
            <div class="content">
                <div class="table-container">
                    <h3 style="color:#624aa1; font-weight: bold; text-align:center;">Child Appointment Details</h3>
                    <div class="table-responsive">
                        <table style="border:1px solid #624aa1;">
                            <thead>
                                <tr>
                                    <th style="border: 1px solid #624aa1; padding:10px;">Child Name</th>
                                    <th style="border: 1px solid #624aa1; padding:10px;">Hospital</th>
                                    <th style="border: 1px solid #624aa1; padding:10px;">Date</th>
                                    <th style="border: 1px solid #624aa1; padding:10px;">Vaccine</th>
                                    <th style="border: 1px solid #624aa1; padding:10px;">Status</th>



                                </tr>
                            </thead>
                            <tbody>
                                <%                            String url = "jdbc:mysql://localhost:3306/cvms";
                                    String user = "root";
                                    String pass = "";
                                    String parentEmail = (String) session.getAttribute("parent_email"); // assuming parent login session

                                    Connection conn = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs = null;
                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        conn = DriverManager.getConnection(url, user, pass);

                                        String sql = "SELECT child_name, hospital, appointment_date, vaccine, status, incomplete_reason, rejection_reason FROM book_appointments WHERE parent_email = ?";
                                        ps = conn.prepareStatement(sql);
                                        ps.setString(1, parentEmail);
                                        rs = ps.executeQuery();

                                        while (rs.next()) {
                                            String childName = rs.getString("child_name");
                                            String hospital = rs.getString("hospital");
                                            String date = rs.getString("appointment_date");
                                            String vaccine = rs.getString("vaccine");
                                            String status = rs.getString("status");
                                            String reason = rs.getString("incomplete_reason");
                                            String rejectionReason = rs.getString("rejection_reason");


                                %>
                                <tr>
                                    <td style="border: 1px solid #624aa1; padding:10px;"><%= childName%></td>
                                    <td style="border: 1px solid #624aa1; padding:10px;"><%= hospital%></td>
                                    <td style="border: 1px solid #624aa1; padding:10px;"><%= date%></td>
                                    <td style="border: 1px solid #624aa1; padding:10px;"><%= vaccine%></td>
                                    <td style="border: 1px solid #624aa1; padding:10px;">
                                        <% if ("approved".equalsIgnoreCase(status)) { %>
                                        <span class="badge bg-success">Approved</span>
                                        <% } else if ("rejected".equalsIgnoreCase(status)) { %>
                                        <span class="badge bg-danger">Rejected</span>
                                        <% if (rejectionReason != null && !rejectionReason.trim().isEmpty()) {%>
                                        <br><small><strong>Reason:</strong> <%= rejectionReason%></small>
                                        <% } %>
                                        <% } else if ("completed".equalsIgnoreCase(status)) { %>
                                        <span class="badge bg-primary">Completed</span>
                                        <% } else if ("incompleted".equalsIgnoreCase(status)) { %>
                                        <span class="badge bg-secondary">Incompleted</span>
                                        <% if (reason != null && !reason.trim().isEmpty()) {%>
                                        <br><small><strong>Reason:</strong> <%= reason%></small>
                                        <% } %>
                                        <% } else { %>
                                        <span class="badge bg-warning text-dark">Pending</span>
                                        <% } %>
                                    </td>

                                </tr>
                                <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                %>
                                <tr>
                                    <td colspan="4">Error fetching data.</td>
                                </tr>
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
            </div>
        </div>

    </body>

</html>

