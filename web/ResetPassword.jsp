<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                background: url("Images/homeimg3.jpg") no-repeat center center fixed;
                background-size: cover;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .container {
                max-width: 500px;
                margin-top: 100px;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #4A148C;
            }

            .form-label {
                font-weight: bold;
                font-size: 18px;
            }

            .btn-primary {
                background-color: #6a1b9a;
                border: none;
            }

            .btn-primary:hover {
                background-color: #7b1fa2;
            }

            .message {
                text-align: center;
                font-weight: bold;
                margin-top: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Reset Password</h2>

            <%
                String role = request.getParameter("role");
                String email = request.getParameter("email");
                String message = "";

                if (request.getParameter("reset") != null) {
                    String newPassword = request.getParameter("newPassword");
                    String confirmPassword = request.getParameter("confirmPassword");

                    if (newPassword != null && confirmPassword != null && newPassword.equals(confirmPassword)) {
                        try {
                            email = email.trim();
                            role = role.toLowerCase();

                            // Define table and email column based on role
                            String table = role.equals("hospital") ? "hospital_details" : "parent_details";
                            String emailCol = role.equals("hospital") ? "email" : "pemail";

                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                            // SQL to update password
                            String sql = "UPDATE " + table + " SET password = ? WHERE " + emailCol + " = ?";
                            PreparedStatement pst = con.prepareStatement(sql);
                            pst.setString(1, newPassword);
                            pst.setString(2, email);

                            // Execute update and give feedback
                            int updated = pst.executeUpdate();
                            if (updated > 0) {
                                message = "Password updated successfully. Redirecting to login...";
                                response.setHeader("Refresh", "3; URL=Login.jsp");
                            } else {
                                message = "Failed to update password. Please check your email again.";
                            }

                            pst.close();
                            con.close();
                        } catch (Exception e) {
                            message = "Database error: " + e.getMessage();
                        }
                    } else {
                        message = "Passwords do not match.";
                    }
                }
            %>

            <!-- Hidden fields to persist email and role -->
            <form method="post">
                <input type="hidden" name="email" value="<%= email%>" />
                <input type="hidden" name="role" value="<%= role%>" />

                <div class="mb-3">
                    <label class="form-label">New Password</label>
                    <input type="password" name="newPassword" class="form-control" required />
                </div>

                <div class="mb-3">
                    <label class="form-label">Confirm Password</label>
                    <input type="password" name="confirmPassword" class="form-control" required />
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary" name="reset">Reset Password</button>
                </div>
            </form>

            <div class="message text-primary"><%= message%></div>
        </div>
    </body>
</html>
