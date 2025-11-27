<%-- 
    Document   : ParentLogin
    Created on : 5 May, 2025, 12:51:14 PM
    Author     : RAJASEKARAN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Parent Login</title>

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
            label {
                font-weight: bold;
            }
            .login-container {
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .form-group {
                text-align: left;
            }
            .form-control {
                height: 40px;
                font-size: 16px;
                border-radius: 5px;
                padding-right: 2.2rem;
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
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-11 col-sm-9 col-md-7 col-lg-5 col-xl-4">
                    <div class="login-container p-4 mt-4">
                        <h2 style="color: #a343ba; font-weight: bold;">Parent Login</h2>

                        <% String error = (String) request.getAttribute("error");
                        if (error != null) {%>
                        <div class="alert alert-danger mt-2" role="alert">
                            <%= error%>
                        </div>
                        <% }%>

                        <form method="post" id="loginForm" action="ParentLoginServlet">
                            <div class="form-group mt-3">
                                <label class="form-label fs-5">Email</label>
                                <div class="input-container">
                                    <input type="text" class="form-control" name="uname" id="uname" maxlength="50" autocomplete="off">
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>

                            <div class="form-group mt-3">
                                <label class="form-label fs-5">Password</label>
                                <div class="input-container">
                                    <input type="password" class="form-control" name="upsw" id="pwd" maxlength="50" autocomplete="off">
                                    
                                </div>
                            </div>

                            <div class="forgot-password">
                                <a href="ForgetParentPassword.jsp">Forgot Password?</a>
                            </div>

                            <div class="mt-3">
                                <button type="submit" class="btn w-100" style="background-color: #624aa1; color: white;">Submit</button>
                                <button type="button" class="btn w-100 mt-2" style="background-color: #624aa1; color: white;" onclick="clearLogin()">Clear</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function clearLogin() {
                document.getElementById('uname').value = '';
                document.getElementById('pwd').value = '';
            }
        </script>
    </body>
</html>
