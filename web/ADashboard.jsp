<%-- 
    Document   : ADashboard
    Created on : 22 Apr, 2025, 3:34:47 PM
    Author     : RAJASEKARAN
--%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
     <!--<link href="./bootstrap1.css" rel="stylesheet">-->
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
     <link rel="stylesheet" href="./icons1.css">
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> 
     <!--<script src="./script.js"></script>-->
    <style>
        body{
            background-image: url("Images/homeimg3.jpg ");
            background-size: cover;
        }
        .sidebar {
            width: 220px;
            height: 100vh;
            background-color: #624aa1;
            position: fixed;
            padding:10;
            border:1px solid #624aa1;
            top:0;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 10px;
            text-decoration:none;
            border-bottom:1px solid white;
            font-weight:bold;
        }
        .sidebar a:hover {
            background-color: #7a5ecb;
        }
        .content {
            margin-left: 250px;
            padding: 10px;
            margin-top:90px;
           
           
        }
        .topbar {
              border:1px solid #624aa1;
                background-color: #624aa1;
                margin:0;
                padding:5px;
                position: fixed;
                top: 0;
                left: 220px;
                width: 100%;
                z-index: 1000; /* ensure it stays on top of other elements */

        
        }
    </style>
</head>
<body>
   
    <div class="sidebar">
        <h6 class="text-center text-black" style="background-color: white;"><span><img src="Images/logo4.png" height="30px" width="40px"></span>
            <i>CHILD VACCINATION MANAGEMENT SYSTEM</i>
            </h6>
            <a href="AdminDashboard.jsp"><i class="bi bi-speedometer2"></i> &nbsp; Dashboard</a>
            <a href="AdminVaccination1.jsp"><i class="bi bi-calendar-plus"></i> &nbsp;TimeTable</a>
            <a href="HospitalApproval.jsp"><i class="bi bi-check2-circle"></i> &nbsp; Approve Hospital</a>
            <a href="HospitalInfo.jsp"><i class="bi bi-building"></i> &nbsp; Hospital Details</a>
            <a href="ParentInfo.jsp"><i class="bi bi-person-lines-fill"></i> &nbsp; Parent Details</a>
            <a href="ChildDetails.jsp"><i class="bi bi-person-badge"></i> &nbsp; Child Details</a>
            <a href="AppointmentDetails.jsp"><i class="bi bi-calendar-event"></i> &nbsp; Appointment Details</a>
            <a href="ClosedAppointment1.jsp"><i class="bi bi-check-circle"></i> &nbsp;Closed Appointment</a>
            <a href="DelayedAppointment1.jsp"><i class="bi bi-clock"></i> &nbsp;Delayed Appointment</a>
            <a href="VaccinationDetails.jsp"><i class="bi bi-file-medical"></i> &nbsp; Vaccination Details</a>
            <a href="HospitalFeedback.jsp"><i class="bi bi-chat-dots"></i> &nbsp;Hospital Feedback</a>

            
            
    </div>
    <div class="topbar d-flex justify-content-end align-items-center px-3 text-white" style="min-height: 50px; z-index: 1000;">
        <div class="d-flex align-items-center" style="margin-right:230px;">
            <!-- <img src="./profile3.jfif" alt="User" height="30px" width="30px" class="rounded-circle me-3"> -->
            <a href="Homepage.jsp" class="btn btn-sm" style="background: linear-gradient(to right, #8b6fc8, #e091c9); color:white; font-size: 18px; font-weight: bold;">Logout</a>
        </div>
    </div> 

</body>
</html>


