<%-- 
    Document   : HospitalFeedback
    Created on : 17 May, 2025, 4:57:44 PM
    Author     : RAJASEKARAN
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
    <head>
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
                margin-top: 90px;
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
        <%@ include file="ADashboard.jsp" %>
        <%
            int k = 1;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                Statement stmt = conn.createStatement();

                String sql = "SELECT * FROM feedback ORDER BY submitted_at DESC";
                ResultSet rs = stmt.executeQuery(sql);
        %>
        <div class="content" style="margin-top:100px;">
            <div class="table-container table-responsive">
                <h2 style="color:#624aa1; font-weight: bold; text-align:center;">Feedback from Parents</h2>
                <table>
                    <thead>
                        <tr>
                            <th style="border:1px solid #624aa1;padding:8px;">#</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Parent Email</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Hospital Name</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Appointment Date</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Vaccine</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Child Name</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Rating</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Comments</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Submitted At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (rs.next()) {
                                int rating = rs.getInt("rating");

                        %>
                        <tr style="border:1px solid #624aa1;padding:8px;">
                            <td style="border:1px solid #624aa1;padding:8px;"><%= k++%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= rs.getString("parent_email")%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= rs.getString("hospital_name")%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= rs.getDate("appointment_date")%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= rs.getString("vaccine")%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= rs.getString("child_name")%></td>
                            <td style="color:green; font-weight:bold;border:1px solid #624aa1;padding:8px;">
                                <% for (int i = 0; i < rating; i++) { %>
                                <i class="bi bi-star-fill"></i>
                                <% }%>
                                
                            </td>

                            <td style="border:1px solid #624aa1;padding:8px;"><%= rs.getString("comments")%></td>
                            <%
                                Timestamp ts = rs.getTimestamp("submitted_at");
                                String formattedDate = "";
                                if (ts != null) {
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                                    formattedDate = sdf.format(ts);
                                }
                            %>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= formattedDate%></td>

                        </tr>
                        <%
                                }
                                rs.close();
                                stmt.close();
                                conn.close();
                            } catch (Exception e) {
                                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>

