<%-- 
    Document   : VaccinationDetails
    Created on : 1 May, 2025, 1:28:20 PM
    Author     : RAJASEKARAN
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Vaccination Report</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--<link href="./bootstrap1.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <!--<script src="./script.js"></script>-->
        <!--<script src="./vreport.js"></script>-->
        <style>
            body {
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;  
            }
            .container {
                margin-left:330px;
                margin-top:130px;

                background:linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            table{
                width:100%;
            }
            th, td {
                text-align: center;
                padding: 5px;
                border: 1px solid #624aa1;
            }
            label{
                font-weight:bold;
            }
            th{
                color:white;
                font-weight:bold;
                background-color: #624aa1;
                padding:10px;

            }
            tr:hover
            {
                background-color:#7a5ecb; ;
            }
        </style>
    </head>
    <body>
        <%@ include file="ADashboard.jsp" %>
        <div class="container" style="margin-left:340px; position:absolute;width:900px;">
            <h2 class="text-center mb-4" style="color:#624aa1;font-weight:bold;">Vaccination Report</h2>

            <form method="post">
                <div class="row mb-4">
                    <div class="col-md-5">
                        <label for="fromDate" class="form-label">From Date</label>
                        <input type="date" id="fromDate" name="fromDate" class="form-control" required>
                    </div>
                    <div class="col-md-5">
                        <label for="toDate" class="form-label">To Date</label>
                        <input type="date" id="toDate" name="toDate" class="form-control" required>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn" onclick="filterRecords()" style="background-color:#624aa1; color:white; width:100px;">Search</button>
                    </div>
                </div>
            </form>

            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th style="border:1x solid #624aa1; padding:8px;">#</th>
                            <th style="border:1x solid #624aa1; padding:8px;">Child Name</th>
                            <th style="border:1x solid #624aa1; padding:8px;">Child DOB</th>
                            <th style="border:1x solid #624aa1; padding:8px;">Hospital Name</th>
                            <th style="border:1x solid #624aa1; padding:8px;">Hospital Branch</th>
                            <th style="border:1x solid #624aa1; padding:8px;">Vaccination Type</th>
                            <th     style="border:1x solid #624aa1; padding:8px;">Injection Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            String fromDate = request.getParameter("fromDate");
                            String toDate = request.getParameter("toDate");

                            if (fromDate != null && toDate != null) {
                                Connection conn = null;
                                PreparedStatement stmt = null;
                                ResultSet rs = null;

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                                    String sql = "SELECT b.child_name, c.dob, b.hospital, b.hospital_branch, b.vaccine, b.appointment_date "
                                            + "FROM book_appointments b "
                                            + "JOIN child_details c ON b.child_name = c.name AND b.parent_email = c.parent_email "
                                            + "WHERE STR_TO_DATE(b.appointment_date, '%d-%m-%Y') BETWEEN STR_TO_DATE(?, '%Y-%m-%d') AND STR_TO_DATE(?, '%Y-%m-%d')";

                                    stmt = conn.prepareStatement(sql);
                                    stmt.setString(1, fromDate);
                                    stmt.setString(2, toDate);
                                    rs = stmt.executeQuery();
                                    
                                    int i = 1;
                                    boolean found = false;
                                    while (rs.next()) {
                                        found = true;
                        %>
                        <tr>
                            <td><%= i++%></td>
                            <td style="border:1x solid #624aa1; padding:8px;"><%= rs.getString("child_name")%></td>
                            <td style="border:1x solid #624aa1; padding:8px;"><%= rs.getString("dob")%></td>
                            <td style="border:1x solid #624aa1; padding:8px;"><%= rs.getString("hospital")%></td>
                            <td style="border:1x solid #624aa1; padding:8px;"><%= rs.getString("hospital_branch")%></td>
                            <td style="border:1x solid #624aa1; padding:8px;"><%= rs.getString("vaccine")%></td>
                            <td style="border:1x solid #624aa1; padding:8px;"><%= rs.getString("appointment_date")%></td>
                        </tr>
                        <%
                            }
                            if (!found) {
                        %>
                        <tr><td colspan="6" class="text-center">No records found for the selected date range.</td></tr>
                        <%
                            }
                        } catch (Exception e) {
                        %>
                        <tr><td colspan="6" style="color:red;">Error: <%= e.getMessage()%></td></tr>
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
                        } else {
                        %>
                        <tr><td colspan="6" class="text-center">Please select a date range and click "Search".</td></tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            function filterRecords() {
                const fromDate = document.getElementById("fromDate").value;
                const toDate = document.getElementById("toDate").value;

                if (!fromDate || !toDate) {
                    alert("Please select both From and To dates.");
                    return;
                }
            }
        </script>
    </body>
</html>
