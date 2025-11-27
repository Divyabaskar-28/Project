<%-- 
    Document   : Schedule
    Created on : 16 Apr, 2025, 3:09:20 PM
    Author     : RAJASEKARAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vaccination Schedule</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--   <link href="./bootstrap1.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <!--   <script src="./script.js"></script>-->

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
                Padding: 20px;
                height: 200px;
                margin-left: 265px;
                margin-right: 20px;
            }

            .top-panel {
                padding: 10px;
                text-align: center;
                color: white;
                font-size: 20px;
                margin-left: 300px;
                margin-top:60px;
                margin-right: 20px;
            }
            label{
                font-weight:bold;
            }

            table {
                background: linear-gradient(to right, #a18cd1, #fbc2eb) !important;
                border-radius: 10px;
                overflow: hidden;
                border:2px solid #624aa1;
                margin-left:220px;
                width:72%;
                border:1px solid #624aa1;
            }

            table th, table td {

                padding: 10px;
                text-align: center;
            }

            table thead {
                background-color: #624aa1 !important;
                color: white !important;
            }
            @media (max-width: 768px) {
                .border-box {
                    padding: 15px;
                }

                .top-panel {
                    font-size: 18px;
                    margin-left: 10px;
                    margin-right: 10px;
                }

                table {
                    font-size: 14px;
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }

                .btn {
                    font-size: 14px;
                }

                .row {
                    flex-direction: column;
                }

                .col-md-4 {
                    width: 100%;
                }

                button {
                    width: 100%;
                    margin-bottom: 5px;
                }
            }

            @media (max-width: 400px) {
                .border-box {
                    padding: 10px;
                    margin-left: 10px;
                    margin-right: 10px;
                }

                .top-panel {
                    font-size: 16px;
                }

                table {
                    font-size: 12px;
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }

                .btn {
                    font-size: 12px;
                }

                .row {
                    flex-direction: column;
                }

                .col-md-4 {
                    width: 100%;
                }

                button {
                    width: 100%;
                    margin-bottom: 5px;
                }
            }



        </style>

    <body> 
        <%@ include file="HDashboard.jsp" %>
        <%   String hospitalEmail = (String) session.getAttribute("hospital_email"); // Check hospital login
            if (hospitalEmail == null) {
                response.sendRedirect("HospitalLogin.jsp"); // Redirect to login if not logged in
                return;
            }
            String url = "jdbc:mysql://localhost:3306/cvms"; // Your DB name
            String user = "root"; // Your DB username
            String pass = ""; // Your DB password

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);

            // INSERT operation (Add vaccination schedule)
            if (request.getParameter("vage") != null && request.getParameter("vname") != null && request.getParameter("vdose") != null) {

                String age = request.getParameter("vage");
                String vaccination = request.getParameter("vname");
                String dose = request.getParameter("vdose");

                PreparedStatement ps = con.prepareStatement("INSERT INTO vaccination_schedule (age, vaccination_name, dose, hospital_email) VALUES (?, ?, ?, ?)");
                ps.setString(1, age);
                ps.setString(2, vaccination);
                ps.setString(3, dose);
                ps.setString(4, hospitalEmail);
                ps.executeUpdate();
            }

            // DELETE operation (Delete vaccination schedule)
            if (request.getParameter("deleteId") != null) {
                int deleteId = Integer.parseInt(request.getParameter("deleteId"));
                PreparedStatement ps = con.prepareStatement("DELETE FROM vaccination_schedule WHERE id=? AND hospital_email=?");
                ps.setInt(1, deleteId);
                ps.setString(2, hospitalEmail);
                ps.executeUpdate();
            }
        %>

        <div id="AddForm" style="display:none">
            <form method="post" action="Schedule.jsp">   <!-- FORM ADDED -->
                <div class="top-panel">
                    <span style="color:#624aa1; font-size:30px;"><b>Vaccination Details</b></span>
                </div>

                <div class="border-box">
                    <div class="row">
                        <div class="col-md-4">
                            <label class="form-label">Age</label>
                            <input type="text" class="form-control" name="vage" id="age" maxlength="50">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Vaccination</label>
                            <input type="text" class="form-control" name="vname" id="vaccination">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Dose</label>
                            <input type="text" class="form-control" name="vdose" id="dose"> <!-- Corrected name -->
                        </div>
                    </div><br>

                    <div class="row mt-4">
                        <div class="col-md-12 text-center">
                            <button type="submit" class="btn" style="background-color:#624aa1; color:white;border: none;">Submit</button>
                            <button type="button" class="btn" onclick="hideForm()" style="background-color:#624aa1; color:white;border: none;">Cancel</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>


        <div class="container mt-5" id="gridpage" style="margin-left:75px;">
            <h3 class="text-center" style="font-weight: bold; color:#624aa1;margin-top:90px; margin-left: 260px;" >Vaccination Details</h3>
            <div class="row mt-4">
                <div style="margin-left:100px;">
                    <button class="btn mb-3" onclick="showForm()" style="background-color:#624aa1; color:white; border:none; margin-left:955px;">+ Add</button>
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Age</th>
                                <th>Vaccination</th>
                                <th>Dose</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <%
                            // Fetch vaccination schedule details
                            PreparedStatement stmt = con.prepareStatement("SELECT * FROM vaccination_schedule WHERE hospital_email=?");
                            stmt.setString(1, hospitalEmail);
                            ResultSet rs = stmt.executeQuery();
                            int i = 1;
                            while (rs.next()) {
                        %>
                        <tr>
                            <td><%= i++%></td>
                            <td><%= rs.getString("age")%></td>
                            <td><%= rs.getString("vaccination_name")%></td>
                            <td><%= rs.getString("dose")%></td>
                            <td>
                                <!-- Edit button (optional, if you have edit page) -->
                                <form method="get" action="EditVaccination.jsp" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= rs.getInt("id")%>">
                                    <button type="submit" class="btn btn-sm" style="color:#624aa1;">
                                        <i class="bi bi-pencil-square"></i>
                                    </button>
                                </form>
                                <!-- Delete button -->
                                <form method="post" action="Schedule.jsp" style="display:inline;">
                                    <input type="hidden" name="deleteId" value="<%= rs.getInt("id")%>">
                                    <button type="submit" class="btn btn-sm" style="color:#624aa1;" onclick="return confirm('Are you sure you want to delete this record?')">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                            con.close();
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>

            function saveForm(event) {

                event.preventDefault();

                var age = document.getElementById("age").value;
                var vaccination = document.getElementById("vaccination").value;
                var dose = document.getElementById("dose").value;

                if (age === '') {
                    alert("please enter the age details.");
                    document.getElementById("age").value();
                    return false;

                } else if (vaccination === '') {
                    alert("please enter the vaccination details.");
                    document.getElementById("vaccination").value();
                    return false;
                } else if (dose === '') {
                    alert("please enter the dose details.");
                    document.getElementById("dose").value();
                    return false;
                } else {
                    alert("Your vaccination details is successfully submitted!!");
//                    window.location.href = "schedule.html";
                    return true;
                }

            }
            function showForm() {
                let AddForm = document.getElementById("AddForm");
                let gridpage = document.getElementById("gridpage");
                if (AddForm.style.display === "none") {
                    AddForm.style.display = "block";
                    gridpage.style.display = "none";
                } else {
                    AddForm.style.display = "none";
                    gridpage.style.display = "block";
                }
            }
            function hideForm() {
                document.getElementById("age").value = '';
                document.getElementById("vaccination").value = '';
                document.getElementById("dose").value = '';


                document.getElementById("AddForm").style.display = "none";
                document.getElementById("gridpage").style.display = "block";
            }

        </script>
    </body>
</html>

