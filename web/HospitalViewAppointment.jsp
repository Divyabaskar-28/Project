<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>View Appointment</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap JS (with Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


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

            th,
            td {
                padding: 10px;
                border: 1px solid #624aa1;
            }

            .btn-approve {
                background-color: green;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-reject {
                background-color: red;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-approve:hover {
                background-color: darkgreen;
            }

            .btn-reject:hover {
                background-color: darkred;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
                padding: 5px 10px;
                border-radius: 5px;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .btn-complete {
                background-color: #624aa1;
                border: none;
                padding: 5px 10px;
                color: white;
                border-radius: 5px;
            }

            .btn-complete:hover {
                background-color: #7a5ecb;
            }
        </style>
    </head>

    <body>
        <%@ include file="HDashboard.jsp" %>

        <div class="content" style="margin-top: 100px;">
            <div class="table-container table-responsive">
                <h2 style="color:#624aa1; font-weight: bold; text-align:center;">View Appointments</h2>
                <table>
                    <thead>
                        <tr>
                            <th style="border: 1px solid #624aa1; padding: 8px;">#</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Appointment Date</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Child Name</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">DOB</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Vaccine</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Parent Details</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Status</th>
                            <th style="border: 1px solid #624aa1; padding: 8px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            String url = "jdbc:mysql://localhost:3306/cvms";
                            String user = "root";
                            String pass = "";
                            String hospitalEmail = (String) session.getAttribute("hospital_email");

                            if (hospitalEmail == null) {
                        %>
                        <tr>
                            <td colspan="7" style="color:red;">Session expired. Please log in again.</td>
                        </tr>
                        <%
                        } else {
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            boolean found = false;
                            int i = 1;

                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection(url, user, pass);

                                String sql = "SELECT b.child_name, b.hospital, b.hospital_branch, b.appointment_date, b.vaccine, b.status, b.parent_email "
                                        + "FROM book_appointments b "
                                        + "WHERE LOWER(b.hospital) = (SELECT LOWER(h.hospital_name) FROM hospital_details h WHERE LOWER(h.email) = LOWER(?)) "
                                        + "AND b.status NOT IN ('completed', 'incompleted', 'rejected')";

                                ps = conn.prepareStatement(sql);
                                ps.setString(1, hospitalEmail.trim());
                                rs = ps.executeQuery();

                                while (rs.next()) {
                                    found = true;
                                    String childName = rs.getString("child_name");
                                    String hospital = rs.getString("hospital");
                                    String branch = rs.getString("hospital_branch");
                                    String date = rs.getString("appointment_date");
                                    String vaccine = rs.getString("vaccine");
                                    String status = rs.getString("status");
                                    email = rs.getString("parent_email");

// Get DOB of the child from child_details
                                    String dob = "N/A";
                                    String sqlDob = "SELECT dob FROM child_details WHERE name = ? AND parent_email = ?";
                                    PreparedStatement psDob = conn.prepareStatement(sqlDob);
                                    psDob.setString(1, childName);
                                    psDob.setString(2, email);
                                    ResultSet rsDob = psDob.executeQuery();
                                    if (rsDob.next()) {
                                        dob = rsDob.getString("dob");
                                    }

                        %>
                        <tr>
                            <td style="border:1px solid #624aa1;padding:8px;"><%= i%></td>
                            <td style="border: 1px solid #624aa1; padding: 8px;"><%= date%></td>
                            <td style="border: 1px solid #624aa1; padding: 8px;"><%= childName%></td>
                            <td style="border: 1px solid #624aa1; padding: 8px;"><%= dob%></td>
                            <td style="border: 1px solid #624aa1; padding: 8px;"><%= vaccine%></td>

                            <!--                            <td style="border: 1px solid #624aa1; padding: 8px; text-align:center;">
                                                            <button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#parentModal" style="color:#642aa1;">
                                                                View
                                                            </button>
                            
                                                        </td>-->
                            <td style="border:1px solid #624aa1;padding:8px;">
                                <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#parentModal<%= i%>" style="background-color:#624aa1;border-color:#624aa1;color:white; ">
                                    <i class="bi bi-person-circle" style="color:white;"></i> View
                                </button>
                            </td>

                            <td style="border: 1px solid #624aa1; padding: 8px;">
                                <% if ("approved".equalsIgnoreCase(status)) { %>
                                <span class="badge bg-success">Approved</span>
                                <% } else if ("rejected".equalsIgnoreCase(status)) { %>
                                <span class="badge bg-danger">Rejected</span>
                                <% } else if ("completed".equalsIgnoreCase(status)) { %>
                                <span class="badge bg-primary">Completed</span>
                                <% } else if ("incompleted".equalsIgnoreCase(status)) { %>
                                <span class="badge bg-primary">Incompleted</span>
                                <% } else { %>
                                <span class="badge bg-warning text-dark">Pending</span>
                                <% } %>
                            </td>

                            <td style="border: 1px solid #624aa1; padding: 8px;">
                                <div style="display: flex; gap: 10px; justify-content: center; align-items: center; flex-wrap: nowrap;">
                                    <%
                                        if ("pending".equalsIgnoreCase(status)) {
                                    %>
                                    <form action="AppointmentActionServlet" method="post" style="margin: 0;">
                                        <input type="hidden" name="child_name" value="<%= childName%>" />
                                        <input type="hidden" name="hospital" value="<%= hospital%>" />
                                        <input type="hidden" name="hospital_branch" value="<%= branch%>" />
                                        <input type="hidden" name="appointment_date" value="<%= date%>" />
                                        <input type="hidden" name="vaccine" value="<%= vaccine%>" />
                                        <input type="hidden" name="parent_email" value="<%= email%>" />
                                        <button type="submit" name="action" value="approve" class="btn-approve">Approve</button>
                                    </form>

                                    <!--                                    <form action="AppointmentActionServlet" method="post" style="margin: 0;">
                                                                            <input type="hidden" name="child_name" value="<%= childName%>" />
                                                                            <input type="hidden" name="hospital" value="<%= hospital%>" />
                                                                            <input type="hidden" name="hospital_branch" value="<%= branch%>" />
                                                                            <input type="hidden" name="appointment_date" value="<%= date%>" />
                                                                            <input type="hidden" name="vaccine" value="<%= vaccine%>" />
                                                                            <input type="hidden" name="parent_email" value="<%= email%>" />
                                                                            <button type="submit" name="action" value="reject" class="btn-reject">Reject</button>
                                                                        </form>-->
                                    <!-- Reject button triggers modal -->
                                    <button type="button" class="btn-reject" data-bs-toggle="modal" data-bs-target="#rejectModal<%= i%>">Reject</button>

                                    <%
                                    } else if ("approved".equalsIgnoreCase(status)) {
                                    %>
                                    <form action="AppointmentActionServlet" method="post" style="margin: 0;">
                                        <input type="hidden" name="child_name" value="<%= childName%>" />
                                        <input type="hidden" name="hospital" value="<%= hospital%>" />
                                        <input type="hidden" name="hospital_branch" value="<%= branch%>" />
                                        <input type="hidden" name="appointment_date" value="<%= date%>" />
                                        <input type="hidden" name="vaccine" value="<%= vaccine%>" />
                                        <input type="hidden" name="parent_email" value="<%= email%>" />
                                        <button type="submit" name="action" value="complete" class="btn-complete">Complete</button>
                                    </form>

                                    <button type="button" class="btn-reject" data-bs-toggle="modal" data-bs-target="#incompleteModal<%= i%>">Incomplete</button>

                                    <% }%>
                                </div>
                            </td>
                        </tr>

                        <!-- Reject Reason Modal -->
                    <div class="modal fade" id="rejectModal<%= i%>" tabindex="-1" aria-labelledby="rejectModalLabel<%= i%>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content" style="background: linear-gradient(to right, #fbc2eb, #a18cd1);">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="rejectModalLabel<%= i%>">Reject Appointment</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="AppointmentActionServlet" method="post">
                                    <div class="modal-body">
                                        <input type="hidden" name="child_name" value="<%= childName%>" />
                                        <input type="hidden" name="hospital" value="<%= hospital%>" />
                                        <input type="hidden" name="hospital_branch" value="<%= branch%>" />
                                        <input type="hidden" name="appointment_date" value="<%= date%>" />
                                        <input type="hidden" name="vaccine" value="<%= vaccine%>" />
                                        <input type="hidden" name="parent_email" value="<%= email%>" />
                                        <input type="hidden" name="action" value="reject" />

                                        <div class="mb-3">
                                            <label for="reason<%= i%>" class="form-label">Rejection Reason</label>
                                            <textarea class="form-control" name="rejection_reason" id="reason<%= i%>" rows="3" required></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-danger">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Incomplete Reason Modal -->
                    <div class="modal fade" id="incompleteModal<%= i%>" tabindex="-1" aria-labelledby="incompleteModalLabel<%= i%>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content" style="background: linear-gradient(to right, #fbc2eb, #a18cd1);">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="incompleteModalLabel<%= i%>">Mark Appointment as Incomplete</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form action="AppointmentActionServlet" method="post">
                                    <div class="modal-body">
                                        <input type="hidden" name="child_name" value="<%= childName%>" />
                                        <input type="hidden" name="hospital" value="<%= hospital%>" />
                                        <input type="hidden" name="hospital_branch" value="<%= branch%>" />
                                        <input type="hidden" name="appointment_date" value="<%= date%>" />
                                        <input type="hidden" name="vaccine" value="<%= vaccine%>" />
                                        <input type="hidden" name="parent_email" value="<%= email%>" />
                                        <input type="hidden" name="action" value="incomplete" />

                                        <div class="mb-3">
                                            <label for="incompleteReason<%= i%>" class="form-label">Reason for Incompletion</label>
                                            <textarea class="form-control" name="incomplete_reason" id="incompleteReason<%= i%>" rows="3" required></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Parent Details Modal -->
                    <div class="modal fade" id="parentModal<%= i%>" tabindex="-1" aria-labelledby="parentModalLabel<%= i%>" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content" style="background: linear-gradient(to right, #a18cd1, #fbc2eb); font-weight: bold;width:600px;">
                                <div class="modal-header" style="color: #624aa1;">
                                    <h5 class="modal-title" id="parentModalLabel<%= i%>">Parent Details</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="color:#624aa1;"></button>
                                </div>
                                <div class="modal-body row">
                                    <%
                                        String sqlParent = "SELECT * FROM parent_details WHERE pemail = ?";
                                        PreparedStatement psParent = conn.prepareStatement(sqlParent);
                                        psParent.setString(1, email); // Make sure 'email' is defined above
                                        ResultSet rsParent = psParent.executeQuery();

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
                    <tr>
                        <td colspan="7" style="color: red;">No appointments found.</td>
                    </tr>
                    <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='7' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                            } finally {
                                if (rs != null) {
                                    try {
                                        rs.close();
                                    } catch (Exception e) {
                                    }
                                }
                                if (ps != null) {
                                    try {
                                        ps.close();
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
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
