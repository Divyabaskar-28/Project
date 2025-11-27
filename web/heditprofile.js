/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

document.addEventListener("DOMContentLoaded", function () {
    // Inject CSS dynamically
    const link = document.createElement("link");
    link.rel = "stylesheet";
    link.href = "HLayout.css";
    document.head.appendChild(link);

    // Sidebar & Topbar
    const heditprofile = `
        <!-- Sidebar -->
          <div class="sidebar">
            <h6 class="text-center text-black" style="background-color: white;"><span><img src="Images/logo4.png" height="30px" width="40px"></span>
                <i>CHILD VACCINATION MANAGEMENT SYSTEM</i>
            </h6>
            <a href="HospitalDashboard.jsp"><i class="bi bi-house-door"></i> &nbsp;Dashboard</a>
            <a href="Schedule.jsp"><i class="bi bi-calendar-plus"></i> &nbsp;TimeTable</a>
            <a href="HospitalViewAppointment.jsp"><i class="bi bi-calendar-check"></i> &nbsp;View Appointment</a>
        </div>

       <div class="topbar d-flex justify-content-end align-items-center px-3 text-white" style="min-height: 50px; z-index: 1000;">
            <div class="d-flex align-items-center position-relative">
                <img src="Images/profile3.jfif" alt="User" height="40px" width="40px" class="rounded-circle me-3" 
                     style="cursor: pointer;" onclick="toggleProfile()">
                <a href="Homepage.jsp" class="btn btn-sm" style="background: linear-gradient(to right, #8b6fc8, #e091c9); color:white; font-size: 18px; font-weight: bold;">Logout</a>


                <div id="profileContainer" class="profile-container">
                    <p><strong>Hospital Name:</strong> <%= hospitalName%></p>
                    <p><strong>Hospital ID:</strong> <%= hospitalId%></p>
                    <p><strong>Email:</strong> <%= email%></p>
                    <p><strong>Mobile:</strong> <%= mobile%></p>
                    <p><strong>Address:</strong> <%= address + ", " + city + ", " + state + ", " + country + " - " + zipcode%></p>
                    <input type="submit" value="Edit" class="btn" id="edit" onclick="editProfile()">
                </div>
            </div>
        </div>

        `;

    document.body.insertAdjacentHTML("afterbegin", heditprofile);
});


function toggleProfile() {
    let profile = document.getElementById("profileContainer");
    profile.style.display = (profile.style.display === "block") ? "none" : "block";
}
function editProfile(){
    alert("Are you sure to edit your profile.");
    window.location.href = "parents_editprofile.html";

}
function updateProfile(event){
    event.preventDefault();
    // var hospitalName = document.getElementById("hospitalName").value.trim();
    // var registrationId = document.getElementById("registrationId").value.trim();
    // var email = document.getElementById("email").value.trim();
    // var mobile = document.getElementById("mobile").value.trim();
    // var address = document.getElementById("address").value.trim();

    // if(hospitalName === ''){
    //     alert("Please enter your hospital name.");
    //     document.getElementById("hospitalName").focus();
    //     return false;

    // }
    // else if(registrationId === ''){
    //     alert("Please enter your hospital registered id.");
    //     document.getElementById("registrationId").focus();
    //     return false;

    // }
    // else if(email === ''){
    //     alert("Please enter your hospital email id.");
    //     document.getElementById("email").focus();
    //     return false;

    // }
    // else if(mobile === ''){
    //     alert("Please enter your hospital mobile number.");
    //     document.getElementById("mobile").focus();
    //     return false;
    // }
    // else if(mobile.length !== 10){
    //     alert("Please enter 10 digit number.");
    //     document.getElementById("mobile").focus();
    //     return false;
    // }
    // else if (address === '') {
    //     alert("Enter your address.");
    //     document.getElementById("address").focus();
    //     return false;
    // }
    // else{
    //     alert("Profile updated successfully !!");
    //     window.location.href="hospital_dashboard.html";
    //     return true;
    // }

    alert("Profile updated successfully !!");
     window.location.href="parents_dashboard.html";
}
