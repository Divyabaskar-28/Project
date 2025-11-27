<%-- 
    Document   : Sample
    Created on : 9 Apr, 2025, 3:37:06 PM
    Author     : RAJASEKARAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
           String name = request.getParameter("pname");
           String age = request.getParameter("page");
           String gender = request.getParameter("pgender");
           String email = request.getParameter("pemail");
           String mobile = request.getParameter("pmobile");
           String address = request.getParameter("paddress");
           String password = request.getParameter("pwd");
           String confirm_password = request.getParameter("cpwd");
           
           out.print("<b>The Parent Details is:</b>");
           out.print("<br> Your name is:" +name);
           out.print("<br> Your age is:" +age);
           out.print("<br> Your gender is:" +gender);
           out.print("<br> Your email id is:" +email);
           out.print("<br> Your mobile number is:" +mobile);
           out.print("<br> Your address is:" +address);
           out.print("<br> Your password is:" +password);
           out.print("<br> Your confirm password is:" +confirm_password);
           
           
           
        %>
    </body>
</html>
