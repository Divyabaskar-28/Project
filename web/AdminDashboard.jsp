<%-- 
    Document   : AdminDashboard
    Created on : 12 Apr, 2025, 2:50:27 PM
    Author     : RAJASEKARAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            margin-top:90px;
           
           
        }
        .topbar {
            border:1px solid #624aa1;
            background-color: #624aa1;
            margin:0;
            padding:10px;
        
        }
    </style>
</head>
<body>
    <%@ include file="ADashboard.jsp" %> 
    

    <div class="content">
        
        <div class="container mt-5">
            <h2 class="text-center">Welcome to Child Vaccination Management System</h2>
            <p class="text-center">The Child Vaccination Management System is designed to improve access to vaccinations for
                 young children, ensuring that parents can schedule vaccination appointment easily.</p>
        </div>
    </div>
</body>
</html>

