<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Closed Appointment</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
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
                width:1000px;
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
                <h2 style="color:#624aa1; font-weight: bold; text-align:center;">Closed Appointments</h2>
                <table>
                    <thead>
                        <tr>
                            <th style="border:1px solid #624aa1;padding:8px;">#</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Appointment Date</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Child Name</th>
                            <th style="border:1px solid #624aa1;padding:8px;">Vaccine</th>
                            <th style="border:1px solid #624aa1;padding:8px;"> View Parent</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                        String url = "jdbc:mysql://localhost:3306/cvms";
                            String user = "root";
                            String pass = "";
                            String hospitalEmail = (String) session.getAttribute("hospital_email");

                            if (hospitalEmail == null) {
                        %>
                        <tr><td colspan="5" style="color:red;">Session expired. Please log in again.</td></tr>
                        <%
                        } else {
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            int i = 1;
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection(url, user, pass);

                                String sql = "SELECT b.appointment_date, b.child_name, b.vaccine, b.parent_email "
                                        + "FROM book_appointments b "
                                        + "WHERE LOWER(b.hospital) = (SELECT LOWER(h.hospital_name) FROM hospital_details h WHERE LOWER(h.email) = LOWER(?)) "
                                        + "AND LOWER(b.status) = 'completed' "
                                        + "ORDER BY b.appointment_date DESC";

                                ps = conn.prepareStatement(sql);
                                ps.setString(1, hospitalEmail.trim());
                                rs = ps.executeQuery();

                                boolean found = false;
                                while (rs.next()) {
                                    found = true;
                                    String appointmentDate = rs.getString("appointment_date");
                                    String childName = rs.getString("child_name");
                                    String vaccine = rs.getString("vaccine");
                                    String parentEmail = rs.getString("parent_email");
                        %>
                        <tr>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= i%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= appointmentDate%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= childName%></td>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= vaccine%></td>
                            <!--                            <td style="border:1px solid #624aa1;padding:8px;">
                                                            <button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#parentModal" style="color:#642aa1;">
                                                                <i class="bi bi-person-lines-fill" style="font-size: 1.2rem;"></i> View
                                                            </button>
                                                        </td>-->
                            <td style="border:1px solid #624aa1;padding:8px;">
                                <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#parentModal<%= i%>" style="background-color:#624aa1;border-color:#624aa1;color:white; ">
                                    <i class="bi bi-person-circle" style="color:white;"></i> View
                                </button>
                            </td>
                        </tr>

                        <%
                            // Fetch parent details
                            String sqlParent = "SELECT * FROM parent_details WHERE pemail = ?";
                            PreparedStatement psParent = conn.prepareStatement(sqlParent);
                            psParent.setString(1, parentEmail);
                            ResultSet rsParent = psParent.executeQuery();
                            profilePhoto = "";
                        %>

                        <!-- Modal -->
                    <div class="modal fade" id="parentModal<%= i%>" tabindex="-1" aria-labelledby="parentModalLabel<%= i%>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content" style="background: linear-gradient(to right, #a18cd1, #fbc2eb); font-weight: bold;width:600px;">
                                <div class="modal-header" style="color: #624aa1;">
                                    <h5 class="modal-title" id="parentModalLabel<%= i%>">Parent Details</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body row">
                                    <%
                                        if (rsParent.next()) {
                                            String pname = rsParent.getString("pname");
                                            int parentAge = rsParent.getInt("page");
                                            String pgender = rsParent.getString("pgender");
                                            String pemail = rsParent.getString("pemail");
                                            String pmobile = rsParent.getString("pmobile");
                                            String paddress = rsParent.getString("paddress");
                                            profilePhoto = rsParent.getString("profile_photo");
                                    %>
                                    <div class="col-md-4 text-center">
                                        <img src="<%= profilePhoto%>" alt="Parent Photo" class="img-thumbnail rounded-circle" width="150" height="150" style="margin-bottom: 15px;">
                                    </div>
                                    <div class="col-md-8">
                                        <p><strong>Name:</strong> <%= pname%></p>
                                        <p><strong>Gender:</strong> <%= pgender%></p>
                                        <p><strong>Age:</strong> <%= parentAge%></p>
                                        <p><strong>Email:</strong> <%= pemail%></p>
                                        <p><strong>Mobile:</strong> <%= pmobile%></p>
                                        <p><strong>Address:</strong> <%= paddress%></p>
                                    </div>
                                    <%
                                    } else {
                                    %>
                                    <div class="col-12 text-center text-danger">
                                        <p>No parent details found.</p>
                                    </div>
                                    <%
                                        }
                                        rsParent.close();
                                        psParent.close();
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%
                            i++;
                        }
                        if (!found) {
                    %>
                    <tr><td colspan="5" style="color:red;">No appointments found for your hospital.</td></tr>
                    <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    %>
                    <tr><td colspan="5" style="color:red;">Error loading appointments.</td></tr>
                    <%
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
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
