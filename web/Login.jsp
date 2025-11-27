<%-- 
    Document   : Login
    Created on : 11 Apr, 2025, 2:27:22 PM
    Author     : RAJASEKARAN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <style>
            body {
                background: url("Images/homeimg3.jpg") no-repeat center center fixed;
                background-size: cover; 
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            label{
                font-weight:bold;
                font-size: 20px;
            }
            .login-container {
                background: linear-gradient(to right, #a18cd1, #fbc2eb);  
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 400px;
                text-align: center;
            }
            .form-group {
                text-align: left;
            }
            .form-control {
                height: 40px;
                font-size: 16px;
                border-radius: 5px;
            }
            .input-container {
                position: relative;
            }
            .input-container i {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                color: gray;
            }
            .forgot-password {
                text-align: right;
                margin-top: 5px;
            }
            .forgot-password a {
                color: #624aa1;
                text-decoration: none;
                font-weight: bold;
            }
            .signup-links {
                margin-top: 15px;
                font-size: 16px;
            }
            .signup-links a {
                font-weight: bold;
                color: #624aa1;
                text-decoration: none;
                margin: 0 5px;
            }

        </style>
    </head>

    <body>
        <div class="login-container">
            <h2 style="color: #a343ba; font-weight: bold;">Login</h2>

            <form method="post" id="loginForm" action="ValidateLogin.jsp">


                <div class="form-group">
                    <label class="form-label">Email</label>
                    <div class="input-container">
                        <input type="text" class="form-control" name="uname" id="uname" maxlength="50" autocomplete="off">
                        <i class="fas fa-user"></i>
                    </div>
                </div>

                <div class="form-group mt-3">
                    <label class="form-label">Password</label>
                    <div class="input-container">
                        <input type="password" class="form-control" name="upsw" id="pwd" maxlength="50" autocomplete="off">

                    </div>
                </div>

                <div class="form-group mt-3">
                    <label class="form-label">Select Role</label>
                    <select class="form-control" name="urole" id="user_role" onchange="checkRole()">
                        <option value="" selected disabled>Select</option>
                        
                        <option value="hospital">Hospital</option>
                        <option value="parents">Parents</option>
                    </select>
                </div>

                <div class="forgot-password">
                    <a href="ForgetPassword1.jsp" id="forgotPasswordLink">Forgot Password?</a>
                </div>

                <div class="mt-3">
                    <button type="button" class="btn  w-100" style="background-color: #624aa1;color: white;" onclick="return Login(event)">Submit</button>

                    <button type="button" class="btn  w-100 mt-2" style="background-color: #624aa1;color: white;" onclick="return clearLogin(event)">Clear</button>
                </div>

                <!--            <div class="signup-links">
                                Sign Up: <a href="HospitalRegistration.jsp">Hospital</a> | <a href="ParentRegistration.jsp">Parent</a>
                            </div>-->
            </form>
        </div>

        <script>
            function checkRole() {
                var role = document.getElementById('user_role').value;
                var forgotPasswordLink = document.getElementById('forgotPasswordLink');

                if (role === 'admin') {
                    forgotPasswordLink.style.pointerEvents = 'none'; // Disable the link
                    forgotPasswordLink.style.color = 'gray'; // Optional: change color to show it's disabled
                } else {
                    forgotPasswordLink.style.pointerEvents = 'auto'; // Enable the link
                    forgotPasswordLink.style.color = '#624aa1'; // Restore original color
                }
            }

            function Login(event) {
                var username = document.getElementById('uname').value.trim();
                var password = document.getElementById('pwd').value.trim();
                var role = document.getElementById('user_role').value;

                if (username === '' && password === '') {
                    alert("Please enter your username and password.");
                    document.getElementById('uname').focus();
                    event.preventDefault();
                    return false;
                } else if (username === '') {
                    alert("Please enter your username.");
                    document.getElementById('uname').focus();
                    event.preventDefault();
                    return false;
                } else if (password === '') {
                    alert("Please enter your password.");
                    document.getElementById('pwd').focus();
                    event.preventDefault();
                    return false;
                } else if (role === '') {
                    alert("Select a role.");
                    document.getElementById('user_role').focus();
                    event.preventDefault();
                    return false;
                }

                // ✅ If validation passes, submit the form
                document.getElementById('loginForm').submit();
                return true;
            }


            function clearLogin(event) {
                document.getElementById('uname').value = '';
                document.getElementById('pwd').value = '';
                document.getElementById('user_role').selectedIndex = 0;
            }
        </script>
    </body>
</html>
