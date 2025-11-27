<%-- 
    Document   : HospitalEditProfile
    Created on : 22 Apr, 2025, 5:34:38 PM
    Author     : RAJASEKARAN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>


<%
    String email = (String) session.getAttribute("hospital_email");
    if (email == null) {
        session.invalidate();
        response.sendRedirect("HospitalLogin.jsp");
        return;
    }

    String hospitalName = "", branch = "", registrationId = "", mobile = "", address = "", zipcode = "", city = "", state = "", country = "", photo = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM hospital_details WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            hospitalName = rs.getString("hospital_name");
            branch = rs.getString("branch");
            registrationId = rs.getString("registration_id");
            mobile = rs.getString("mobile");
            address = rs.getString("address");
            zipcode = rs.getString("zipcode");
            city = rs.getString("city");
            state = rs.getString("state");
            country = rs.getString("country");
            photo = rs.getString("photo");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Hospital Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
            }
            label {
                font-weight: bold;
            }
        </style>
    </head>
    <body">
        <div class="container mt-5">

            <form action="UpdateHospitalProfileServlet" method="post" enctype="multipart/form-data"  class="shadow p-4 rounded" 
                  style="background: linear-gradient(to right, #a18cd1, #fbc2eb); max-width: 500px; margin: auto;">
                <h2 class="text-center" style="color:#624aa1;">Edit Hospital Profile</h2>
                <div class="mb-3">
                    <label class="form-label">Hospital Name</label>
                    <input type="text" name="hospital_name" class="form-control" value="<%= hospitalName%>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Branch</label>
                    <input type="text" name="branch" class="form-control" value="<%= branch%>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Registration ID</label>
                    <input type="text" name="registration_id" class="form-control" value="<%= registrationId%>" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" value="<%= email%>" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mobile</label>
                    <input type="text" name="mobile" class="form-control" value="<%= mobile%>" required pattern="[0-9]{10}">
                </div>

                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <textarea name="address" class="form-control" required><%= address%></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Zipcode</label>
                    <input type="text" name="zipcode" class="form-control" value="<%= zipcode%>" required pattern="[0-9]{6}">
                </div>

                <div class="mb-3">
                    <label class="form-label">City</label>
                    <input type="text" name="city" class="form-control" value="<%= city%>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">State</label>
                    <input type="text" name="state" class="form-control" value="<%= state%>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Country</label>
                    <input type="text" name="country" class="form-control" value="<%= country%>" required>
                </div>

                <div class="mb-5">
                    <label class="form-label">Profile Photo</label><br>
                    <img src="<%= (photo != null && !photo.isEmpty()) ? photo : "Picture/Hospitals/defaultProfile.png"%>" width="100px" height="100px"><br>
                    <input type="file" name="photo" accept="image/*">
                </div>

                <div class="text-center">
                    <button type="submit" class="btn" style="background-color:#624aa1;color:white;">Update</button>
                    <a href="HospitalDashboard.jsp" class="btn" style="background-color:#624aa1;color:white;">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>
