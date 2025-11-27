<%-- 
    Document   : HospitalDashboard
    Created on : 12 Apr, 2025, 2:42:32 PM
    Author     : RAJASEKARAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- <link href="./bootstrap1.css" rel="stylesheet"> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="./icons1.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- <script src="./script.js"></script> -->
    <style>
        body{
            background-image: url("Images/homeimg3.jpg");
            background-size: cover;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #624aa1;
            position: fixed;
            top: 0;
            left: 0;
            border-right: 1px solid #624aa1;
            overflow-y: auto;
            
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
            margin-top:50px;
           
           
        }
        .topbar {
            border:1px solid #624aa1;
            background-color: #624aa1;
            margin:0;
            padding:5px;
        
        }

        .profile-container {
            display: none;
            background: linear-gradient(to right, #a18cd1, #fbc2eb); 
            border-radius: 10px;
            padding: 15px;
            position: absolute;
            top: 50px;
            right: 20px;
            width: 300px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }

        .profile-container p{
            color:black;
        }
        #edit{
            margin-left:40% ;
            color:white;
            background:#624aa1;
        }
        @media (max-width: 400px) {
            .sidebar {
                transform: translateX(-250px);
                position: absolute;
            }
            .content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <%@ include file="HDashboard.jsp" %> 

   <div class="content">
    <div class="container mt-5">
        <h2 class="text-center">Welcome Your Hospital</h2>
        <p class="text-center" style="font-size: 18px;">
            Manage child vaccination records, schedule appointments, and ensure timely immunizations.
        </p>
        
        <p class="text-center">
            Keep track of all vaccination updates and provide better healthcare services for children.
        </p>

        <ul class="list-unstyled text-center" style="font-size: 18px; display: flex; flex-direction: column; align-items: center; justify-content: center; padding-left: 0;">
            <li style="display: flex; align-items: center; gap: 8px;">
                <i class="bi bi-check-circle" style="font-size: 22px; color: black;"></i> 
                <span><b>Register</b> and manage child vaccination details</span>
            </li>
            <li style="margin-left:16px; align-items: center; gap: 8px;">
                <i class="bi bi-check-circle" style="font-size: 22px; color: black;"></i> 
                <span><b>Schedule</b> and update vaccination appointments</span>
            </li>
            <li style="margin-left:3px;align-items: center; gap: 8px;">
                <i class="bi bi-check-circle" style="font-size: 22px; color: black;"></i> 
                <span><b>Monitor</b> vaccination status and health records</span>
            </li>
            <li style="margin-left:40px; align-items: center; gap: 8px;">
                <i class="bi bi-check-circle" style="font-size: 22px; color: black;"></i> 
                <span><b>Generate</b> reports and track immunization progress</span>
            </li>
        </ul>

        <p class="text-center" style="font-size: 18px; font-weight: bold;">
            <strong>Ensure timely vaccinations and contribute to a healthier community.</strong>
        </p>
    </div>
</div>


</body>
</html>
