<%-- 
    Document   : BlockUnblockHospital
    Created on : 19 May, 2025, 3:27:06 PM
    Author     : RAJASEKARAN
--%>

<%@ page import="java.sql.*, java.util.*, javax.mail.*, javax.mail.internet.*, javax.activation.*" %>
<%
    String email = request.getParameter("email");
    String action = request.getParameter("action");

    String newPassword = "";
    String subject = "", body = "";

    try {
        // Load MySQL driver and connect
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
        PreparedStatement ps;

        // Block or unblock the hospital
        if ("block".equalsIgnoreCase(action)) {
            ps = con.prepareStatement("UPDATE hospital_details SET is_blocked = 'yes' WHERE email = ?");
            ps.setString(1, email);
            ps.executeUpdate();

            subject = "Your Hospital Account has been Blocked";
            body = "Dear Hospital,\n\nYour account has been blocked by the administrator. You will not be able to login or reset your password.\n\nRegards,\nCVMS Team";

        } else if ("unblock".equalsIgnoreCase(action)) {
            // Generate new password
            newPassword = UUID.randomUUID().toString().substring(0, 8);
            ps = con.prepareStatement("UPDATE hospital_details SET is_blocked = 'no', password = ? WHERE email = ?");
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();

            subject = "Your Hospital Account has been Unblocked";
            body = "Dear Hospital,\n\nYour account has been unblocked by the administrator.\nYour new login password is: " + newPassword + "\nPlease change your password after logging in.\n\nRegards,\nCVMS Team";
        }

        // Send Email Notification
        final String from = "dd.customerinfo@gmail.com";
        final String pass = "gvue tqwq fozt atpn"; // App-specific password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Rename mail session to avoid conflict with HttpSession
        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, pass);
            }
        });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject(subject);
        message.setText(body);

        Transport.send(message);

        response.sendRedirect("HospitalInfo.jsp?msg=" + action + "ed");
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
