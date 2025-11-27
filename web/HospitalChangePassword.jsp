<%-- 
    Document   : HospitalChangePassword
    Created on : 26 Apr, 2025, 5:03:54 PM
    Author     : RAJASEKARAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hospital Change Password</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- <link href="./bootstrap1.css" rel="stylesheet"> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- <script src="./script.js"></script> -->


        <style>
            body {
                font-family: Arial, sans-serif;
                background-image: url("Images/homeimg3.jpg");  
                background-size: cover;
                background-position: center;
                margin: 0;
                padding: 0;
                height: 100vh;
                overflow: hidden;
            }
            .content {
                margin-left: 245px;

                padding: 20px;
                height: calc(100vh - 50px);
                overflow-y: auto;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            /* Form Styling */
            .form-container {
                max-width: 430px;
                width: 100%;
                padding: 20px;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                margin-bottom:110px;
            }

            .form-container h2 {
                color: #624aa1;
                text-align: center;
            }

            label {
                font-weight: bold;
                color: black;
            }

            .btn-submit {
                background-color: #624aa1;
                color: white;
                border: none;
                width: 100%;
                padding: 10px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-submit:hover {
                background-color: #7a5ecb;
            }
        </style>
    </head>
    <body>
        <%@ include file="HDashboard.jsp" %>
        <%            if (session.getAttribute("hospital_email") == null) {
                response.sendRedirect("HospitalLogin.jsp");
                return;
            }

            String newPassword = request.getParameter("new_psw");
            String confirmPassword = request.getParameter("con_psw");

            if (newPassword != null && confirmPassword != null) {
                email = (String) session.getAttribute("hospital_email"); // session contains email
                Connection con = null;
                PreparedStatement ps = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                    String query = "UPDATE hospital_details SET password = ? WHERE email = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, newPassword); // again, consider hashing the password
                    ps.setString(2, email);

                    int rowsUpdated = ps.executeUpdate();
                    if (rowsUpdated > 0) {
        %>
        <script>
            alert("Password updated successfully!");
            window.location.href = "HospitalDashboard.jsp"; // redirect after successful update
        </script>
        <%
        } else {
        %>
        <script>
            alert("Failed to update password.");
            window.history.back();
        </script>
        <%
                    }
                } catch (Exception e) {
                    out.println("<div style='color:red; text-align:center;'>Error: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (ps != null) {
                            ps.close();
                        }
                        if (con != null) {
                            con.close();
                        }
                    } catch (SQLException ex) {
                        out.println("<div style='color:red; text-align:center;'>Closing Error: " + ex.getMessage() + "</div>");
                    }
                }
            }
        %>

        <div class="content">
            <div class="form-container">
                <h2><b>Change Password</b></h2>
                <form method="post" action="HospitalChangePassword.jsp" onsubmit="return validatePassword(event)">

                    <!-- <div class="mb-3">
                        <label>Email</label>
                        <input type="email" class="form-control" id="email_id">
                    </div>
    
                    <div class="mb-3">
                        <label>Current Password</label>
                        <input type="password" class="form-control" id="current_password">
                    </div> -->

                    <div class="mb-3">
                        <label>New Password</label>
                        <input type="password" class="form-control" name="new_psw" id="new_password">
                    </div>

                    <div class="mb-3">
                        <label>Confirm New Password</label>
                        <input type="password" class="form-control" name="con_psw" id="confirm_password">
                    </div>

                    <input type="submit" class="btn-submit" value="Update Password">
                </form>
            </div>
        </div>
        <script>
            function validatePassword(event) {

                // var email = document.getElementById("email_id").value;
                // var currentPassword = document.getElementById("current_password").value.trim();
                var newPassword = document.getElementById("new_password").value.trim();
                var confirmPassword = document.getElementById("confirm_password").value.trim();

                // if(email === "")
                // {
                //     alert("Please enter yout email.");
                //     document.getElementById("email_id").focus();
                //     return false;
                // }

                // if (currentPassword === "") {
                //     alert("Please enter your current password.");
                //     document.getElementById("current_password").focus();
                //     return false;
                // }

                if (newPassword === "") {
                    alert("Please enter a new password.");
                    document.getElementById("new_password").focus();
                    return false;
                }
                var passwordPattern = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).+$/;

                if (!passwordPattern.test(newPassword)) {
                    alert("Password must be contain at least 1 uppercase letter, 1 number, and 1 special character.");
                    document.getElementById("new_password").focus();
                    return false;
                }

                if (confirmPassword === "") {
                    alert("Please confirm your new password.");
                    document.getElementById("confirm_password").focus();
                    return false;
                }

                var passwordPattern1 = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).+$/;
                if (!passwordPattern1.test(confirmPassword)) {
                    alert("Password must be contain at least 1 uppercase letter, 1 number, and 1 special character.");
                    document.getElementById("confirm_password").focus();
                    return false;
                }

                if (newPassword !== confirmPassword) {
                    alert("New password and confirm password do not match.");
                    document.getElementById("confirm_password").focus();
                    return false;
                }


//                window.location.href = "ParentDashboard.jsp";
                return true;
            }


        </script>
    </body>
</html>
