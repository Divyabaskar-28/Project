<%-- 
    Document   : ChangePassword
    Created on : 15 Apr, 2025, 7:28:45 PM
    Author     : RAJASEKARAN
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
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
                overflow-x: hidden;
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

            @media (max-width: 576px) {
                .form-container {
                    padding: 15px;
                }
            }

        </style>
    </head>
    <body>
        <%@ include file="PDashboard.jsp" %>
        <%    String newPassword = request.getParameter("new_psw");
            String confirmPassword = request.getParameter("con_psw");

            if (newPassword != null && confirmPassword != null) {
                pemail = (String) session.getAttribute("parent_email");
                Connection con = null;
                PreparedStatement ps = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver"); // updated Driver
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                    String query = "UPDATE parent_details SET password = ?, updated_at = CURRENT_TIMESTAMP WHERE pemail = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, newPassword); // Suggest to hash password in real apps
                    ps.setString(2, pemail);

                    int rowsUpdated = ps.executeUpdate();
                    if (rowsUpdated > 0) {
        %>
        <script>

            window.location.href = "ParentDashboard.jsp";
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


        <div class="container">
            <div class="content">
                <div class="form-container">
                    <h2><b>Change Password</b></h2>
                    <form method="post" action="ChangePassword.jsp" onsubmit="return validatePassword(event)">

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
                    alert("Password must contain at least 1 uppercase letter, 1 number, and 1 special character.");
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

                alert("Password successfully changed!");
//                window.location.href = "ParentDashboard.jsp";
                return true;
            }


        </script>
    </body>
</html>
