<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url("Images/homeimg3.jpg");
            background-size: cover;
            background-position: center;
        }

        .container {
            max-width: 400px;
            background: linear-gradient(to right, #a18cd1, #fbc2eb);    
            border-radius: 10px;
            padding: 20px;
            color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            margin-top: 100px;
        }

        h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            color:black;
        }

        .btn {
            background-color: #624aa1;
            color: white;
            font-weight: bold;
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #7a5ecb;
        }

        #otpSection, #passwordSection {
            display: none;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 style="color:#624aa1;">Forgot Password</h2>

        <form action="ResetPassword.jsp" method="post" onsubmit="return validateForgotPassword(event)">

            <div class="mb-3">
                <label>Select Role</label>
                <select class="form-control" name="urole" id="user_role">
                    <option value="">Select Role</option>
                    <option value="Hospital">Hospital</option>
                    <option value="Parent">Parent</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Email ID</label>
                <input type="email" name="uemail" class="form-control" id="email" oninput="checkEmail()">
            </div>

            <div id="otpSection" class="mb-3" style="display:none;">
                <label>OTP</label>
                <input type="text" name="otp" class="form-control" id="otp">
            </div>

            <div id="passwordSection" class="mb-3" style="display:none;">
                <label>New Password</label>
                <input type="password" name="new_password" class="form-control" id="new_password">

                <label>Confirm Password</label>
                <input type="password" name="confirm_password" class="form-control" id="confirm_password">
            </div>

            <div id="otpButton">
                <button type="button" class="btn" onclick="sendOTP()">Send OTP</button>
            </div>

            <input type="submit" class="btn" value="Reset Password" id="resetButton" style="display:none;">
        </form>
    </div>

    <script>
        let otpSent = false;

        function checkEmail() {
            const email = document.getElementById("email").value;
            const otpButton = document.getElementById("otpButton");

            if (email) {
                otpButton.style.display = 'inline-block';
            } else {
                otpButton.style.display = 'none';
            }
        }

        function sendOTP() {
            const email = document.getElementById("email").value;
            const role = document.getElementById("user_role").value;

            if (!email) {
                alert("Please enter your email address.");
                return;
            }

            if (!role) {
                alert("Please select your role.");
                return;
            }

            // Here, you would send the OTP to the user's email using server-side logic
            // Example: Use JavaMail API to send an OTP email
            // For this demo, let's assume the OTP is sent successfully
            otpSent = true;
            alert("OTP has been sent to your email.");
            
            // Show OTP section and reset password section
            document.getElementById("otpSection").style.display = 'block';
            document.getElementById("resetButton").style.display = 'inline';
        }

        function validateForgotPassword(event) {
            const email = document.getElementById("email").value.trim();
            const otp = document.getElementById("otp").value.trim();
            const newPassword = document.getElementById("new_password").value.trim();
            const confirmPassword = document.getElementById("confirm_password").value.trim();

            if (!email) {
                alert("Please enter your email.");
                return false;
            }

            if (!otpSent) {
                alert("Please send the OTP first.");
                return false;
            }

            if (!otp) {
                alert("Please enter the OTP.");
                return false;
            }

            if (newPassword === "") {
                alert("Please enter your new password.");
                return false;
            }

            if (newPassword !== confirmPassword) {
                alert("Passwords do not match. Please confirm your password.");
                return false;
            }

            // Logic to submit the form and reset the password (update the password in DB)
            alert("Password reset successfully!");

            return true;
        }
    </script>

</body>
</html>
