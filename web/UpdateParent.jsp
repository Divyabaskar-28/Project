<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    int pageAge = Integer.parseInt(request.getParameter("page"));
    String gender = request.getParameter("gender");
    String mobile = request.getParameter("mobile");
    String address = request.getParameter("address");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
        PreparedStatement ps = con.prepareStatement("UPDATE parent_details SET pname=?, page=?, pgender=?, pmobile=?, paddress=?, password=? WHERE pemail=?");
        ps.setString(1, name);
        ps.setInt(2, pageAge);
        ps.setString(3, gender);
        ps.setString(4, mobile);
        ps.setString(5, address);
        ps.setString(6, password);
        ps.setString(7, email);

        int result = ps.executeUpdate();

        if (result > 0) {
            response.sendRedirect("ParentInfo.jsp?msg=success");
        } else {
            response.sendRedirect("ParentInfo.jsp?msg=fail");
        }

        ps.close();
        con.close();

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    }
%>
