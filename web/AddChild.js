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

    document.body.insertAdjacentHTML("afterbegin", addchild);
});


function toggleProfile() {
    let profile = document.getElementById("profileContainer");
    profile.style.display = (profile.style.display === "block") ? "none" : "block";
}

function saveForm(event) {



    var child_name = document.getElementById("child_name").value;
    var child_dob = document.getElementById("child_dob").value;
    var child_gender = document.getElementById("child_gender").value;
    var age = document.getElementById("age").value;
    var child_blood = document.getElementById("child_blood").value;
    var child_weight = document.getElementById("child_weight").value;
    var fat_name = document.getElementById("fat_name").value;
    var mot_name = document.getElementById("mot_name").value;

    if (child_name === '') {
        alert("Please enter the child fullname");
        document.getElementById("child_name").focus();
        return false;
    } else if (child_dob === '') {
        alert("Please enter the child dob.");
        document.getElementById("child_dob").focus();
        return false;
    } else if (child_gender === '') {
        alert("Please enter the gender of the child.");
        document.getElementById("child_gender").focus();
        return false;
    } else if (age === '') {
        alert("Please enter the child age.");
        document.getElementById("age").focus();
        return false;
    } else if (child_blood === '') {
        alert("Please enter the child blood group.");
        document.getElementById("child_blood").focus();
        return false;
    } else if (child_weight === '') {
        alert("Please enter the child weight.");
        document.getElementById("child_weight").focus();
        return false;
    } else if (fat_name.trim() === '') {
        alert("Please enter the child's father name.");
        document.getElementById("fat_name").focus();
        return false;
    } else if (mot_name.trim() === '') {
        alert("Please enter the child's mother name.");
        document.getElementById("mot_name").focus();
        return false;
    } else {
        alert("You successfully added your child !!");
        window.location.href = "AddChild.jsp";
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
    document.getElementById("child_name").value = '';
    document.getElementById("child_dob").value = '';
    document.getElementById("child_gender").value = '';
    document.getElementById("age").value = '';
    document.getElementById("child_blood").value = '';
    document.getElementById("child_weight").value = '';
    document.getElementById("fat_name").value = '';
    document.getElementById("mot_name").value = '';

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




function editProfile() {
    alert("Are you sure to edit your profile.");
    window.location.href = "ParentEditProfile.jsp";

}






