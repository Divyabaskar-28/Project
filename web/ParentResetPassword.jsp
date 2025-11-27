<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Parent Password</title>
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
            color: #624aa1;
        }

        .form-label {
            font-weight: bold;
        }

        .btn-success {
            background-color: #624aa1;
            border: none;
        }

        .btn-success:hover {
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
        <h2>Reset Parent Password</h2>

        <%
            String email = request.getParameter("pemail");
            String message = "";
            boolean showAlert = false;

            if (request.getParameter("resetPassword") != null) {
                String newPass = request.getParameter("newPassword");
                String confirmPass = request.getParameter("confirmPassword");

                if (newPass != null && confirmPass != null && newPass.equals(confirmPass)) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                        String sql = "UPDATE parent_details SET password=? WHERE pemail=?";
                        PreparedStatement pst = con.prepareStatement(sql);
                        pst.setString(1, newPass);
                        pst.setString(2, email);

                        int rows = pst.executeUpdate();

                        if (rows > 0) {
                            message = "Password reset successful! Redirecting to login...";
                            response.setHeader("Refresh", "3; URL=ParentLogin.jsp");
                        } else {
                            message = "Failed to reset password. Please try again.";
                            showAlert = true;
                        }

                        pst.close();
                        con.close();
                    } catch (Exception e) {
                        message = "Error: " + e.getMessage();
                        showAlert = true;
                    }
                } else {
                    message = "Passwords do not match!";
                    showAlert = true;
                }
            }
        %>

        <form method="post">
            <input type="hidden" name="pemail" value="<%= email %>" />

            <div class="mb-3">
                <label class="form-label">New Password</label>
                <input type="password" name="newPassword" class="form-control" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <input type="password" name="confirmPassword" class="form-control" required />
            </div>

            <div class="d-grid">
                <button type="submit" name="resetPassword" class="btn btn-success">Reset Password</button>
            </div>
        </form>

        <div class="message text-success"><%= message %></div>

        <% if (showAlert) { %>
        <script>
            alert("<%= message.replace("\"", "\\\"") %>");
        </script>
        <% } %>
    </div>
</body>
</html>
