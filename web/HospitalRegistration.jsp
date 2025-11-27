<%-- 
    Document   : DoctorRegistration
    Created on : 10 Apr, 2025, 5:29:03 PM
    Author     : RAJASEKARAN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hospital Registration</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-image: url("Images/homeimg3.jpg");
                background-size: cover;
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
        </style>
    </head>
    <body>
        <div class="registration-wrapper">
            <form class="registration-form" method="post" action="HospitalDetailsServlet" enctype="multipart/form-data" onsubmit="return hospitalLogin()">
                <h2>Hospital Registration</h2>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="hname" id="hospital_name" placeholder="Hospital Name" required>
                    <label for="hospital_name">Hospital Name</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="branch" id="branch" placeholder="Branch">
                    <label for="branch">Branch</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="hid" id="reg_id" placeholder="Registration ID" required>
                    <label for="reg_id">Registration ID (License)</label>
                </div>

<!--                                <div class="form-floating mb-3">
                                    <select class="form-select" name="hrole" id="hrole" required>
                                        <option value="" disabled selected>Select Role</option>
                                        <option value="Hospital">Hospital</option>
                                    </select>
                                    <label for="hrole">Role</label>
                                </div>-->
<!--                <div class="form-floating mb-3">
                    <select class="form-select" id="hrole" disabled>
                        <option value="Hospital" selected>Hospital</option>
                    </select>
                    <input type="hidden" name="hrole" value="Hospital" />
                    <label for="hrole">Role</label>
                </div>-->


                <div class="form-floating mb-3">
                    <input type="email" class="form-control" name="hemail" id="email_id" placeholder="Email ID" required>
                    <label for="email_id">Email ID</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="tel" class="form-control" name="hmobile" id="phone" placeholder="Mobile Number" required>
                    <label for="phone">Mobile Number</label>
                </div>

                <div class="form-floating mb-3">
                    <textarea class="form-control" name="haddress" id="address" placeholder="Address" required></textarea>
                    <label for="address">Address</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="number" class="form-control" name="hzipcode" id="code" placeholder="Zipcode" required>
                    <label for="code">Zipcode (6 digits)</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" name="hcity" id="city" placeholder="City" required>
                    <label for="city">City</label>
                </div>

                <div class="form-floating mb-3">
                    <select class="form-select" name="hstate" id="state" required>
                        <option value="" disabled selected>Select State</option>
                        <option value="Andhra Pradesh">Andhra Pradesh</option>
                        <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                        <option value="Assam">Assam</option>
                        <option value="Bihar">Bihar</option>
                        <option value="Chhattisgarh">Chhattisgarh</option>
                        <option value="Goa">Goa</option>
                        <option value="Gujarat">Gujarat</option>
                        <option value="Haryana">Haryana</option>
                        <option value="Himachal Pradesh">Himachal Pradesh</option>
                        <option value="Jharkhand">Jharkhand</option>
                        <option value="Karnataka">Karnataka</option>
                        <option value="Kerala">Kerala</option>
                        <option value="Madhya Pradesh">Madhya Pradesh</option>
                        <option value="Maharashtra">Maharashtra</option>
                        <option value="Manipur">Manipur</option>
                        <option value="Meghalaya">Meghalaya</option>
                        <option value="Mizoram">Mizoram</option>
                        <option value="Nagaland">Nagaland</option>
                        <option value="Odisha">Odisha</option>
                        <option value="Punjab">Punjab</option>
                        <option value="Rajasthan">Rajasthan</option>
                        <option value="Sikkim">Sikkim</option>
                        <option value="Tamil Nadu">Tamil Nadu</option>
                        <option value="Telangana">Telangana</option>
                        <option value="Tripura">Tripura</option>
                        <option value="Uttar Pradesh">Uttar Pradesh</option>
                        <option value="Uttarakhand">Uttarakhand</option>
                        <option value="West Bengal">West Bengal</option>
                        <option value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</option>
                        <option value="Chandigarh">Chandigarh</option>
                        <option value="Dadra and Nagar Haveli and Daman and Diu">Dadra and Nagar Haveli and Daman and Diu</option>
                        <option value="Lakshadweep">Lakshadweep</option>
                        <option value="Delhi">Delhi</option>
                        <option value="Puducherry">Puducherry</option>
                        <option value="Ladakh">Ladakh</option>
                        <option value="Jammu and Kashmir">Jammu and Kashmir</option>
                    </select>
                    <label for="state"></label>
                </div>

                <div class="form-floating mb-3">
                    <select class="form-select" name="hcountry" id="country" required>
                        <option value="" selected disabled>Select Country</option>
                        <option value="India">India</option>
                    </select>
                    <label for="country"></label>
                </div>

                <div class="mb-3">
                    <label for="photo" class="form-label" style="font-weight:bold;">Upload Profile Photo</label>
                    <input type="file" class="form-control" name="hphoto" id="photo" required>
                </div>

                <input type="submit" value="Register" class="btn-submit">
            </form>
        </div>

        <script>
            function hospitalLogin(event) {
                var hospital_name = document.getElementById('hospital_name').value.trim();
                var branch = document.getElementById('branch').value.trim();
                var reg_id = document.getElementById('reg_id').value.trim();
//                var hrole = document.getElementById("hrole").value;
                var email_id = document.getElementById('email_id').value.trim();
                var phone = document.getElementById('phone').value.trim();
                var address = document.getElementById('address').value.trim();
                var code = document.getElementById('code').value.trim();
                var city = document.getElementById("city").value.trim();
                var state = document.getElementById("state").value;
                var country = document.getElementById("country").value;
                var photo = document.querySelector('input[type="file"][name="hphoto"]');

                if (hospital_name === '') {
                    alert("Please enter your hospital name.");
                    document.getElementById('hospital_name').focus();
                    return false;
                } else if (branch === '') {
                    alert("Please enter your branch name.");
                    document.getElementById('branch').focus();
                    return false;
                } else if (reg_id === '') {
                    alert("Please enter your hospital id.");
                    document.getElementById('reg_id').focus();
                    return false;
                } 
//                else if (hrole === "") {
//                    alert("Please select your role.");
//                    return false;
//                } 
                else if (email_id === '') {
                    alert("Please enter your hospital email.");
                    document.getElementById('email_id').focus();
                    return false;
                } else if (phone === '') {
                    alert("Please enter your hospital mobile number.");
                    document.getElementById('phone').focus();
                    return false;
                } else if (phone.length !== 10) {
                    alert("Enter 10 digit number");
                    document.getElementById('phone').focus();
                    return false;
                } else if (address === '') {
                    alert("Please enter your hospital address.");
                    document.getElementById('address').focus();
                    return false;
                } else if (code === '') {
                    alert("Please enter your Zipcode");
                    document.getElementById('code').focus();
                    return false;
                } else if (code.length !== 6) {
                    alert("Enter 6 digit number");
                    document.getElementById('code').focus();
                    return false;
                } else if (city === '') {
                    alert("Please enter your city name.");
                    document.getElementById('city').focus();
                    return false;
                } else if (!state) {
                    alert("Please select a state");
                    return false;
                } else if (!country) {
                    alert("Select a country");
                    return false;
                } else if (!photo.value) {
                    alert("Please upload a photo.");
                    photo.focus();
                    return false;
                } else {

                    //        window.location.href="login.html";
                    return true;
                }


            }
        </script>
    </body>
</html>
