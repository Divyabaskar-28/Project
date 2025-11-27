<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String pemail = (String) session.getAttribute("parent_email");
    if (pemail == null) {
        response.sendRedirect("ParentLogin.jsp");
        return;
    }

    String name = "", gender = "", mobile = "", address = "", profilePhoto = "";
    int age = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM parent_details WHERE pemail = ?");
        ps.setString(1, pemail);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("pname");
            age = rs.getInt("page");
            gender = rs.getString("pgender");
            mobile = rs.getString("pmobile");
            address = rs.getString("paddress");
            profilePhoto = rs.getString("profile_photo");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit Profile</title>
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
    <body>
        <div class="container mt-5">
            <form action="UpdateParentProfileServlet" method="post" enctype="multipart/form-data" 
                  class="shadow p-4 rounded" 
                  style="background: linear-gradient(to right, #a18cd1, #fbc2eb); max-width: 500px; margin: auto;">
                <h2 class="text-center" style="color:#624aa1;">Edit My Profile</h2>
                <div class="mb-3">
                    <label for="pname" class="form-label">Name</label>
                    <input type="text" class="form-control" name="pname" value="<%= name%>" required>
                </div>
                <div class="mb-3">
                    <label for="page" class="form-label">Age</label>
                    <input type="number" class="form-control" name="page" value="<%= age%>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Gender</label><br>
                    <input type="radio" name="pgender" value="Male" <%= gender.equals("Male") ? "checked" : ""%>> Male
                    <input type="radio" name="pgender" value="Female" <%= gender.equals("Female") ? "checked" : ""%>> Female
                </div>
                <div class="mb-3">
                    <label for="pmobile" class="form-label">Mobile</label>
                    <input type="text" class="form-control" name="pmobile" value="<%= mobile%>" required pattern="[0-9]{10}">
                </div>
                <div class="mb-3">
                    <label for="paddress" class="form-label">Address</label>
                    <textarea class="form-control" name="paddress" required><%= address%></textarea>
                </div>
                <div class="mb-5">
                    <label for="profile_photo" class="form-label">Profile Photo</label><br>
                    <img src="<%= profilePhoto != null && !profilePhoto.isEmpty() ? profilePhoto : "Picture/Parents/defaultProfile.png"%>" width="100px" height="100px"><br>
                    <input type="file" name="profile_photo" accept="image/*">
                </div>

                <div class="text-center">
                    <button type="submit" class="btn" style="background-color:#624aa1;color:white;">Update</button>
                    <a href="ParentDashboard.jsp" class="btn" style="background-color:#624aa1;color:white;">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>
