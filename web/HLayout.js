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
    const hlayout = `
        <!-- Sidebar -->
        <div class="sidebar">
            <h6 class="text-center text-black" style="background-color: white;">
                <span><img src="Images/logo4.png" height="30px" width="40px"></span>
                <i>CHILD VACCINATION MANAGEMENT SYSTEM</i>
            </h6>
             <a href="HospitalDashboard.jsp"><i class="bi bi-house-door"></i> &nbsp;Dashboard</a>
            <a href="Schedule.jsp"><i class="bi bi-calendar-plus"></i> &nbsp;TimeTable</a>
            <a href="HospitalViewAppointment.jsp"><i class="bi bi-calendar-check"></i> &nbsp;View Appointment</a>
            
        </div>

        <!-- Topbar -->
        <div class="topbar d-flex justify-content-end align-items-center px-3 text-white" style="min-height: 50px; z-index: 1000;">
        <div class="d-flex align-items-center position-relative">
            <img src="Images/profile3.jfif" alt="User" height="40px" width="40px" class="rounded-circle me-3" 
                style="cursor: pointer;" onclick="toggleProfile()">
            <a href="Homepage.jsp" class="btn btn-sm" style="background: linear-gradient(to right, #8b6fc8, #e091c9); color:white; font-size:18px; font-weight: bold;">Logout</a>

           
            <div id="profileContainer" class="profile-container">
                <p><strong >Hospital Name:</strong> City General Hospital</p>
                <p><strong>Hospital ID:</strong> HOSP-12345</p>
                <p><strong>Email:</strong> hospital@cityhospital.com</p>
                <p><strong>Mobile:</strong> +123 456 7890</p>
                <p><strong>Address:</strong> 123 Main Street, City</p>
                <input type="submit" value="Edit" class="btn" id="edit" onclick="editProfile()">
            </div>
        </div>
    </div>  
    `;

    document.body.insertAdjacentHTML("afterbegin", hlayout);
});

function toggleProfile() {
    let profile = document.getElementById("profileContainer");
    if (profile.style.display === "none" || profile.style.display === "") {
        profile.style.display = "block";
    } else {
        profile.style.display = "none";
    }
}

function editProfile() {
    alert("Are you sure to edit your profile.");
    window.location.href = "HospitalEditProfile.jsp";

}

function saveForm(event) {

    var age = document.getElementById("age").value;
    var vaccination = document.getElementById("vaccination").value;
    var dose = document.getElementById("dose").value;

    if (age === '') {
        alert("please enter the age details.");
        document.getElementById("age").value();
        return false;

    } else if (vaccination === '') {
        alert("please enter the vaccination details.");
        document.getElementById("vaccination").value();
        return false;
    } else if (dose === '') {
        alert("please enter the dose details.");
        document.getElementById("dose").value();
        return false;
    } else {
        alert("Your vaccination details is successfully submitted!!");
        window.location.href = "schedule.html";
        return true;
    }

}
function showForm() {
    let AddForm = document.getElementById("AddForm");
    let gridpage = document.getElementById("gridpage");
    if (AddForm.style.display === "none") {
        AddForm.style.display = "block";
        gridpage.style.display = "none";
    } else {
        AddForm.style.display = "none";
        gridpage.style.display = "block";
    }
}
function hideForm() {
    document.getElementById("age").value = '';
    document.getElementById("vaccination").value = '';
    document.getElementById("dose").value = '';

    let AddForm = document.getElementById("AddForm");
    let gridpage = document.getElementById("gridpage");

    if (AddForm && gridpage) {
        AddForm.style.display = "none";
        gridpage.style.display = "block";
    } else {
        console.log("Error: AddForm or gridpage elements not found.");
    }


    // document.getElementById("AddForm").style.display = "none";
    // document.getElementById("gridpage").style.display = "block";
}




