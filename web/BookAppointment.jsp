<%-- 
    Document   : BookAppointment
    Created on : 27 Apr, 2025, 7:22:01 PM
    Author     : RAJASEKARAN
--%>

<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vaccination Schedule</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--        <link href="./bootstrap1.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            body {

                font-family: Arial, sans-serif;
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;


            }
            #table-container, #appointment {
                display: none;
            }
            .form-container {

                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                margin-top: 30px;

            }

            .con {

                margin-top: 25px;
                padding: 20px;
                overflow: auto; 
            }


            /* Content */
            .content {
                margin-left: 250px;
                margin-top: 30px;
                padding: 20px;
                height: 100vh;

            }

            label {
                font-weight: bold;
                color: black;
            }
            .table-container {
                max-width: 800px;
                margin: auto;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                font-size: 15px;

            }

            /*            table {
                            width: 100%;
                            text-align: center;
                            border-collapse: collapse;
                        }
            
                        th, td {
                            padding: 10px;
                            border: 1px solid #624aa1;
                        }*/

            .btn-appointment {
                background-color: #624aa1;
                border: none;
                color: white;
                padding: 7px;
                border-radius: 5px;
                cursor: pointer;
                width: 74%;
            }


            .btn-appointment:hover {
                background-color: #7a5ecb;
            }
            .btn-custom {
                background-color: #624aa1;
                color: white;
                border: none;
                padding: 10px;
                font-size: 18px;
            }

            .btn-custom:hover {
                background-color: #7a5ecb;
            }
            input[type="submit"]:disabled {
                background-color: red !important;
                color: white !important;
            }

        </style>
    </head>
    <body>
        <%@ include file="PDashboard.jsp" %> 
        <div class="content" style="overflow:hidden;">
            <div id="form-container" style="margin-left: 80px;margin-top: 30px;">
                <h2 style="color:#624aa1; font-weight: bold; text-align: center;">Enter Child Details</h2><br>
                <div class="row mb-4">
                    <div class="col-md-4">
                        <label for="childName" class="form-label">Child Name:</label>
                        <select class="form-select" id="childName" onchange="fetchDOB(), displayChildName()" required>
                            <option value="" disabled selected>-- Select Child --</option>
                            <%                        String parentEmail = (String) session.getAttribute("parent_email");
                                String url = "jdbc:mysql://localhost:3306/cvms";
                                String user = "root";
                                String pass = "";
                                Connection conn = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection(url, user, pass);
                                    String sql = "SELECT name FROM child_details WHERE parent_email = ?";
                                    ps = conn.prepareStatement(sql);
                                    ps.setString(1, parentEmail);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        String childName = rs.getString("name");
                            %>
                            <option value="<%= childName%>"><%= childName%></option>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (ps != null) {
                                        ps.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label for="dob" class="form-label">Date of Birth:</label>
                        <input type="text" id="dob" class="form-control" readonly>
                    </div>

                    <div class="col-md-4 d-flex align-items-end">
                        <button class="btn-appointment" onclick="return calculateSchedule(event)">Show Vaccination Schedule</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="table-container" id="table-container" style="margin-left: 390px; position:absolute;top:80px;">
            <%
                parentEmail = (String) session.getAttribute("parent_email");
                List<String> completedVaccines = new ArrayList<>();
                List<String> pendingVaccines = new ArrayList<>();

                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                ps = conn.prepareStatement("SELECT vaccine, status FROM book_appointments WHERE parent_email = ?");
                ps.setString(1, parentEmail);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String vaccine = rs.getString("vaccine");
                    String status = rs.getString("status");
                    if ("Completed".equalsIgnoreCase(status)) {
                        completedVaccines.add(vaccine);
                    } else if ("Pending".equalsIgnoreCase(status)) {
                        pendingVaccines.add(vaccine);
                    }
                }
            %>

            <h2  style="color:#624aa1;font-weight:bold;text-align: center;">Vaccination Schedule</h2>
            <table style="border:1px solid #624aa1;">
                <thead style="border:1px solid #624aa1;">
                    <tr>
                        <th style="border: 1px solid #624aa1; padding: 8px;">Age</th>
                        <th style="border: 1px solid #624aa1; padding: 8px;">Vaccination</th>
                        <th style="border: 1px solid #624aa1; padding: 8px;">Dose</th>
                        <th style="border: 1px solid #624aa1; padding: 8px;">Route</th>
                        <th style="border: 1px solid #624aa1; padding: 8px;">Site</th>
                        <th style="border: 1px solid #624aa1; padding: 8px;">Appointment</th>
<!--                        <th style="border: 1px solid #624aa1; padding: 8px;">Status</th>-->
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan="3" style="border: 1px solid #624aa1; padding: 8px;"><b>At Birth</b></td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">BCG</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">0.1 ml</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">Intra dermal</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">Left upper arm</td>
                        <td rowspan="3" style="border: 1px solid #624aa1; padding: 8px;">
                            <input type="submit" value="Get Appointment" onclick="validateForm(event)" style="background-color: #624aa1; border:none; color:white; padding:10px; border-radius: 5px;" id="birthBtn" class="vaccine-btn" disabled>
                        </td>
                        <!--<td rowspan="3" style="border: 1px solid #624aa1; padding: 8px;" id="status-birth">Upcoming</td>-->

                    </tr>
                    <tr>
                        <td style="border: 1px solid #624aa1; padding: 8px;">OPV Zero dose</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">2 drops</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">Oral</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">Oral</td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid #624aa1; padding: 8px;">Hep B birth dose (within 24 hours)</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">0.5 ml</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">Intra muscular</td>
                        <td style="border: 1px solid #624aa1; padding: 8px;">Antero-lateral aspect of the Mid thigh</td>
                    </tr>

                    <tr>
                        <td rowspan="4" style="border:1px solid #624aa1; padding:10px;"><b>6th Week</b></td>
                        <td style="border:1px solid #624aa1; padding:10px;">OPV-1</td>
                        <td style="border:1px solid #624aa1; padding:10px;">2 drops</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td rowspan="4" style="border:1px solid #624aa1; padding:10px;">
                            <input type="submit" value="Get Appointment" onclick="validateForm(event)"
                                   style="background-color: #624aa1; border:none; color:white; padding:10px; border-radius: 5px;"
                                   id="week6Btn" class="vaccine-btn" disabled>
                        </td>
                        <!--<td rowspan="4" style="border: 1px solid #624aa1; padding: 8px;" id="status-week6">Upcoming</td>-->

                    </tr>

                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">Penta-1</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.5 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Intra muscular</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Antero-lateral aspect of the Mid thigh</td>
                    </tr>

                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">IPV-1</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.1 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Intra dermal</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Right upper arm</td>
                    </tr>

                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">Rota-1</td>
                        <td style="border:1px solid #624aa1; padding:10px;">5 drops</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                    </tr>

                    <tr>
                        <td rowspan="3"><b>10th Week</b></td>
                        <td style="border:1px solid #624aa1; padding:10px;">OPV-2</td>
                        <td style="border:1px solid #624aa1; padding:10px;">2 drops</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td rowspan="3"style="border:1px solid #624aa1; padding:10px;"><input type="Submit" value="Get Appointment" onclick="validateForm(event)" style="background-color: #624aa1; border:none; color:white;
                                                                                              padding:10px; border-radius: 5px;" id="week10Btn" class="vaccine-btn" disabled>
                        </td>
                        <!--<td rowspan="3" style="border: 1px solid #624aa1; padding: 8px;" id="status-week10">Upcoming</td>-->
                    </tr>
                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">Rota-2</td>
                        <td style="border:1px solid #624aa1; padding:10px;">5 drops</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                    </tr>
                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">Penta-3</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.5 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Intra muscular</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Antero-lateral aspect of the Mid thigh</td>
                    </tr>


                    <tr>
                        <td rowspan="3" style="border:1px solid #624aa1; padding:10px;"><b>14th Week</b></td>
                        <td style="border:1px solid #624aa1; padding:10px;">OPV-3</td>
                        <td style="border:1px solid #624aa1; padding:10px;">2 drops</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td rowspan="3" style="border:1px solid #624aa1; padding:10px;"><input type="Submit" value="Get Appointment" onclick="validateForm(event)" style="background-color: #624aa1; border:none; color:white;
                                                                                               padding:10px; border-radius: 5px;" id="week14Btn" class="vaccine-btn" disabled>
                        </td>
                        <!--<td rowspan="3" style="border: 1px solid #624aa1; padding: 8px;" id=status-week14">Upcoming</td>-->
                    </tr>
                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">IPV-2</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.1 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Intra dermal</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Right upper arm</td>
                    </tr>
                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">Rota-3</td>
                        <td style="border:1px solid #624aa1; padding:10px;">5 drops</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                    </tr>

                    <tr>
                        <td rowspan="2" style="border:1px solid #624aa1; padding:10px;"><b>9 months (After 270 days)</b></td>
                        <td style="border:1px solid #624aa1; padding:10px;">MR 1st dose</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.5 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Subcutaneous</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Right upper arm</td>
                        <td rowspan="2" style="border:1px solid #624aa1; padding:10px;"><input type="Submit" value="Get Appointment" onclick="validateForm(event)" style="background-color: #624aa1; border:none; color:white;
                                                                                               padding:10px;border-radius: 5px;" id="month9Btn" class="vaccine-btn" disabled>
                        </td>
                        <!--<td rowspan="2" style="border: 1px solid #624aa1; padding: 8px;" id="status-month9">Upcoming</td>-->
                    </tr>
                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">JE 1 (in selected districts)</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.5 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Subcutaneous</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Left upper arm</td>
                    </tr>

                    <tr>
                        <td rowspan="4" style="border:1px solid #624aa1; padding:10px;"><b>16-24 months</b></td>
                        <td style="border:1px solid #624aa1; padding:10px;">DPT 1st booster</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.5 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Intra muscular</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Antero-lateral aspect of the Mid thigh</td>
                        <td rowspan="4" style="border:1px solid #624aa1; padding:10px;">
                            <input type="Submit" value="Get Appointment" onclick="validateForm(event)" style="background-color: #624aa1; border:none; color:white;
                                   padding:10px; border-radius: 5px;" id="month16_24Btn" class="vaccine-btn" disabled>
                        </td>
                        <!--<td rowspan="4" style="border: 1px solid #624aa1; padding: 8px;" id="status-month16_24">Upcoming</td>-->
                    </tr>

                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">OPV booster</td>
                        <td style="border:1px solid #624aa1; padding:10px;">2 drops</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Oral</td>
                    </tr>
                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">MR 2nd dose</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.5 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Subcutaneous</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Right upper arm</td>
                    </tr>
                    <tr>
                        <td style="border:1px solid #624aa1; padding:10px;">JE 2 (in selected districts)</td>
                        <td style="border:1px solid #624aa1; padding:10px;">0.5 ml</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Subcutaneous</td>
                        <td style="border:1px solid #624aa1; padding:10px;">Left upper arm</td>
                    </tr>
                </tbody>
            </table>
        </div>


        <div class="con" id="appointment" style="overflow:hidden;">
            <%
                String childName = request.getParameter("childName");
                String hospital = request.getParameter("hospital");
                String hospitalBranch = request.getParameter("hospitalBranch");
                String date = request.getParameter("date");
                String vaccine = request.getParameter("vaccine");
                parentEmail = (String) session.getAttribute("parent_email");

                if ("POST".equalsIgnoreCase(request.getMethod())) { // Check if form is submitted
                    Connection con = null;
                    PreparedStatement pst = null;
                    try {
                        String formattedDate = date;
                        if (date != null && !date.isEmpty()) {
                            try {
                                java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                java.util.Date parsedDate = inputFormat.parse(date);
                                formattedDate = outputFormat.format(parsedDate);
                            } catch (Exception ex) {
                                out.println("<p style='color:red;'>Date format error: " + ex.getMessage() + "</p>");
                            }
                        }
                        Class.forName("com.mysql.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                        String sql = "INSERT INTO book_appointments (child_name, hospital, hospital_branch, appointment_date, vaccine, parent_email, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

                        pst = con.prepareStatement(sql);
                        pst.setString(1, childName);
                        pst.setString(2, hospital);
                        pst.setString(3, hospitalBranch);
                        pst.setString(4, formattedDate);
                        pst.setString(5, vaccine);
                        pst.setString(6, parentEmail);
                        pst.setString(7, "pending"); // ? new line to set default status

                        int rows = pst.executeUpdate();
                        if (rows > 0) {
            %>
            <div class="alert alert-success" role="alert">
                Appointment booked successfully!
            </div>
            <%
            } else {
            %>
            <div class="alert alert-danger" role="alert">
                Failed to book appointment. Please try again.
            </div>
            <%
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            %>
            <div class="alert alert-danger" role="alert">
                Error: <%= ex.getMessage()%>
            </div>
            <%
                    } finally {
                        try {
                            if (pst != null) {
                                pst.close();
                            }
                            if (con != null) {
                                con.close();
                            }
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                }
            %>
            <div class="container form-container" style="margin-left: 70px; width:600px; margin-left: 480px; position:absolute; top:70px;">
                <h2 style="color:#624aa1;text-align: center; font-weight: bold;">Book Vaccination Appointment</h2>
                <form id="appointmentForm" action="BookAppointment.jsp" method="post" onsubmit="return bookAppointment(event)">

                    <!-- Select Child -->
                    <div class="mb-3">
                        <label for="selectedChild" class="form-label">Selected Child Name:</label>
                        <!-- This text field will display the selected child name -->
                        <input type="text" class="form-control" id="selectedChild" name="childName" readonly>

                    </div>

                    <!-- Hospital, Branch, Date, Vaccine - Properly inside row -->
                    <div class="row g-3">

                        <div class="col-md-6">
                            <label for="hospital" class="form-label">Hospital Name:</label>
                            <select id="hospital" name="hospital" required class="form-select" onchange="filterBranches()">
                                <option value="">-- Select Hospital --</option>

                                <%
                                    Connection con = null;

                                    try {
                                        Class.forName("com.mysql.jdbc.Driver");
                                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                                        ps = con.prepareStatement("SELECT DISTINCT hospital_name FROM hospital_details");
                                        rs = ps.executeQuery();

                                        while (rs.next()) {
                                %>
                                <option value="<%= rs.getString("hospital_name")%>"><%= rs.getString("hospital_name")%></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println("Error: " + e.getMessage());
                                    } finally {
                                        if (rs != null) {
                                            rs.close();
                                        }
                                        if (ps != null) {
                                            ps.close();
                                        }
                                        if (con != null) {
                                            con.close();
                                        }
                                    }
                                %>
                            </select>
                        </div>


                        <div class="col-md-6">
                            <label for="hospitalBranch" class="form-label">Hospital Branch:</label>
                            <select id="hospitalBranch" name="hospitalBranch" class="form-select" required>
                                <option value="">-- Select Branch --</option>
                            </select>
                        </div>


                        <!-- Appointment Date -->
                        <div class="col-md-6">
                            <label for="date" class="form-label">Date:</label>
                            <input type="date" class="form-control" id="date" name="date" required>
                        </div>

                        <!-- Vaccine -->
                        <div class="col-md-6">
                            <label for="vaccine" class="form-label">Vaccine:</label>
                            <select class="form-select" id="vaccine" name="vaccine" required>
                                <option value="" disabled selected>-- Select --</option>
                                <option value="BCG">BCG</option>
                                <option value="OPV Zero dose">OPV Zero dose</option>
                                <option value="Hep B birth dose (within 24 hours)">Hep B birth dose (within 24 hours)</option>
                                <option value="OPV-1">OPV-1</option>
                                <option value="Penta-1">Penta-1</option>
                                <option value="IPV-1">IPV-1</option>
                                <option value="Rota-1">Rota-1</option>
                                <option value="OPV-2">OPV-2</option>
                                <option value="Rota-2">Rota-2</option>
                                <option value="Penta-3">Penta-3</option>
                                <option value="OPV-3">OPV-3</option>
                                <option value="IPV-2">IPV-2</option>
                                <option value="Rota-3">Rota-3</option>
                                <option value="MR 1st dose">MR 1st dose</option>
                                <option value="JE 1 (in selected districts)">JE 1 (in selected districts)</option>
                                <option value="DPT 1st booster">DPT 1st booster</option>
                                <option value="OPV booster">OPV booster</option>
                                <option value="MR 2nd dose">MR 2nd dose</option>
                                <option value="JE 2 (in selected districts)">JE 2 (in selected districts)</option>
                            </select>
                        </div>

                    </div> <!-- End of Row -->

                    <!-- Buttons -->
                    <div class="d-grid gap-3 mt-4">
                        <button type="submit" class="btn btn-custom" style="background-color: #624aa1; color: white; border: none; padding: 10px; font-size: 18px;">
                            Book Appointment
                        </button>
                        <button type="reset" class="btn btn-custom" style="background-color: #624aa1; color: white; border: none; padding: 10px; font-size: 18px;">
                            Clear
                        </button>
                    </div>

                </form>
            </div>

            <script>
                window.onload = function () {
                    document.getElementById('table-container').style.display = "none";
                    document.getElementById('appointment').style.display = "none";
                };

                function fetchDOB() {
                    var childName = document.getElementById("childName").value;

                    if (childName !== "") {
                        var xhr = new XMLHttpRequest();
                        xhr.open("GET", "GetDOB.jsp?childName=" + encodeURIComponent(childName), true);
                        xhr.onreadystatechange = function () {
                            if (xhr.readyState == 4 && xhr.status == 200) {
                                document.getElementById("dob").value = xhr.responseText;
                            }
                        };
                        xhr.send();
                    }
                }

                function calculateSchedule(event) {
                    // Fetch the child name and DOB values
                    var childName = document.getElementById('childName').value;
                    var dobStr = document.getElementById("dob").value;

                    // Validate if child name is selected
                    if (childName === '') {
                        alert("Please select child name.");
                        document.getElementById('childName').focus();
                        return false;
                    }

                    // Validate if DOB is found for the selected child
                    if (dobStr === '') {
                        alert("DOB not found for selected child.");
                        return false;
                    }

                    // Hide form and show the table
                    document.getElementById("form-container").style.display = "none";
                    document.getElementById("table-container").style.display = "block";

                    // Function to parse dd-mm-yyyy format into a Date object
                    function parseDate(dateStr) {
                        const parts = dateStr.split('-'); // Split by dash instead of comma
                        if (parts.length === 3) {
                            const day = parseInt(parts[0], 10);
                            const month = parseInt(parts[1], 10) - 1; // Month is 0-based in JS Date
                            const year = parseInt(parts[2], 10);
                            return new Date(year, month, day);
                        }
                        return null;
                    }

                    // Parse the date entered in dd-mm-yyyy format
                    const dob = parseDate(dobStr);
                    if (!dob) {
                        alert("Invalid Date of Birth format. Please use dd-mm-yyyy format.");
                        return;
                    }

                    const today = new Date();

                    // Calculate age in days
                    const ageInMs = today - dob;
                    const ageInDays = ageInMs / (1000 * 60 * 60 * 24);

                    // Reset all buttons to disabled first
                    const buttons = document.querySelectorAll(".vaccine-btn");
                    buttons.forEach(btn => btn.disabled = true);

                    const vaccineDropdown = document.getElementById('vaccine');

// 2. First, clear previous options
                    vaccineDropdown.innerHTML = '<option value="" disabled selected>-- Select --</option>';

                    let eligibleVaccines = [];


                    // Enable buttons based on child's age
                    if (ageInDays >= 0 && ageInDays < 42) {
                        document.getElementById("birthBtn").disabled = false;
                        eligibleVaccines = ["BCG", "OPV Zero dose", "Hep B birth dose (within 24 hours)"];
                    }
                    if (ageInDays >= 42 && ageInDays < 70) {
                        document.getElementById("week6Btn").disabled = false;
                        eligibleVaccines = ["OPV-1", "Penta-1", "IPV-1", "Rota-1"];
                    }
                    if (ageInDays >= 70 && ageInDays < 98) {
                        document.getElementById("week10Btn").disabled = false;
                        eligibleVaccines = ["OPV-2", "Rota-2", "Penta-3"];
                    }
                    if (ageInDays >= 98 && ageInDays < 270) {
                        document.getElementById("week14Btn").disabled = false;
                        eligibleVaccines = ["OPV-3", "IPV-2", "Rota-3"];
                    }
                    if (ageInDays >= 270 && ageInDays < 480) {
                        document.getElementById("month9Btn").disabled = false;
                        eligibleVaccines = ["MR 1st dose", "JE 1 (in selected districts)"];
                    }
                    if (ageInDays >= 480 && ageInDays <= 730) {
                        document.getElementById("month16_24Btn").disabled = false;
                        eligibleVaccines = ["DPT 1st booster", "OPV booster", "MR 2nd dose", "JE 2 (in selected districts)"];
                    }

//                    function updateStatus(sectionId, statusText) {
//                        document.getElementById(sectionId).textContent = statusText;
//                    }
//
//// Reset all statuses to Upcoming
//                    updateStatus("status-birth", "Upcoming");
//                    updateStatus("status-week6", "Upcoming");
//                    updateStatus("status-week10", "Upcoming");
//                    updateStatus("status-week14", "Upcoming");
//                    updateStatus("status-month9", "Upcoming");
//                    updateStatus("status-month16_24", "Upcoming");
//
//// Update status based on current age
//                    // Update status column based on age
//                    if (ageInDays >= 0 && ageInDays < 42) {
//                        updateStatus("status-birth", "Current");
//                    } else if (ageInDays >= 42 && ageInDays < 70) {
//                        updateStatus("status-birth", "Check DB");
//                        updateStatus("status-week6", "Current");
//                    } else if (ageInDays >= 70 && ageInDays < 98) {
//                        updateStatus("status-birth", "Check DB");
//                        updateStatus("status-week6", "Check DB");
//                        updateStatus("status-week10", "Current");
//                    } else if (ageInDays >= 98 && ageInDays < 270) {
//                        updateStatus("status-birth", "Check DB");
//                        updateStatus("status-week6", "Check DB");
//                        updateStatus("status-week10", "Check DB");
//                        updateStatus("status-week14", "Current");
//                    } else if (ageInDays >= 270 && ageInDays < 480) {
//                        updateStatus("status-birth", "Check DB");
//                        updateStatus("status-week6", "Check DB");
//                        updateStatus("status-week10", "Check DB");
//                        updateStatus("status-week14", "Check DB");
//                        updateStatus("status-month9", "Current");
//                    } else if (ageInDays >= 480 && ageInDays <= 730) {
//                        updateStatus("status-birth", "Check DB");
//                        updateStatus("status-week6", "Check DB");
//                        updateStatus("status-week10", "Check DB");
//                        updateStatus("status-week14", "Check DB");
//                        updateStatus("status-month9", "Check DB");
//                        updateStatus("status-month16_24", "Current");
//                    }


                    // Populate vaccine dropdown with eligible vaccines
                    eligibleVaccines.forEach(vaccine => {
                        const option = document.createElement('option');
                        option.value = vaccine;
                        option.textContent = vaccine;
                        vaccineDropdown.appendChild(option);
                    });

                    // Show the vaccination schedule table
                    document.getElementById("table-container").style.display = "block";
                }

                function validateForm(event) {

                    let confirmBooking = confirm("Do you want to book this appointment?");
                    if (confirmBooking) {
                        document.getElementById("table-container").style.display = "none";
                        document.getElementById("appointment").style.display = "block";
                    }
                }
                function displayChildName() {
                    // Get the selected value from the childName dropdown
                    var selectedChild = document.getElementById("childName").value;

                    // Set the selected child name into the text field
                    document.getElementById("selectedChild").value = selectedChild;
                }
                var hospitalBranches = {};

                <%
                    Connection con2 = null;
                    PreparedStatement ps2 = null;
                    ResultSet rs2 = null;
                    try {
                        con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                        ps2 = con2.prepareStatement("SELECT hospital_name, branch FROM hospital_details");
                        rs2 = ps2.executeQuery();
                        while (rs2.next()) {
                %>
                if (!hospitalBranches['<%= rs2.getString("hospital_name")%>']) {
                    hospitalBranches['<%= rs2.getString("hospital_name")%>'] = [];
                }
                hospitalBranches['<%= rs2.getString("hospital_name")%>'].push('<%= rs2.getString("branch")%>');
                <%
                        }
                    } catch (Exception e) {
                        out.println("Error loading branch data: " + e.getMessage());
                    } finally {
                        if (rs2 != null) {
                            rs2.close();
                        }
                        if (ps2 != null) {
                            ps2.close();
                        }
                        if (con2 != null) {
                            con2.close();
                        }
                    }
                %>

                function filterBranches() {
                    var hospitalSelect = document.getElementById("hospital");
                    var branchSelect = document.getElementById("hospitalBranch");
                    var selectedHospital = hospitalSelect.value;

                    // Clear existing branch options
                    branchSelect.innerHTML = '<option value="">-- Select Branch --</option>';

                    if (hospitalBranches[selectedHospital]) {
                        var branches = hospitalBranches[selectedHospital];
                        for (var i = 0; i < branches.length; i++) {
                            var option = document.createElement("option");
                            option.value = branches[i];
                            option.text = branches[i];
                            branchSelect.appendChild(option);
                        }
                    }
                }
                function bookAppointment(event) {

                    let childName = document.getElementById("childName").value;
                    let hospital = document.getElementById("hospital").value;
                    let hospitalBranch = document.getElementById("hospitalBranch").value;
                    let date = document.getElementById("date").value;
                    let vaccine = document.getElementById("vaccine").value;

                    if (childName === "") {
                        alert("Please select the Child name.");
                        document.getElementById("childName").focus();
                        return false;
                    }
                    if (hospital === "") {
                        alert("Please select the hospital name.");
                        document.getElementById("hospital").focus();
                        return false;
                    }
                    if (hospitalBranch === "") {
                        alert("Please select the hospital branch.");
                        document.getElementById("hospitalBranch").focus();
                        return false;
                    }
                    if (date === "") {
                        alert("Please select the appointment date.");
                        document.getElementById("date").focus();
                        return false;
                    }
                    if (vaccine === "") {
                        alert("Please select the Vaccine type.");
                        document.getElementById("vaccine").focus();
                        return false;
                    }

                    alert("Appointment booked for " + childName + " at " + hospital + " on " + date + " for " + vaccine + ".");
                   
                    window.location.href = "MyRemainder.jsp";

                }
                function fetchBranches(hospitalName) {
                    var xhr = new XMLHttpRequest();
                    xhr.open("GET", "fetchBranches.jsp?hospitalName=" + encodeURIComponent(hospitalName), true);
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            document.getElementById("hospitalBranch").innerHTML = xhr.responseText;
                        }
                    };
                    xhr.send();
                }
            </script>
    </body>
</html>
