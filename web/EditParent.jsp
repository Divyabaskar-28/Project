<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    String name = "", gender = "", mobile = "", address = "", password = "";
    int age = 0;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM parent_details WHERE pemail=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("pname");
            age = rs.getInt("page");
            gender = rs.getString("pgender");
            mobile = rs.getString("pmobile");
            address = rs.getString("paddress");
            password = rs.getString("password");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("Error fetching data: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Parent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
    <style>
          body {
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
            }
            label {
                font-weight: bold;
            }
    </style>   
</head>
<body">
    <div class="container mt-5">
        
        <form action="UpdateParent.jsp" method="post" class="mt-4"  class="shadow p-4 rounded" 
                  style="background: linear-gradient(to right, #a18cd1, #fbc2eb); max-width: 500px; margin: auto;padding:10px;border-radius:10px;">
            <h2 class="text-center" style="color:#624aa1;">Edit Parent Details</h2>
            <input type="hidden" name="email" value="<%= email %>">
            
            <div class="mb-3">
                <label>Name:</label>
                <input type="text" name="name" class="form-control" value="<%= name %>" required>
            </div>
            
            <div class="mb-3">
                <label>Age:</label>
                <input type="number" name="page" class="form-control" value="<%= age %>" required>
            </div>
            
            <div class="mb-3">
                <label>Gender:</label>
                <select name="gender" class="form-control" required>
                    <option value="Male" <%= gender.equals("Male") ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= gender.equals("Female") ? "selected" : "" %>>Female</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label>Mobile:</label>
                <input type="text" name="mobile" class="form-control" value="<%= mobile %>" required>
            </div>
            
            <div class="mb-3">
                <label>Address:</label>
                <textarea name="address" class="form-control" required><%= address %></textarea>
            </div>
            
            <div class="mb-3">
                <label>Password:</label>
                <input type="text" name="password" class="form-control" value="<%= password %>" required>
            </div>
            
            <div class="text-center">
                <button type="submit" class="btn" style="background-color:#624aa1;color:white;">Update</button>
            </div>
        </form>
    </div>
</body>
</html>
