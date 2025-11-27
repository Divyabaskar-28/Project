<%@page import = "java.sql.*, java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hospital Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <link href="./bootstrap1.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="./icons1.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
        <style>
            body {
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
            }
            .container1 {
                margin-top: 50px;
                width: 1045px;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                margin-right: 100px;
                margin-left: 95px;
            }
            h2 {
                text-align: center;
                color: #624aa1;
                font-weight: bold;
            }
            .table-container {
                width: 1045px;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                margin-right: 120px;
                margin-top: 80px;
                margin-left: 275px;
            }
            table {
                width: 100%;
                text-align: center;
                overflow-x: auto;
            }
            th, td {
                padding: 10px;
                border: 1px solid #624aa1;
            }
            @media screen and (max-width: 468px) {
                .container {
                    padding: 15px;
                    max-width: 95%;
                }
                .table-container {
                    padding: 10px;
                }
                table {
                    font-size: 14px;
                }
            }
            @media screen and (max-width: 480px) {
                th, td {
                    padding: 8px;
                }
                h2 {
                    font-size: 20px;
                }
            }
            label{
                font-weight:bold;
            }
            .modal-content {
                max-height: 90vh; /* allows scroll within the modal */
                overflow-y: auto;
            }

        </style>
    </head>
    <body>
        <%@ include file="ADashboard.jsp" %>
        <div class="content1">
            <div class="table-container">
                <h2 style="color:#624aa1;font-weight:bold;">Hospital Details</h2>
                <table>
                    <thead>
                        <tr>
                            <th style="border:1px solid #624aa1; padding:10px;">#</th>
                            <th style="border:1px solid #624aa1; padding:10px;">Applied Date</th>
                            <th style="border:1px solid #624aa1; padding:10px;">Profile Photo</th>
                            <th style="border:1px solid #624aa1; padding:10px;">Hospital Name</th>
                            <th style="border:1px solid #624aa1; padding:10px;">Hospital Branch</th>
                            <th style="border:1px solid #624aa1; padding:10px;">Registration ID</th>
                            <th style="border:1px solid #624aa1; padding:10px;">Email</th>
                            <th style="border:1px solid #624aa1; padding:10px;">Mobile Number</th>
                            <th style="border:1px solid #624aa1; padding:10px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection con = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
                                stmt = con.createStatement();
                                String query = "SELECT * FROM hospital_details where status = 'approved'";
                                rs = stmt.executeQuery(query);
                                int i = 1;
                                while (rs.next()) {
                                    String profilePhoto = rs.getString("photo");
                                    String finalPhoto = (profilePhoto != null && !profilePhoto.trim().isEmpty())
                                            ? profilePhoto
                                            : "Picture/Hospitals/defaultProfile.png";

                                    // Formatting dates
                                    Timestamp ts = rs.getTimestamp("applied_on");
                                    String formattedAppliedOn = (ts != null) ? new SimpleDateFormat("dd-MM-yyyy").format(ts) : "";

                                    // New approved_on field formatting
                                    Timestamp approvedOn = rs.getTimestamp("approved_on");
                                    String formattedApprovedOn = (approvedOn != null) ? new SimpleDateFormat("dd-MM-yyyy").format(approvedOn) : "";

                                    boolean isBlocked = "yes".equalsIgnoreCase(rs.getString("is_blocked"));
                        %>

                        <tr>
                            <td style="border:1px solid #624aa1; padding:10px;"><%= i++%></td>
                            <td style="border:1px solid #624aa1; padding:10px;"><%= formattedAppliedOn%></td>
                            <td style="border:1px solid #624aa1; padding:10px;">
                                <img src="<%= request.getContextPath() + "/" + finalPhoto%>" alt="User" height="40px" width="40px" class="rounded-circle me-3">
                            </td>
                            <td style="border:1px solid #624aa1; padding:10px;"><%= rs.getString("hospital_name")%></td>
                            <td style="border:1px solid #624aa1; padding:10px;"><%= rs.getString("branch")%></td>
                            <td style="border:1px solid #624aa1; padding:10px;"><%= rs.getString("registration_id")%></td>
                            <td style="border:1px solid #624aa1; padding:10px;"><%= rs.getString("email")%></td>
                            <td style="border:1px solid #624aa1; padding:10px;"><%= rs.getString("mobile")%></td>
                            <td style="border:1px solid #624aa1; padding:10px;">
                                <div style="display: flex; gap: 8px; align-items: center;">
                                    <!-- View Button -->
                                    <button type="button"
                                            class="btn btn-sm"
                                            style="background-color:#624aa1; color:white; padding: 6px 12px; font-size: 14px; height: 36px; display: flex; align-items: center; gap: 5px;"
                                            data-bs-toggle="modal"
                                            data-bs-target="#viewModal"
                                            onclick="populateModal(
                                                            '<%= rs.getString("hospital_name").replace("'", "\\'")%>',
                                                            '<%= rs.getString("branch") != null ? rs.getString("branch").replace("'", "\\'") : ""%>',
                                                            '<%= rs.getString("registration_id")%>',
                                                            '<%= rs.getString("email")%>',
                                                            '<%= rs.getString("mobile")%>',
                                                            '<%= rs.getString("address").replace("'", "\\'")%>',
                                                            '<%= rs.getString("password")%>',
                                                            '<%= formattedAppliedOn%>',
                                                            '<%= formattedApprovedOn%>',
                                                            '<%= request.getContextPath() + "/" + finalPhoto%>'
                                                            )">
                                        <i class="bi bi-eye-fill"></i>
                                        <span>View</span>
                                    </button>

                                    <!-- Block/Unblock Button -->
                                    <form action="BlockUnblockHospital.jsp" method="post" style="margin: 0;">
                                        <input type="hidden" name="email" value="<%= rs.getString("email")%>">
                                        <input type="hidden" name="action" value="<%= isBlocked ? "unblock" : "block"%>">
                                        <button type="submit" class="btn btn-sm"
                                                style="background-color:<%= isBlocked ? "#28a745" : "#dc3545"%>; color:white; padding: 6px 12px; font-size: 14px; height: 36px; display: flex; align-items: center;">
                                            <i class="bi <%= isBlocked ? "bi-unlock-fill" : "bi-lock-fill"%>" style="margin-right: 5px;"></i>
                                            <%= isBlocked ? "Unblock" : "Block"%>
                                        </button>
                                    </form>

                                </div>
                            </td>


                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (stmt != null) {
                                        stmt.close();
                                    }
                                    if (con != null) {
                                        con.close();
                                    }
                                } catch (Exception e) {
                                }
                            }
                        %>

                    </tbody>
                </table>
            </div>
        </div>

        <div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-lg">
                <div class="modal-content" style="background: linear-gradient(to right, #a18cd1, #fbc2eb); width:600px;margin-left:100px; max-height: 90vh;
                     overflow-y: auto;">
                    <form action="UpdateHospital.jsp" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="viewModalLabel" style="color:#624aa1;font-weight:bold;">Edit Hospital Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-4 text-center mb-3">
                                    <img id="modalPhoto" src="" alt="Profile Photo" class="img-thumbnail" width="150">
                                </div>
                                <div class="col-md-8">
                                    <input type="hidden" name="email" id="modalEmail">
                                    <div class="mb-2">
                                        <label>Hospital Name:</label>
                                        <input type="text" class="form-control" name="hospital_name" id="modalName">
                                    </div>
                                    <div class="mb-2">
                                        <label>Branch:</label>
                                        <input type="text" class="form-control" name="branch" id="modalBranch">
                                    </div>
                                    <div class="mb-2">
                                        <label>Registration ID:</label>
                                        <input type="text" class="form-control" name="registration_id" id="modalRegId">
                                    </div>
                                    <div class="mb-2">
                                        <label>Mobile:</label>
                                        <input type="text" class="form-control" name="mobile" id="modalMobile">
                                    </div>
                                    <div class="mb-2">
                                        <label>Address:</label>
                                        <textarea class="form-control" name="address" id="modalAddress"></textarea>
                                    </div>
                                    <div class="mb-2">
                                        <label>Password:</label>
                                        <input type="text" class="form-control" name="password" id="modalPassword">
                                    </div>
                                    <div class="mb-2">
                                        <label>Applied On:</label>
                                        <input type="text" class="form-control" name="applied_on" id="modalAppliedOn" readonly>
                                    </div>
                                    <div class="mb-2">
                                        <label>Approved On:</label>
                                        <input type="text" class="form-control" name="approved_on" id="modalApprovedOn" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn" style="background-color:#624aa1;color:white;">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function populateModal(hospitalName, branch, regId, email, mobile, address, password, appliedOn, approvedOn, photo) {
                document.getElementById('modalName').value = hospitalName;
                document.getElementById('modalBranch').value = branch;
                document.getElementById('modalRegId').value = regId;
                document.getElementById('modalEmail').value = email;
                document.getElementById('modalMobile').value = mobile;
                document.getElementById('modalAddress').value = address;
                document.getElementById('modalPassword').value = password;
                document.getElementById('modalAppliedOn').value = appliedOn;
                document.getElementById('modalApprovedOn').value = approvedOn;
                document.getElementById('modalPhoto').src = photo;
            }

        </script>

    </body>
</html>
