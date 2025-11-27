<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vaccination Schedule</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
                font-family: Arial, sans-serif;
                padding: 40px;
            }
            h2 {
                text-align: center;
                color: #624aa1;
                margin-bottom: 20px;
                font-weight:bold;
            }
            .table-container {
                max-width: 900px;
                margin: auto;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }
            table {
                width: 100%;
                text-align: center;
            }
            td, th {
                padding: 10px;
                border: 1px solid #624aa1;
            }
        </style>
    </head>
    <body>

        <div class="table-container">
            <h2>Vaccination Schedule</h2>
            <table>
                <thead>
                    <tr>
                        <th>Age</th>
                        <th>Vaccination</th>
                        <th>Dose</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Load JDBC driver
                            Class.forName("com.mysql.jdbc.Driver");

                            // Connect to database
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                            // Create SQL query
                            String sql = "SELECT * FROM admin_schedule";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);

                            // Display data
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("age")%></td>
                        <td><%= rs.getString("vaccination_name")%></td>
                        <td><%= rs.getString("dose")%></td>

                    </tr>
                    <%
                        }
                    } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="3" style="color:red;">Error: <%= e.getMessage()%></td>
                    </tr>
                    <%
                        } finally {
                            if (rs != null) {
                                try {
                                    rs.close();
                                } catch (Exception e) {
                                }
                            }
                            if (stmt != null) {
                                try {
                                    stmt.close();
                                } catch (Exception e) {
                                }
                            }
                            if (conn != null) {
                                try {
                                    conn.close();
                                } catch (Exception e) {
                                }
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>

    </body>
</html>
