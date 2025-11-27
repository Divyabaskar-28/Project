document.addEventListener("DOMContentLoaded", function () {
    // Inject CSS dynamically
    const link = document.createElement("link");
    link.rel = "stylesheet";
    link.href = "HLayout.css";
    document.head.appendChild(link);

    // Sidebar & Topbar
    const addchild = `
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
            <a href="Homepage.jsp" class="btn btn-sm" style="background: linear-gradient(to right, #8b6fc8, #e091c9); color:white; font-size:18px; font-weight: bold;">Logout</a>

           
            <div id="profileContainer" class="profile-container">
                <p><strong>Name:</strong> Priya</p>
                <p><strong>Age:</strong> 30</p>
                <p><strong>Gender:</strong> Female</p>
                <p><strong>Email:</strong> priya@gmail.com</p>
                <p><strong>Mobile:</strong> 995 765 4766</p>
                <p><strong>Address:</strong> 123 Main St, City</p>
                <input type="submit" value="Edit" class="btn" id="edit" onclick="editProfile()">
            </div>
        </div>
    </div>  
        
    `;

    document.body.insertAdjacentHTML("afterbegin", addchild);
});


function toggleProfile() {
    let profile = document.getElementById("profileContainer");
    profile.style.display = (profile.style.display === "block") ? "none" : "block";
}
function editProfile(){
    alert("Are you sure to edit your profile.");
    window.location.href = "parents_editprofile.html";

}

function validatePassword(event) {
    
    // var email = document.getElementById("email_id").value;
    // var currentPassword = document.getElementById("current_password").value.trim();
    var newPassword = document.getElementById("new_password").value.trim();
    var confirmPassword = document.getElementById("confirm_password").value.trim();

    // if(email === "")
    // {
    //     alert("Please enter yout email.");
    //     document.getElementById("email_id").focus();
    //     return false;
    // }
    
    // if (currentPassword === "") {
    //     alert("Please enter your current password.");
    //     document.getElementById("current_password").focus();
    //     return false;
    // }

    if (newPassword === "") {
        alert("Please enter a new password.");
        document.getElementById("new_password").focus();
        return false;
    }

    var passwordPattern = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).+$/;
    if (!passwordPattern.test(newPassword)) {
        alert("Password must contain at least 1 uppercase letter, 1 number, and 1 special character.");
        document.getElementById("new_password").focus();
        return false;
    }

    if (confirmPassword === "") {
        alert("Please confirm your new password.");
        document.getElementById("confirm_password").focus();
        return false;
    }

    var passwordPattern1 =/^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).+$/;
    if (!passwordPattern1.test(confirmPassword)) {
        alert("Password must contain at least 1 uppercase letter, 1 number, and 1 special character.");
        document.getElementById("confirm_password").focus();
        return false;
    }

    if (newPassword !== confirmPassword) {
        alert("New password and confirm password do not match.");
        document.getElementById("confirm_password").focus();
        return false;
    }

    alert("Password successfully changed!");
    window.location.href = "parents_dashboard.html"; 
    return true;
}







