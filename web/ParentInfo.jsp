<%-- 
    Document   : ParentInfo
    Created on : 11 May, 2025, 2:27:11 PM
    Author     : RAJASEKARAN
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Parent Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <style>
            body {
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
            }
            .table-container {
                margin: 50px auto;
                width: 83%;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow:0px 4px 10px rgba(0, 0, 0, 0.2);
                margin-left: 228px;
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
            }
            .profile-img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
            }


        </style>
    </head>
    <body>
        <%@ include file="ADashboard.jsp" %>
        <div class="table-container">
            <h2 style="color:#624aa1;font-weight:bold;">Parent Information</h2>
            <table>

                <thead>
                    <tr>
                        <th style="border:1px solid #624aa1; color:#624aa1; font-weight:bold; color:black;">#</th>
                        <th style="border:1px solid #624aa1; color:#624aa1; font-weight:bold; color:black;">Applied Date</th>
                        <th style="border:1px solid #624aa1; color:#624aa1; font-weight:bold; color:black;">Profile Photo</th>

                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold;color:black;">Name</th>
                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold;color:black;">Age</th>
                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold;color:black;">Gender</th>
                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold;color:black;">Email</th>

                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold; color:black;">Mobile</th>
                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold;color:black;">View Parent</th>

                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold;color:black;">View Child</th>
                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold;color:black;">Edit</th>
                        <th style="border:1px solid #624aa1;color:#624aa1;font-weight:bold;color:black;">Block / Unblock</th>


                    </tr>
                </thead>
                <tbody>
                    <%                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        int count = 1;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                            stmt = con.createStatement();
                            String query = "SELECT * FROM parent_details";
                            rs = stmt.executeQuery(query);
                            while (rs.next()) {
                                java.sql.Timestamp updatedAt = rs.getTimestamp("created_at");
                                String formattedDate = "";
                                if (updatedAt != null) {
                                    formattedDate = new SimpleDateFormat("dd-MM-yyyy").format(updatedAt);
                                }

                                String profilePhoto = rs.getString("profile_photo");
                                String defaultPhoto = "Picture/Parents/defaultProfile.png";
                                String photo = (profilePhoto != null && !profilePhoto.trim().isEmpty()) ? profilePhoto : defaultPhoto;
                                String email = rs.getString("pemail");
                    %>
                    <tr>
                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;"><%= count++%></td>
                        <td style="border:1px solid #624aa1; color:#624aa1; color:black;"><%= formattedDate%></td>

                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;"><img src="<%= request.getContextPath() + "/" + photo%>" class="profile-img" alt="Profile"></td>
                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;"><%= rs.getString("pname")%></td>
                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;"><%= rs.getInt("page")%></td>
                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;"><%= rs.getString("pgender")%></td>
                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;"><%= email%></td>

                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;"><%= rs.getString("pmobile")%></td>
                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;">
                            <button type="button" class="btn btn-sm d-flex align-items-center justify-content-center gap-2" style="background-color:#624aa1;color:white;"
                                    data-bs-toggle="modal" data-bs-target="#parentModal"
                                    onclick="populateParentModal(
                                                    '<%= rs.getString("pname").replace("'", "\\'")%>',
                                                    '<%= rs.getInt("page")%>',
                                                    '<%= rs.getString("pgender")%>',
                                                    '<%= email.replace("'", "\\'")%>',
                                                    '<%= rs.getString("pmobile")%>',
                                                    '<%= rs.getString("paddress").replace("'", "\\'")%>',
                                                    '<%= rs.getString("password").replace("'", "\\'")%>'
                                                    )">
                                <i class="bi bi-eye-fill"></i> View 
                            </button>
                        </td>
                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;">
                            <a href="ViewChildDetails.jsp?email=<%= email%>" 
                               class="btn btn-sm d-flex align-items-center justify-content-center gap-2" 
                               style="background-color: #624aa1; color: white;">
                                <i class="bi bi-eye-fill"></i> View
                            </a>

                        </td>
                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;">
                            <a href="EditParent.jsp?email=<%= email%>" 
                               class="btn btn-sm d-flex align-items-center justify-content-center gap-2" 
                               style="background-color: #624aa1; color: white;">
                                <i class="bi bi-pencil-fill"></i> Edit
                            </a>
                        </td>

                        <td style="border:1px solid #624aa1;color:#624aa1;color:black;">
                            <form action="BlockUnblockParent.jsp" method="post" style="margin: 0;">
                                <input type="hidden" name="email" value="<%= email%>">
                                <input type="hidden" name="action" value="<%= "yes".equals(rs.getString("is_blocked")) ? "unblock" : "block"%>">
                                <button type="submit" class="btn btn-sm"
                                        style="background-color:<%= "yes".equals(rs.getString("is_blocked")) ? "#28a745" : "#dc3545"%>; color:white; display: flex; align-items: center;">
                                    <i class="bi <%= "yes".equals(rs.getString("is_blocked")) ? "bi-unlock-fill" : "bi-lock-fill"%>" style="margin-right: 5px;"></i>
                                    <%= "yes".equals(rs.getString("is_blocked")) ? "Unblock" : "Block"%>
                                </button>
                            </form>
                        </td>






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

        <!-- Parent Details Modal -->
        <div class="modal fade" id="parentModal" tabindex="-1" aria-labelledby="parentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content" style="background: linear-gradient(to right, #a18cd1, #fbc2eb);">
                    <div class="modal-header">
                        <h5 class="modal-title" id="parentModalLabel" style="color:#624aa1;">Parent Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Name:</strong> <span id="modalName"></span></p>
                        <p><strong>Age:</strong> <span id="modalAge"></span></p>
                        <p><strong>Gender:</strong> <span id="modalGender"></span></p>
                        <p><strong>Email:</strong> <span id="modalEmail"></span></p>
                        <p><strong>Mobile:</strong> <span id="modalMobile"></span></p>
                        <p><strong>Address:</strong> <span id="modalAddress"></span></p>
                        <p><strong>Password:</strong> <span id="modalPassword"></span></p>
                    </div>

                </div>
            </div>
        </div>


        <script>
            function populateParentModal(name, age, gender, email, mobile, address, password) {
                document.getElementById('modalName').textContent = name;
                document.getElementById('modalAge').textContent = age;
                document.getElementById('modalGender').textContent = gender;
                document.getElementById('modalEmail').textContent = email;
                document.getElementById('modalMobile').textContent = mobile;
                document.getElementById('modalAddress').textContent = address;
                document.getElementById('modalPassword').textContent = password;
            }
        </script>

    </body>
</html>

