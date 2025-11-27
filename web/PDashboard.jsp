<%-- 
    Document   : ParentDashboard
    Created on : 12 Apr, 2025, 2:21:12 PM
    Author     : RAJASEKARAN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Parent Layout</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                background-color: #624aa1;
                position: fixed;
                top: 0;
                left: 0;
                border-right: 1px solid #624aa1;
                overflow-y: auto;

            }
            .sidebar a {
                display: block;
                color: white;
                padding: 10px;
                text-decoration:none;
                border-bottom:1px solid white;
                font-weight:bold;
            }
            .sidebar a:hover {
                background-color: #7a5ecb;
            }
            .content {
                margin-left: 250px;
                padding: 10px;
                margin-top:50px;


            }
            .topbar {
                border:1px solid #624aa1;
                background-color: #624aa1;
                margin:0;
                padding:5px;
                position: fixed;
                top: 0;
                left: 250px;
                width: 100%;
                z-index: 1000; /* ensure it stays on top of other elements */

            }

            .profile-container {
                display: none;
                background: linear-gradient(to right, #a18cd1, #fbc2eb); 
                border-radius: 10px;
                padding: 15px;
                position: absolute;
                top: 50px;
                right: 20px;
                width: 300px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                z-index: 1000;
            }

            .profile-container p{
                color:black;
            }
            #edit{
                margin-left:40% ;
                color:white;
                background:#624aa1;
            }
            .modal-content {
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                border-radius: 15px;
            }
            .modal-dialog {
                max-width: 700px;  /* Set the desired width */
                margin: auto; /* Ensure it's centered */
            }
            .modal-dialog-centered {
                display: flex;
                justify-content: center; /* Horizontal centering */
                align-items: center; /* Vertical centering */
                height: 100vh; /* Full viewport height for vertical centering */
                margin: 0;
                margin-left:350px;
            }


        </style>
    </head>
    <body>
        <%
           String pemail = (String) session.getAttribute("parent_email"); // Corrected session attribute

            if (pemail == null) {
                // If session does not have parent_email, redirect to login page
                response.sendRedirect("ParentLogin.jsp");
                return;
            }

            String name = "", age = "", gender = "", mobile = "", address = "", profilePhoto = "";
           

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                // Corrected column name 'pemail' as per the table schema
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM parent_details WHERE pemail = ?");
                ps.setString(1, pemail);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    name = rs.getString("pname");
                    age = rs.getString("page");
                    gender = rs.getString("pgender");
                    pemail = rs.getString("pemail");
                    mobile = rs.getString("pmobile");
                    address = rs.getString("paddress");
                    profilePhoto = rs.getString("profile_photo"); // Fetch profile photo column
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <div class="sidebar">
            <h6 class="text-center text-black" style="background-color: white;">
                <span><img src="Images/logo4.png" height="30px" width="40px"></span>
                <i>CHILD VACCINATION MANAGEMENT SYSTEM</i>
            </h6>
            <a href="ParentDashboard.jsp"><i class="bi bi-speedometer2"></i> &nbsp; Dashboard</a>
            <a href="#" data-bs-toggle="modal" data-bs-target="#profileModal"><i class="bi bi-person-circle"></i> &nbsp; My Profile</a>
            <a href="AddChild1.jsp"><i class="bi bi-person-plus-fill"></i> &nbsp; Manage Child Data</a>
            <a href="BookAppointment.jsp"><i class="bi bi-calendar-event"></i> &nbsp; Book Appointment</a>
            
            <a href="MyRemainder.jsp"><i class="bi bi-bell-fill"></i> &nbsp; View Appointment</a>
            <a href="ChangePassword.jsp"><i class="bi bi-lock-fill"></i> &nbsp; Change Password</a>

        </div>

        <div class="topbar d-flex justify-content-end align-items-center px-3 text-white" style="min-height: 50px; z-index: 1000;">
            <div class="d-flex align-items-center position-relative" style="margin-right:250px;">
                <!-- Use the profile photo from the database or a default image if none exists -->
                <img src="<%= profilePhoto != null && !profilePhoto.isEmpty() ? profilePhoto : "Picture/Parents/defaultProfile.png"%>" 
                     alt="User" height="40px" width="40px" class="rounded-circle me-3" style="cursor: pointer;">
                <a href="Homepage.jsp" class="btn btn-sm" style="background: linear-gradient(to right, #8b6fc8, #e091c9); color:white; font-size: 18px; font-weight: bold;">Logout</a>

            </div>
        </div>

        <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="profileModalLabel" style="font-weight: bold; color:#624aa1;">My Profile</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <!-- Left side: Profile image -->
                            <div class="col-md-4 text-center">
                                <img src="<%= profilePhoto != null && !profilePhoto.isEmpty() ? profilePhoto : "Picture/arentsdefaultProfile.png"%>"
                                     alt="Profile Image" class="img-fluid rounded-circle" width="200px" height="200px">
                            </div>
                            <!-- Right side: Parent details -->
                            <div class="col-md-8">
                                <table class="table table-bordered">
                                    <tr>
                                        <th>Name</th>
                                        <td><%= name%></td>
                                    </tr>
                                    <tr>
                                        <th>Age</th>
                                        <td><%= age%></td>
                                    </tr>
                                    <tr>
                                        <th>Gender</th>
                                        <td><%= gender%></td>
                                    </tr>
                                    <tr>
                                        <th>Email</th>
                                        <td><%= pemail%></td>
                                    </tr>
                                    <tr>
                                        <th>Mobile</th>
                                        <td><%= mobile%></td>
                                    </tr>
                                    <tr>
                                        <th>Address</th>
                                        <td><%= address%></td>
                                    </tr>
                                </table>
                                <button class="btn" style="background-color:#624aa1; color:white; font-weight:bold; margin-left: 80px;" onclick="editProfile()">Edit Profile</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function editProfile() {
                if (confirm("Are you sure you want to edit your profile?")) {
                    window.location.href = "ParentEditProfile.jsp";
                }
            }
        </script>

    </body>
</html>
