<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700&family=Roboto:wght@300;400;500&display=swap');
            body {
                margin: 0;
                padding: 0;
                background: url("Images/homeimg3.jpg") no-repeat center center fixed;
                background-size: cover;
                font-family: 'Roboto', sans-serif;
                color: black;
                scroll-behavior: smooth;
            }
            h1, h2, h4 {
                font-family: 'Poppins', sans-serif;
                font-weight: 600;
                color: #624aa1;
            }
            h3 {
                font-family: 'Poppins', sans-serif;
                font-weight: 600;
                color: white;
            }

            .nav-link {
                color: white !important;
                font-weight: bold;
            }

            .nav-link:hover {
                color: #d1c4e9 !important;
            }

            .container {
                margin-top: 60px;
                padding-top: 50px;
            }

            .section {
                padding: 100px 20px;
                text-align: center;
            }

            .section h2 {
                color: #624aa1;
                font-weight: bold;
            }

            .image-container {
                display: flex;
                justify-content: center;
                gap: 30px;
                margin-top: 30px;
            }

            .image-container img {
                width: 300px;
                height: 200px;
                border-radius: 10px;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
            }

            .feature-box {
                background: white;
                padding: 20px;
                text-align: center;
                border-radius: 10px;
                box-shadow: 2px 4px 10px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                margin-bottom: 20px;
            }

            .feature-box:hover {
                transform: translateY(-5px);
                box-shadow: 5px 8px 15px rgba(0, 0, 0, 0.3);
            }

            .feature-box h4 {
                color: #624aa1;
            }

            .feature-box i {
                font-size: 30px;
                color: #624aa1;
                margin-bottom: 10px;
            }

            .footer {
                background-color: #624aa1;
                color: white;
                text-align: center;
                padding: 20px 0;
            }

            #currentYear {
                font-weight: bold;
                color: #f39c12;
            }

            .dropdown-item:hover {
                background-color: #4e3c90;
            }

            .navbar {
                background-color: #624aa1;
            }

            .navbar-toggler {
                border: none;
            }

            .navbar-toggler:focus {
                box-shadow: none;
            }
        </style>
    </head>
    <body>

        <!-- Header / Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <img src="Images/logo8.webp" alt="Logo" height="50" class="rounded-circle">
                    <span class="ms-2" style="word-spacing:10px;"><i>Immune Care</i></span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-end" id="navMenu">
                    <ul class="navbar-nav mb-2 mb-lg-0 me-3">
                        <li class="nav-item">
                            <a class="nav-link" href="#vaccination" style="font-size:16px;">Vaccination</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#hospital" style="font-size:16px;">Hospital</a>
                        </li>
                    </ul>

                    <div class="d-flex flex-column flex-lg-row gap-2">
                        <div class="dropdown">
                            <button class="btn btn-sm dropdown-toggle text-white fw-bold" type="button" data-bs-toggle="dropdown" style="background: linear-gradient(to right, #6a9bd8, #b082d3);font-size:18px;">
                                Register
                            </button>
                            <ul class="dropdown-menu" style="background: linear-gradient(to right, #8b6fc8, #e091c9);">
                                <li><a class="dropdown-item text-white fw-bold" href="HospitalRegistration.jsp">Hospital</a></li>
                                <li><a class="dropdown-item text-white fw-bold" href="ParentRegistration.jsp">Parents</a></li>
                            </ul>
                        </div>

                        <div class="dropdown">
                            <button class="btn btn-sm dropdown-toggle text-white fw-bold" type="button" data-bs-toggle="dropdown" style="background: linear-gradient(to right, #6a9bd8, #b082d3);font-size:18px;">
                                Login
                            </button>
                            <ul class="dropdown-menu" style="background: linear-gradient(to right, #8b6fc8, #e091c9);">
                                <li><a class="dropdown-item text-white fw-bold" href="AdminLogin.jsp">Admin</a></li>
                                <li><a class="dropdown-item text-white fw-bold" href="HospitalLogin.jsp">Hospital</a></li>
                                <li><a class="dropdown-item text-white fw-bold" href="ParentLogin.jsp">Parent</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Welcome Section -->
        <div class="container" id="home">
        <div class="section">
            <h2>Welcome to Immune Care</h2>
            <p>Ensuring timely vaccinations for children with automated scheduling, reminders, and records.</p>

            <div class="image-container">
                <img src="Images/img1.webp" alt="Child Vaccination">
                <img src="Images/img2.webp" alt="Child Vaccination">
                <img src="Images/img3.webp" alt="Child Vaccination">
            </div>
        </div>
    </div>

    <!-- Vaccination Section -->
    <div class="container section" id="vaccination">
        <h2>Importance of Vaccination</h2>
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-lg border-0 rounded-4 p-4" style="background: linear-gradient(to right, #f7f3ff, #e0d5ff);">
                    <div class="row align-items-center">
                        <div class="col-md-5">
                            <img src="Images/card1.png" alt="Vaccination" class="img-fluid rounded-3">
                        </div>
                        <div class="col-md-7 mt-3 mt-md-0">
                            <h4>Why Vaccinate?</h4>
                            <p>Vaccination is a simple, safe, and effective way of protecting people against harmful diseases before they come into contact with them.</p>
                            <ul>
                                <li>Prevents the spread of infectious diseases</li>
                                <li>Protects future generations</li>
                                <li>Reduces healthcare costs</li>
                                <li>Ensures community immunity (herd immunity)</li>
                            </ul>
                            <a href="VaccinationSchedule.jsp" class="btn mt-3 text-white fw-bold" style="background: #624aa1;">Explore Schedule</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Hospital Section -->
    <div class="container section" id="hospital">
        <h2>Role of Hospitals in Child Vaccination</h2>
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-lg border-0 rounded-4 p-4" style="background: linear-gradient(to right, #f7f3ff, #e0d5ff);">
                    <div class="row align-items-center">
                        <div class="col-md-5">
                            <img src="Images/hospital.png" alt="Hospital Vaccination" class="img-fluid rounded-3">
                        </div>
                        <div class="col-md-7 mt-3 mt-md-0">
                            <h4>Why Hospitals Are Crucial for Child Vaccination</h4>
                            <p>Hospitals provide essential services for vaccination. They offer proper medical care, monitor schedules, and ensure immunization awareness.</p>
                            <ul>
                                <li>Safe and clean vaccination environments</li>
                                <li>Advice and monitoring of vaccine effects</li>
                                <li>Timely vaccinations for children</li>
                                <li>Support immunization outreach efforts</li>
                            </ul>
                            <a href="HospitalRegistration.jsp" class="btn mt-3 text-white fw-bold" style="background: #624aa1;">Register Your Hospital</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer mt-5">
        <div>© <span id="currentYear"></span> Immune Care. All Rights Reserved.</div>
    </div>

    <!-- Year Script -->
    <script>
        document.getElementById('currentYear').textContent = new Date().getFullYear();
    </script>

</body>
</html>
