<%@ page import="java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Child Details with Parent Info</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background-image: url("./homeimg3.jpg");
                background-size: cover;
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            h2 {
                text-align: center;
                color: #624aa1;
                margin-bottom: 20px;
                font-weight: bold;
            }
            .content {
                margin-left: 250px;
                margin-top: 90px;
                padding: 20px;
                height: calc(100vh - 50px);
                overflow-y: auto;
            }
            .table-container {
                width: 1000px;
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
            th, td {
                padding: 10px;
                border: 1px solid #624aa1;
            }
        </style>
    </head>
    <body>
        <%@ include file="HDashboard.jsp" %>

        <div class="content" style="margin-top:100px;">
            <div class="table-container table-responsive">
                <h2 style="color:#624aa1;font-weight:bold;">Child Details</h2>
                <table>
                    <thead>
                        <tr>
                            <th style="border:1px solid #624aa1;padding:8px;">#</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Child Name</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Gender</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Age</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Date of Birth</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Blood Group</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Weight</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Father Name</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Mother Name</th>
                            <th style="border:1px solid #624aa1;padding:8px;">View Parent</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                        // Get hospitalName from session
                             hospitalName = (String) session.getAttribute("hospital_name");

                            if (hospitalName == null) {
                                out.println("<tr><td colspan='10' class='text-danger'>Hospital not logged in.</td></tr>");
                            } else {
                                Connection conn = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;
                                int i = 1;

                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

                                    // Query to get children registered via appointments at this hospital
                                    String sql = "SELECT * FROM child_details WHERE name IN (SELECT DISTINCT child_name FROM book_appointments WHERE hospital = ?)";

                                    ps = conn.prepareStatement(sql);
                                    ps.setString(1, hospitalName);
                                    rs = ps.executeQuery();

                                    while (rs.next()) {
                                        int id = rs.getInt("id");  // assuming your child_details has 'id' column
                                        String name = rs.getString("name");
                                        String dob = rs.getString("dob");
                                        String gender = rs.getString("gender");
                                        String age = rs.getString("age");
                                        String blood = rs.getString("blood_group");
                                        String weight = rs.getString("weight");
                                        String father = rs.getString("father_name");
                                        String mother = rs.getString("mother_name");
                                        String parentEmail = rs.getString("parent_email"); // assuming child_details has this

                        %>
                        <tr>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= i%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= name%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= gender%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= age%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= dob%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= blood%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= weight%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= father%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= mother%></td>
                            <td style="border:1px solid #624aa1;padding:8px;">
                                <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#parentModal<%= id%>" style="background-color:#624aa1; border-color:#624aa1; color:white;">
                                    <i class="bi bi-person-circle"></i> View
                                </button>
                            </td>
                        </tr>

                        <!-- Parent Details Modal -->
                        <%
                            // Fetch parent details for this child
                            String sql2 = "SELECT * FROM parent_details WHERE pemail = ?";
                            PreparedStatement ps2 = conn.prepareStatement(sql2);
                            ps2.setString(1, parentEmail);
                            ResultSet rs2 = ps2.executeQuery();

                            if (rs2.next()) {
                                String pname = rs2.getString("pname");
                                int parentAge = rs2.getInt("page");
                                String pgender = rs2.getString("pgender");
                                String pmobile = rs2.getString("pmobile");
                                String paddress = rs2.getString("paddress");
                                 profilePhoto = rs2.getString("profile_photo");

                        %>
                    <div class="modal fade" id="parentModal<%= id%>" tabindex="-1" aria-labelledby="parentModalLabel<%= id%>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content" style="background: linear-gradient(to right, #a18cd1, #fbc2eb); font-weight: bold; width: 600px;">
                                <div class="modal-header" style="color: #624aa1;">
                                    <h5 class="modal-title" id="parentModalLabel<%= id%>">Parent Details</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body row">
                                    <div class="col-md-4 text-center">
                                        <img src="<%= profilePhoto%>" class="img-thumbnail rounded-circle" alt="Profile Photo" width="150" height="150">
                                    </div>
                                    <div class="col-md-8">
                                        <p><strong>Name:</strong> <%= pname%></p>
                                        <p><strong>Gender:</strong> <%= pgender%></p>
                                        <p><strong>Age:</strong> <%= parentAge%></p>
                                        <p><strong>Email:</strong> <%= parentEmail%></p>
                                        <p><strong>Mobile:</strong> <%= pmobile%></p>
                                        <p><strong>Address:</strong> <%= paddress%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                                    } // end if parent found

                                    rs2.close();
                                    ps2.close();

                                    i++;
                                } // end while children

                                rs.close();
                                ps.close();
                                conn.close();

                            } catch (Exception e) {
                                out.println("<tr><td colspan='10' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
