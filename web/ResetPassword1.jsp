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

                    if (email == null || email.trim().isEmpty()) {
                        message = "<div class='alert alert-danger'>Email is missing. Please retry the process.</div>";
                    } else if (newPassword != null && confirmPassword != null && newPassword.equals(confirmPassword)) {
                        try {
                            email = email.trim().toLowerCase(); // Ensuring no leading/trailing spaces and case insensitivity
                            role = (role != null) ? role.toLowerCase() : "";

                            String table = role.equals("hospital") ? "hospital_details" : "parent_details";
                            String emailCol = role.equals("hospital") ? "email" : "pemail";

                            // Database connection
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                            // Check if the user exists first
                            String checkSql = "SELECT * FROM " + table + " WHERE " + emailCol + " = ?";
                            PreparedStatement checkPst = con.prepareStatement(checkSql);
                            checkPst.setString(1, email);
                            ResultSet rs = checkPst.executeQuery();

                            if (rs.next()) {  // User exists
                                String sql = "UPDATE " + table + " SET password = ? WHERE " + emailCol + " = ?";
                                PreparedStatement pst = con.prepareStatement(sql);
                                pst.setString(1, newPassword);
                                pst.setString(2, email);

                                int updated = pst.executeUpdate();
                                if (updated > 0) {
                                    message = "<div class='alert alert-success'>Password updated successfully. Redirecting to login...</div>";
                                    response.setHeader("Refresh", "3; URL=Login.jsp");
                                } else {
                                    message = "<div class='alert alert-danger'>Failed to update password. Please try again.</div>";
                                }
                                pst.close();
                            } else {  // User doesn't exist
                                message = "<div class='alert alert-danger'>No user found with this email. Please check the email again.</div>";
                            }

                            rs.close();
                            checkPst.close();
                            con.close();
                        } catch (Exception e) {
                            message = "<div class='alert alert-danger'>Database error: " + e.getMessage() + "</div>";
                        }
                    } else {
                        message = "<div class='alert alert-danger'>Passwords do not match.</div>";
                    }
                }
            %>

            <!-- Hidden fields to persist email and role -->
            <form method="post">
                <input type="hidden" name="email" value="<%= (email != null) ? email : ""%>" />
                <input type="hidden" name="role" value="<%= (role != null) ? role : ""%>" />

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

            <div class="message"><%= message%></div>
        </div>
    </body>
</html>
