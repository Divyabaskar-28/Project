<%@ page import="java.util.*, java.sql.*, javax.mail.*, javax.mail.internet.*, javax.activation.*" %>
<%
    String email = request.getParameter("email");
    String action = request.getParameter("action");

    Connection con = null;
    PreparedStatement ps = null;
    String newPassword = "";
    boolean isUnblocking = "unblock".equals(action);

    String subject = "";
    String message = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

        if (isUnblocking) {
            // Generate new password
            newPassword = UUID.randomUUID().toString().substring(0, 8);

            String updateSQL = "UPDATE parent_details SET is_blocked='no', lock_time=NULL, unlock_time=NOW(), password=? WHERE pemail=?";
            ps = con.prepareStatement(updateSQL);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();

            subject = "Account Unblocked - Child Vaccination System";
            message = "Dear Parent,\n\nYour account has been unblocked successfully.\nYour new password is: " + newPassword + "\n\nPlease login and change your password.\n\nRegards,\nChild Vaccination Management Team";

        } else {
            String updateSQL = "UPDATE parent_details SET is_blocked='yes', lock_time=NOW() WHERE pemail=?";
            ps = con.prepareStatement(updateSQL);
            ps.setString(1, email);
            ps.executeUpdate();

            subject = "Account Blocked - Child Vaccination System";
            message = "Dear Parent,\n\nYour account has been blocked due to administrative action.\nYou will not be able to log in until it is unblocked.\n\nRegards,\nChild Vaccination Management Team";
        }

        // Send the email
        sendMail(email, subject, message);

        response.sendRedirect("ParentInfo.jsp");

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
        }
    }

%>

<%!
    public void sendMail(String to, String subject, String messageText) {
        final String from = "dd.customerinfo@gmail.com"; // Replace with your email
        final String password = "gvue tqwq fozt atpn"; // Replace with app-specific password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from, "Child Vaccination System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(messageText);

            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
