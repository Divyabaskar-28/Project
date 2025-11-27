<%-- 
    Document   : AdminEditVaccination
    Created on : 14 May, 2025, 8:02:00 PM
    Author     : RAJASEKARAN
--%>

<%-- 
    Document   : EditVaccination
    Created on : 28 Apr, 2025, 2:51:42 PM
    Author     : RAJASEKARAN
--%>

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Edit Vaccination</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./script.js"></script>
    </head>
    <body>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
            }

            .border-box {
                position: relative;
                border: 3px solid #624aa1;
                border-radius: 10px;
                padding: 20px;
                margin-left: 150px;
                margin-right: 150px;
                width: 96%;
            }

            .top-panel {
                padding: 10px;
                text-align: center;
                color: #624aa1;
                font-size: 30px;
                font-weight: bold;
                margin-top: 60px;
            }

            label {
                font-weight: bold;
            }

            table {
                background: linear-gradient(to right, #a18cd1, #fbc2eb) !important;
                border-radius: 10px;
                overflow: hidden;
                border: 2px solid #624aa1;
                margin-left: 174px;
                overflow-x: auto;
            }

            table th, table td {
                padding: 10px;
                text-align: center;
            }

            table thead {
                background-color: #624aa1 !important;
                color: white !important;
            }

        </style>
        <%@ include file="ADashboard.jsp" %>
        <div class="container mt-5">
            <div class="top-panel">
                <span style="color:#624aa1; font-size:30px; margin-left:235px;"><b>Edit Vaccination Details</b></span>
            </div>
            <div class="border-box">
                <form name="vaccinationForm" action="AdminUpdateVaccination.jsp" method="post" onsubmit="return validateForm()">
                    <%                        String vaccinationId = request.getParameter("id");
                        String url = "jdbc:mysql://localhost:3306/cvms";
                        String user = "root";
                        String pass = "";
                        Connection con = DriverManager.getConnection(url, user, pass);
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM admin_schedule WHERE id = ?");
                        ps.setString(1, vaccinationId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {
                    %>
                    <!-- Form to edit the vaccination schedule details -->
                    <input type="hidden" name="id" value="<%= rs.getInt("id")%>">

                    <div class="row">
                        <div class="col-md-4">
                            <label class="form-label">Age</label>
                            <input type="text" class="form-control" name="vage" value="<%= rs.getString("age")%>" maxlength="50">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Vaccination Name</label>
                            <input type="text" class="form-control" name="vname" value="<%= rs.getString("vaccination_name")%>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Dose</label>
                            <input type="text" class="form-control" name="vdose" value="<%= rs.getString("dose")%>">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-12 text-center">
                            <button type="submit" class="btn" style="background-color:#624aa1; color:white; border: none;">Update</button>
                        </div>
                    </div>

                    <%
                        }
                        con.close();
                    %>
                </form>
            </div>
        </div>

        <script>
            function validateForm() {
                var vage = document.forms["vaccinationForm"]["vage"].value;
                var vname = document.forms["vaccinationForm"]["vname"].value;
                var vdose = document.forms["vaccinationForm"]["vdose"].value;

                // Validate Age (should be a positive number)
                if (vage == "") {
                    alert("Please enter a valid Age.");
                    return false;
                }

                // Validate Vaccination Name (should not be empty)
                if (vname == "") {
                    alert("Vaccination Name cannot be empty.");
                    return false;
                }

                // Validate Dose (should not be empty)
                if (vdose == "") {
                    alert("Dose cannot be empty.");
                    return false;
                }

                return true;
            }
        </script>


    </body>
</html>

