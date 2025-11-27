<%-- 
    Document   : EditChild
    Created on : 14 Apr, 2025, 8:08:58 PM
    Author     : RAJASEKARAN
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Child Edit Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--     <link href="./bootstrap1.css" rel="stylesheet">-->
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

            /*            .border-box {
                            position: relative;
                            border: 3px solid #624aa1;
                            Padding: 20px;
                            height: 430px;
                            margin-left: 265px;
                            margin-right: 20px;
                        }*/

            .border-box {
                position: relative;
                border: 3px solid #624aa1;
                border-radius: 10px;
                padding: 20px;
                margin-left: 150px;
                margin-right: 150px;
                width:96%;
            }


            /*            .top-panel {
                            padding: 10px;
                            text-align: center;
                            color: white;
                            font-size: 20px;
                            margin-left: 300px;
                            margin-top:60px;
                            margin-right: 20px;
                        }*/

            .top-panel {
                padding: 10px;
                text-align: center;
                color: #624aa1;
                font-size: 30px;
                font-weight: bold;
                margin-top: 60px;
            }

            label{
                font-weight:bold;
            }

            table {
                background: linear-gradient(to right, #a18cd1, #fbc2eb) !important;
                border-radius: 10px;
                overflow: hidden;
                border:2px solid #624aa1;
                margin-left:174px;
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
        <div class="container mt-5">
            <div class="top-panel">
                <span style="color:#624aa1; font-size:30px; margin-left:235px;"><b>Child Details</b></span>
            </div>
            <div class="border-box">
                <form action="UpdateChild.jsp" method="post">
                    <%
                        String childId = request.getParameter("id");
                        String url = "jdbc:mysql://localhost:3306/cvms";
                        String user = "root";
                        String pass = "";
                        Connection con = DriverManager.getConnection(url, user, pass);
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM child_details WHERE id = ?");
                        ps.setString(1, childId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {
                    %>
                    <!-- Form to edit the child details -->
                    <input type="hidden" name="id" value="<%= rs.getInt("id")%>">

                    <div class="row">
                        <div class="col-md-4">
                            <label class="form-label">Child Name</label>
                            <input type="text" class="form-control" name="cname" value="<%= rs.getString("name")%>" maxlength="50">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" name="cdob" value="<%= rs.getString("dob")%>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Gender</label>
                            <select class="form-control" name="cgender">
                                <option value="<%= rs.getString("gender")%>" selected><%= rs.getString("gender")%></option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-md-4">
                            <label class="form-label">Age</label>
                            <input type="text" class="form-control" name="cage" value="<%= rs.getString("age")%>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Blood Group</label>
                            <select class="form-control" name="cblood">
                                <option value="<%= rs.getString("blood_group")%>" selected><%= rs.getString("blood_group")%></option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Weight (kg)</label>
                            <input type="text" class="form-control" name="cweight" value="<%= rs.getFloat("weight")%>" min="1" max="50">
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-md-4">
                            <label class="form-label">Father Name</label>
                            <input type="text" class="form-control" name="cfather" value="<%= rs.getString("father_name")%>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Mother Name</label>
                            <input type="text" class="form-control" name="cmother" value="<%= rs.getString("mother_name")%>">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-md-12 text-center">
                            <button type="submit" class="btn" style="background-color:#624aa1; color:white;border: none;">Update</button>
                            <!--                            <input type="button" value="Clear" class="btn" style="background-color:#624aa1; color:white;border: none;" onclick="clearForm()">-->

                        </div>
                    </div>
                    <%
                        }
                        con.close();
                    %>
                </form>
            </div>
        </div>


        <script src="AddChild.js"></script>
    </body>
</html>
