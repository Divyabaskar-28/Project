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
    const peditprofile = `
        <!-- Sidebar -->
        <div class="sidebar">
            <h6 class="text-center text-black" style="background-color: white;"><span><img src="Images/logo4.png" height="30px" width="40px"></span>
                <i>CHILD VACCINATION MANAGEMENT SYSTEM</i>
            </h6>
            <a href="ParentDashboard.jsp"><i class="bi bi-speedometer2"></i> &nbsp; Dashboard</a>
            <a href="AddChild.jsp"><i class="bi bi-person-plus-fill"></i> &nbsp; Manage Child Data</a>
            <a href="BookAppointment.jsp"><i class="bi bi-calendar-event"></i> &nbsp; Book Appointment</a>
            <a href="ChangePassword.jsp"><i class="bi bi-lock-fill"></i> &nbsp; Change Password</a> 
            <a href="MyRemainder.jsp"><i class="bi bi-bell-fill"></i> &nbsp; My Reminder</a>

        </div>

        <div class="topbar d-flex justify-content-end align-items-center px-3 text-white" style="min-height: 50px; z-index: 1000;">
            <div class="d-flex align-items-center position-relative">
                <img src="Images/profile3.jfif" alt="User" height="40px" width="40px" class="rounded-circle me-3" 
                     style="cursor: pointer;" onclick="toggleProfile()">
                <a href="Homepage.jsp" class="btn btn-sm" style="background: linear-gradient(to right, #8b6fc8, #e091c9); color:white; font-size: 18px; font-weight: bold;">Logout</a>


               

                <div id="profileContainer" class="profile-container">
                    <p><strong>Name:</strong> <%= name%></p>
                    <p><strong>Age:</strong> <%= age%></p>
                    <p><strong>Gender:</strong> <%= gender%></p>
                    <p><strong>Email:</strong> <%= email%></p>
                    <p><strong>Mobile:</strong> <%= mobile%></p>
                    <p><strong>Address:</strong> <%= address%></p>
                    <input type="submit" value="Edit" class="btn" id="edit" onclick="editProfile()">
                </div>

            </div>
        </div>   
    `;

    document.body.insertAdjacentHTML("afterbegin", peditprofile);
});


function toggleProfile() {
    let profile = document.getElementById("profileContainer");
    profile.style.display = (profile.style.display === "block") ? "none" : "block";
}

function editProfile() {
    alert("Are you sure to edit your profile.");
    window.location.href = "ParentEditProfile.jsp";

}

//function updateProfile(event) {
//    alert("your data is successfully updated.");
//    window.location.href = "ParentDashboard.jsp";
//}


