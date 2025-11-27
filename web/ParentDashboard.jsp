<%-- 
    Document   : ParentDashboard
    Created on : 12 Apr, 2025, 2:21:12 PM
    Author     : RAJASEKARAN
--%>



<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>parent Dashboard</title>
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
                padding:10;
                border:1px solid #624aa1;
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
        </style>
    </head>
    <body>
        <%@ include file="PDashboard.jsp" %> 
        <div class="content">
            <div class="container mt-5">
                <h2 class="text-center">Welcome Parent</h2>
                <p class="text-center" style="font-size: 18px;">
                    Manage your child's vaccination schedule, book appointments, and track vaccination history easily.
                </p>

                <p class="text-center">
                    Stay updated with the latest vaccination guidelines and ensure your child's health is always a priority.
                </p>

                <ul class="list-unstyled text-center" style="font-size: 18px; display: flex; flex-direction: column; align-items: center; justify-content: center; padding-left: 0;">
                    <li style="display: flex; align-items: center; gap: 8px; ">
                        <i class="bi bi-check-circle" style="font-size: 22px; color: black;"></i> 
                        <span><b>Schedule</b> vaccination appointments online</span>
                    </li>
                    <li style=" align-items: center; gap: 8px; margin-left: 15px;">
                        <i class="bi bi-check-circle" style="font-size: 22px; color: black;"></i> 
                        <span><b>Track</b> completed and upcoming vaccinations</span>
                    </li>
                    <li style="display: flex; align-items: center; gap: 8px;">
                        <i class="bi bi-check-circle" style="font-size: 22px; color: black;"></i> 
                        <span><b>Receive</b> timely reminders for due vaccines</span>
                    </li>
                    <li style="align-items: center; gap: 8px;margin-right: 75px;">
                        <i class="bi bi-check-circle" style="font-size: 22px; color: black;"></i> 
                        <span><b>View</b> detailed vaccination history</span>
                    </li>
                </ul>

                <p class="text-center" style="font-size: 18px; font-weight: bold;">
                    <strong>Ensure a healthier future for your child by staying updated with their immunization schedule.</strong>
                </p>
            </div>
        </div>

    </body>
</html>

