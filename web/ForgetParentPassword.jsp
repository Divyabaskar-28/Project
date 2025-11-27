<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*, java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Parent - Forgot Password</title>
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
            <h2>Parent - Forgot Password</h2>

            <%
                String message = "";
                boolean showOTPField = false;

                if (request.getParameter("sendOtp") != null) {
                    String pemail = request.getParameter("pemail").trim();
                    session.setAttribute("email", pemail);

                    boolean emailExists = false;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                        String sql = "SELECT * FROM parent_details WHERE pemail=?";
                        PreparedStatement pst = con.prepareStatement(sql);
                        pst.setString(1, pemail);
                        ResultSet rs = pst.executeQuery();

                        if (rs.next()) {
                            String block_status = rs.getString("is_blocked");
                            if ("yes".equalsIgnoreCase(block_status)) {
                                out.println("<script>alert('Your account is blocked by admin. Password reset is not allowed.'); location='ForgetParentPassword.jsp';</script>");
                                rs.close();
                                pst.close();
                                con.close();
                                return;
                            }
                            emailExists = true;
                            rs.close();
                            pst.close();
                            con.close();
                        }

                    } catch (Exception e) {
                        message = "Database error: " + e.getMessage();
                    }

                    if (emailExists) {
                        int otp = new Random().nextInt(900000) + 100000;
                        session.setAttribute("otp", otp);
                        showOTPField = true;

                        final String from = "dd.customerinfo@gmail.com"; // Your email
                        final String password = "gvue tqwq fozt atpn";   // Your app password

                        Properties props = new Properties();
                        props.put("mail.smtp.host", "smtp.gmail.com");
                        props.put("mail.smtp.port", "587");
                        props.put("mail.smtp.auth", "true");
                        props.put("mail.smtp.starttls.enable", "true");

                        Session mailSession = Session.getInstance(props, new Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(from, password);
                            }
                        });

                        try {
                            Message msg = new MimeMessage(mailSession);
                            msg.setFrom(new InternetAddress(from));
                            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(pemail));
                            msg.setSubject("Your OTP for Password Reset");
                            msg.setText("Your OTP is: " + otp);
                            Transport.send(msg);
                            message = "OTP has been sent to your email.";
                        } catch (Exception e) {
                            message = "Failed to send OTP: " + e.getMessage();
                        }
                    } else {
                        message = "Email not found in our records.";
                    }
                } else if (request.getParameter("verifyOtp") != null) {
                    String userOtp = request.getParameter("otp");
                    Object sessionOtpObj = session.getAttribute("otp");
                    String pemail = (String) session.getAttribute("email");

                    if (sessionOtpObj != null) {
                        int sessionOtp = (Integer) sessionOtpObj;

                        if (userOtp != null && !userOtp.trim().isEmpty()) {
                            try {
                                if (Integer.parseInt(userOtp.trim()) == sessionOtp) {
                                    message = "OTP verified successfully! Redirecting...";
                                    session.removeAttribute("otp");

                                    response.setHeader("Refresh", "2; URL=ParentResetPassword.jsp?pemail=" + pemail);
                                } else {
                                    message = "Invalid OTP. Please try again.";
                                    showOTPField = true;
                                }
                            } catch (NumberFormatException e) {
                                message = "Invalid OTP format.";
                                showOTPField = true;
                            }
                        } else {
                            message = "Please enter the OTP.";
                            showOTPField = true;
                        }
                    } else {
                        message = "OTP session expired. Please try again.";
                    }
                }
            %>

            <!-- Step 1: Email Input -->
            <form method="post">
                <div class="mb-3">
                    <label class="form-label">Parent Email</label>
                    <input type="email" name="pemail" class="form-control" required
                           value="<%= request.getParameter("pemail") != null ? request.getParameter("pemail") : ""%>">
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary" name="sendOtp">Send OTP</button>
                </div>
            </form>

            <% if (showOTPField) { %>
            <hr>
            <!-- Step 2: OTP Verification -->
            <form method="post">
                <div class="mb-3">
                    <label class="form-label">Enter OTP</label>
                    <input type="text" name="otp" class="form-control" required />
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary" name="verifyOtp">Verify OTP</button>
                </div>
            </form>
            <% }%>

            <div class="message text-primary"><%= message%></div>
        </div>
    </body>
</html>
