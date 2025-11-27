<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Parents Registration</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Bootstrap CDN -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <style>
            body {
                font-family: Arial, sans-serif;
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
                min-height: 100vh;
            }

            .registration-wrapper {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 20px;
            }

            .registration-form {
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 600px;
            }

            h2 {
                text-align: center;
                font-weight: bold;
                color: #624aa1;
                margin-bottom: 25px;
            }

            .btn-submit {
                background-color: #624aa1;
                color: white;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                padding: 12px 24px;
                display: block;
                margin: 0 auto;
            }

            .btn-submit:hover {
                background-color: #7a5ecb;
            }

            textarea.form-control {
                height: 100px !important;
            }

            @media (max-width: 576px) {
                .registration-form {
                    padding: 20px;
                }

                h2 {
                    font-size: 22px;
                }

                .btn-submit {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>

        <div class="container-fluid registration-wrapper">
            <form class="registration-form" method="post" onsubmit="return ParentLogin(event)" enctype="multipart/form-data" action="ParentDetailsServlet">

                <h2>Parents Registration</h2>

                <!-- Name -->
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="pname" id="name" placeholder="Name" required>
                    <label for="name">Name</label>
                </div>

                <!-- Age -->
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="page" id="age" placeholder="Age" required>
                    <label for="age">Age</label>
                </div>

                <!-- Gender -->
                <div class="form-floating mb-3">
                    <select class="form-select" name="pgender" id="child_gender" required>
                        <option value="" disabled selected hidden>Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                    <label for="child_gender"></label>
                </div>

                <!-- Email -->
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" name="pemail" id="email_id" placeholder="Email" required>
                    <label for="email_id">Email</label>
                </div>

                <!-- Mobile Number -->
                <div class="form-floating mb-3">
                    <input type="tel" class="form-control" name="pmobile" id="phone" placeholder="Mobile Number" required>
                    <label for="phone">Mobile Number</label>
                </div>

                <!-- Address -->
                <div class="form-floating mb-3">
                    <textarea class="form-control" name="paddress" id="address" placeholder="Address" required></textarea>
                    <label for="address">Address</label>
                </div>

                <!-- Role -->
<!--                <div class="form-floating mb-3">
                    <select class="form-select" name="prole" id="prole" required>
                        <option value="" disabled selected hidden>Select Role</option>
                        <option value="Parents">Parents</option>
                    </select>
                    <label for="prole"></label>
                </div>-->

                <!-- Password -->
                <div class="form-floating mb-3">
                    <input type="password" name="pwd" class="form-control" id="password" placeholder="Password" required>
                    <label for="password">Password</label>
                </div>

                <!-- Confirm Password -->
                <div class="form-floating mb-3">
                    <input type="password" name="cpwd" class="form-control" id="con_password" placeholder="Confirm Password" required>
                    <label for="con_password">Confirm Password</label>
                </div>

                <!-- Profile Photo Upload -->
                <div class="mb-3">
                    <label for="photo" class="form-label fw-bold">Upload Profile Photo</label>
                    <input type="file" class="form-control" name="pphoto" id="photo" required>
                </div>

                <!-- Submit Button -->
                <input type="submit" value="Register" class="btn-submit mt-3">
            </form>
        </div>

        <!-- Validation Script -->
        <script>
            function ParentLogin(event) {
                var name = document.getElementById("name").value.trim();
                var age = document.getElementById("age").value.trim();
                var gender = document.getElementById("child_gender").value;
                var email = document.getElementById("email_id").value.trim();
                var phone = document.getElementById("phone").value.trim();
                var address = document.getElementById("address").value.trim();
                var password = document.getElementById("password").value.trim();
                var confirmPassword = document.getElementById("con_password").value.trim();

                if (name === "" || age === "" || gender === "" || email === "" || phone === "" || address === "" || password === "" || confirmPassword === "") {
                    alert("Please fill in all required fields.");
                    return false;
                }

                if (phone.length !== 10 || isNaN(phone)) {
                    alert("Enter a valid 10-digit phone number.");
                    return false;
                }

                var regex = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).+$/;
                if (!regex.test(password)) {
                    alert("Password must include 1 uppercase, 1 number, and 1 special character.");
                    return false;
                }

                if (password !== confirmPassword) {
                    alert("Password and Confirm Password must match.");
                    return false;
                }

                return true;
            }
        </script>

    </body>
</html>
