<%-- 
    Document   : UpdateHospitalProfile
    Created on : 23 Apr, 2025, 5:04:13 PM
    Author     : RAJASEKARAN
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
   String email = (String) session.getAttribute("hospital_email");

 // Email used for login
    int id = 0;
    String hospitalName = "", hospitalId = "", role = "", mobile = "", address = "", zipcode = "", city = "", state = "", country = "";

    if (email == null) {
        response.sendRedirect("HospitalLogin.jsp"); // Redirect if session is null
        return;
    }

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM hospital_details WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            id = rs.getInt("id");
            hospitalName = rs.getString("hospital_name");
            hospitalId = rs.getString("registration_id");
            role = rs.getString("role");
            mobile = rs.getString("mobile");
            address = rs.getString("address");              
            zipcode = rs.getString("zipcode");
            city = rs.getString("city");
            state = rs.getString("state");
            country = rs.getString("country");

            // Store in session
            session.setAttribute("hospitalId", id);
            session.setAttribute("hospitalName", hospitalName);
            session.setAttribute("registrationId", hospitalId);
            session.setAttribute("role", role);
            session.setAttribute("mobile", mobile);
            session.setAttribute("address", address);
            session.setAttribute("zipcode", zipcode);
            session.setAttribute("city", city);
            session.setAttribute("state", state);
            session.setAttribute("country", country);
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- <link href="./bootstrap1.css" rel="stylesheet"> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
            body{
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
            @media (max-width: 400px) {
                .sidebar {
                    transform: translateX(-250px);
                    position: absolute;
                }
                .content {
                    margin-left: 0;
                }
            }
        </style>
 <div class="sidebar">
            <h6 class="text-center text-black" style="background-color: white;"><span><img src="Images/logo4.png" height="30px" width="40px"></span>
                <i>CHILD VACCINATION MANAGEMENT SYSTEM</i>
            </h6>
            <a href="HospitalDashboard.jsp"><i class="bi bi-house-door"></i> &nbsp;Dashboard</a>
            <a href="Schedule.jsp"><i class="bi bi-calendar-plus"></i> &nbsp;TimeTable</a>
            <a href="HospitalViewAppointment.jsp"><i class="bi bi-calendar-check"></i> &nbsp;View Appointment</a>

        </div>

        <div class="topbar d-flex justify-content-end align-items-center px-3 text-white" style="min-height: 50px; z-index: 1000;">
            <div class="d-flex align-items-center position-relative">
                <img src="Images/profile3.jfif" alt="User" height="40px" width="40px" class="rounded-circle me-3" 
                     style="cursor: pointer;" onclick="toggleProfile()">
                <a href="Homepage.jsp" class="btn btn-sm" style="background: linear-gradient(to right, #8b6fc8, #e091c9); color:white;font-size: 18px; font-weight: bold;">Logout</a>


                <div id="profileContainer" class="profile-container">
                    <p><strong>Hospital Name:</strong> <%= hospitalName%></p>
                    <p><strong>Hospital ID:</strong> <%= hospitalId%></p>
                    <p><strong>Email:</strong> <%= email%></p>
                    <p><strong>Mobile:</strong> <%= mobile%></p>
                    <p><strong>Address:</strong> <%= address%></p>

                    <input type="submit" value="Edit" class="btn" id="edit" onclick="editProfile()">
                </div>
            </div>
        </div> 
                    
     <script>
            function toggleProfile() {
                let profile = document.getElementById("profileContainer");
                if (profile.style.display === "none" || profile.style.display === "") {
                    profile.style.display = "block";
                } else {
                    profile.style.display = "none";
                }
            }

            function editProfile() {
                if (confirm("Are you sure you want to edit your profile?")) {
                    window.location.href = "HospitalEditProfile.jsp";
                }
            }

        </script>
