<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login Validation</title>
    </head>
    <body>
        <%
            String uname = request.getParameter("uname");
            
            String upsw = request.getParameter("upsw");
            String urole = request.getParameter("urole");

            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            String dbURL = "jdbc:mysql://localhost:3306/cvms";
            String dbUser = "root";
            String dbPass = "";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                String query = "";

//                if ("admin".equals(urole)) {
//                    query = "SELECT * FROM admin_login WHERE email = ? AND password = ? AND role = ?";
//                    pst = con.prepareStatement(query);
//                    pst.setString(1, uname);
//                    pst.setString(2, upsw);
//                    pst.setString(3, urole);
//               }
             if ("hospital".equals(urole)) {
                    query = "SELECT * FROM hospital_details WHERE email = ? AND password = ? AND role = ?";
                    pst = con.prepareStatement(query);
                    pst.setString(1, uname);
                    pst.setString(2, upsw);
                    pst.setString(3, urole);
                } else if ("parents".equals(urole)) {
                    query = "SELECT * FROM parent_details WHERE pemail = ? AND password = ? AND prole = ?";
                    pst = con.prepareStatement(query);
                    pst.setString(1, uname);
                    pst.setString(2, upsw);
                    pst.setString(3, urole); // ✅ Now this matches the query
                }

                rs = pst.executeQuery();

                if (rs.next()) {
                    session.setAttribute("uname", uname);
                    session.setAttribute("urole", urole);

                    // ✅ Set correct session attribute for email
//                    if ("admin".equals(urole)) {
//
//                        response.sendRedirect("AdminDashboard.jsp");
//                    } else 
                        if ("hospital".equals(urole)) {

                        response.sendRedirect("HospitalDashboard.jsp");
                    }
                    else if ("parents".equals(urole)) {

                        response.sendRedirect("ParentDashboard.jsp");
                    }
                } else {
        %>
        <script>
            alert("Invalid username or password!");
            window.location.href = "Login.jsp";
        </script>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (pst != null) {
                        pst.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
