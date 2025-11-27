<%-- 
    Document   : AddChild
    Created on : 18 Apr, 2025, 12:19:03 PM
    Author     : RAJASEKARAN
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Child Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <!--        <link href="./bootstrap1.css" rel="stylesheet">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 

    </head>

    <body>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
            }

            .border-box {
                margin-top: 100px;
                position: relative;
                border: 3px solid #624aa1;
                Padding: 20px;
                height: 400px;
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
                margin-left:154px;
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





        <%@ include file="PDashboard.jsp" %> 
        <%  String parentEmail = (String) session.getAttribute("parent_email");
            if (parentEmail == null) {
                response.sendRedirect("ParentLogin.jsp");
                return;
            }

            String url = "jdbc:mysql://localhost:3306/cvms";
            String user = "root";
            String pass = "";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);

            // INSERT operation
            if (request.getParameter("cname") != null) {
                name = request.getParameter("cname");

                String dob = request.getParameter("cdob");
                SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");  // Input format from the form
                java.util.Date utilDate = inputFormat.parse(dob);  // Parse the input date
                SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy"); // Output format for database
                String formattedDob = outputFormat.format(utilDate);  // Format the date as dd-MM-yyyy

                gender = request.getParameter("cgender");
                age = request.getParameter("cage");
                String blood = request.getParameter("cblood");
                String weight = request.getParameter("cweight");
                String father = request.getParameter("cfather");
                String mother = request.getParameter("cmother");

                PreparedStatement ps = con.prepareStatement("INSERT INTO child_details (name, dob, gender, age, blood_group, weight, father_name, mother_name, parent_email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, formattedDob);
                ps.setString(3, gender);
                ps.setString(4, age);
                ps.setString(5, blood);
                ps.setString(6, weight);
                ps.setString(7, father);
                ps.setString(8, mother);
                ps.setString(9, parentEmail);
                ps.executeUpdate();
            }

            if (request.getParameter("deleteId") != null) {
                int deleteId = Integer.parseInt(request.getParameter("deleteId"));
                PreparedStatement ps = con.prepareStatement("DELETE FROM child_details WHERE id=? AND parent_email=?");
                ps.setInt(1, deleteId);
                ps.setString(2, parentEmail);
                ps.executeUpdate();
            }

        %>

        <div id="AddForm" class="container" style="display:none">
            <div class="border-box">
                <form action="AddChild1.jsp" method="post" onsubmit="return saveForm(event)">
                    <div class="row">
                        <div class="col-md-4 col-12 mb-3">
                            <label class="form-label">Child Name</label>
                            <input type="text" class="form-control" name="cname" id="child_name" maxlength="50">
                        </div>
                        <div class="col-md-4 col-12 mb-3">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" name="cdob" id="child_dob">
                        </div>
                        <div class="col-md-4 col-12 mb-3">
                            <label class="form-label">Gender</label>
                            <select class="form-control" name="cgender" id="child_gender">
                                <option value="">Select</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="col-md-4 col-12 mb-3">
                            <label class="form-label">Age</label>
                            <input type="text" class="form-control" name="cage" id="age">
                        </div>
                        <div class="col-md-4 col-12 mb-3">
                            <label class="form-label">Blood Group</label>
                            <select class="form-control" name="cblood" id="child_blood">
                                <option value="">Select</option>
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
                        <div class="col-md-4 col-12 mb-3">
                            <label class="form-label">Weight (kg)</label>
                            <input type="text" class="form-control" name="cweight" id="child_weight" pattern="^\d{1,2}(\.\d{1,2})?$" title="Enter a number up to 2 decimal places" required>
                        </div>
                        <div class="col-md-6 col-12 mb-3">
                            <label class="form-label">Father Name</label>
                            <input type="text" class="form-control" name="cfather" id="fat_name">
                        </div>
                        <div class="col-md-6 col-12 mb-3">
                            <label class="form-label">Mother Name</label>
                            <input type="text" class="form-control" name="cmother" id="mot_name">
                        </div>
                        <div class="col-12 text-center mt-3">
                            <button type="submit" class="btn btn-custom" style="color:white; background-color: #624aa1;">Submit</button>
                            <button type="button" class="btn btn-custom" onclick="hideForm()" style="color:white; background-color: #624aa1;">Clear</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="container mt-5" id="gridpage" style="margin-left:75px;">
            <h3 class="text-center" style="font-weight: bold; color:#624aa1;margin-top:90px; margin-left: 260px;" >Child Details</h3>
            <div class="row mt-4">
                <div style="margin-left:100px;">
                    <button class="btn mb-3" onclick="showForm()" style="background-color:#624aa1; color:white; border:none; margin-left:934px;">+ Add Child</button>
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Child Name</th>
                                <th>DOB</th>
                                <th>Gender</th>
                                <th>Age</th>
                                <th>Blood Group</th>
                                <th>Weight</th>
                                <th>Father Name</th>
                                <th>Mother Name</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="childTableBody">
                            <%                                PreparedStatement stmt = con.prepareStatement("SELECT * FROM child_details WHERE parent_email=?");
                                stmt.setString(1, parentEmail);
                                ResultSet rs = stmt.executeQuery();
                                int i = 1;
                                while (rs.next()) {

                            %>

                            <tr>
                                <td><%= i++%></td>
                                <td><%= rs.getString("name")%></td>
                                <td><%= rs.getString("dob")%></td>
                                <td><%= rs.getString("gender")%></td>
                                <td><%= rs.getString("age")%></td>
                                <td><%= rs.getString("blood_group")%></td>
                                <td><%= rs.getFloat("weight")%></td>
                                <td><%= rs.getString("father_name")%></td>
                                <td><%= rs.getString("mother_name")%></td>

                                <td>
                                    <form method="get" action="EditChild.jsp" style="display:inline;">
                                        <input type="hidden" name="id" value="<%= rs.getInt("id")%>">
                                        <button type="submit" class="btn btn-sm text-primary">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                    </form>
                                    <form method="post" action="AddChild1.jsp" style="display:inline;">
                                        <input type="hidden" name="deleteId" value="<%= rs.getInt("id")%>">
                                        <button type="submit" class="btn btn-sm text-danger" onclick="return confirm('Are you sure you want to delete this record?')">
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

        <!--        <script src="AddChild.js"></script>-->
        <script>

            function saveForm(event) {



                var child_name = document.getElementById("child_name").value;
                var child_dob = document.getElementById("child_dob").value;
                var child_gender = document.getElementById("child_gender").value;
                var age = document.getElementById("age").value;
//                var child_blood = document.getElementById("child_blood").value;
                var child_weight = document.getElementById("child_weight").value;
                var fat_name = document.getElementById("fat_name").value;
                var mot_name = document.getElementById("mot_name").value;

                if (child_name === '') {
                    alert("Please enter the child fullname");
                    document.getElementById("child_name").focus();
                    return false;
                }
//                else if (child_dob === '') {
//                    alert("Please enter the child dob.");
//                    document.getElementById("child_dob").focus();
//                    return false;
//                } 
                else if (child_gender === '') {
                    alert("Please enter the gender of the child.");
                    document.getElementById("child_gender").focus();
                    return false;
                } else if (age === '') {
                    alert("Please enter the child age.");
                    document.getElementById("age").focus();
                    return false;
                } else if (child_blood === '') {
                    alert("Please enter the child blood group.");
                    document.getElementById("child_blood").focus();
                    return false;
                } else if (child_weight === '') {
                    alert("Please enter the child weight.");
                    document.getElementById("child_weight").focus();
                    return false;
                } else if (fat_name.trim() === '') {
                    alert("Please enter the child's father name.");
                    document.getElementById("fat_name").focus();
                    return false;
                } else if (mot_name.trim() === '') {
                    alert("Please enter the child's mother name.");
                    document.getElementById("mot_name").focus();
                    return false;
                } else {
                    alert("You successfully added your child !!");
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
                document.getElementById("child_name").value = '';
                document.getElementById("child_dob").value = '';
                document.getElementById("child_gender").value = '';
                document.getElementById("age").value = '';
                document.getElementById("child_blood").value = '';
                document.getElementById("child_weight").value = '';
                document.getElementById("fat_name").value = '';
                document.getElementById("mot_name").value = '';

                let AddForm = document.getElementById("AddForm");
                let gridpage = document.getElementById("gridpage");

                if (AddForm && gridpage) {
                    AddForm.style.display = "none";
                    gridpage.style.display = "block";
                } else {
                    console.log("Error: AddForm or gridpage elements not found.");
                }

                // document.getElementById("AddForm").style.display = "none";
                // document.getElementById("gridpage").style.display = "block";
            }

        </script>

    </body>
</html>

