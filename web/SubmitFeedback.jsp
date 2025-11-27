<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email");
    String hospital = request.getParameter("hospital");
    String child = request.getParameter("child");
    String dateInput = request.getParameter("date"); // e.g., 18-05-2025
    String[] parts = dateInput.split("-");
    String date = parts[2] + "-" + parts[1] + "-" + parts[0]; // Output: 2025-05-18

    String vaccine = request.getParameter("vaccine");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comments = request.getParameter("comments");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");
            PreparedStatement ps = conn.prepareStatement("INSERT INTO feedback(parent_email, hospital_name, appointment_date, vaccine, child_name, rating, comments) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, email);
            ps.setString(2, hospital);
            ps.setString(3, date);
            ps.setString(4, vaccine);
            ps.setString(5, child);
            ps.setInt(6, rating);
            ps.setString(7, comments);

            ps.executeUpdate();
            ps.close();
            conn.close();

            out.println("<div style='text-align:center; color:green; font-size:18px; margin-top:30px;'>? Thank you for your feedback!</div>");
        } catch (Exception e) {
            out.println("<div style='text-align:center; color:red; font-size:16px;'>? Error: " + e.getMessage() + "</div>");
        }
    } else {
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Submit Feedback</title>
        <style>
            body {
                background-image: url("./homeimg3.jpg");
                background-size: cover;
            }
            .feedback-container {
                width: 400px;
                margin: 50px auto;
                padding: 25px;
                border-radius: 12px;
                background: linear-gradient(to right, #a18cd1, #fbc2eb);
                box-shadow: 0px 0px 12px rgba(0, 0, 0, 0.1);
                border: 2px solid #624aa1;
            }
            .feedback-container h2 {
                color: #624aa1;
                text-align: center;
            }
            label {
                font-weight: bold;
                color: #333;
            }
            select, textarea, input[type="submit"] {
                width: 100%;
                padding: 8px;
                margin-top: 8px;
                margin-bottom: 16px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }
            input[type="submit"] {
                background-color: #624aa1;
                color: white;
                font-weight: bold;
                cursor: pointer;
                transition: 0.3s ease;
            }
            input[type="submit"]:hover {
                background-color: #4f3b8c;
            }
        </style>
    </head>
    <body>

        <div class="feedback-container">
            <h2>Vaccination Feedback</h2>
            <form method="post">
                <input type="hidden" name="email" value="<%=email%>">
                <input type="hidden" name="hospital" value="<%=hospital%>">
                <input type="hidden" name="child" value="<%=child%>">
                <input type="hidden" name="date" value="<%=date%>">
                <input type="hidden" name="vaccine" value="<%=vaccine%>">

                <label for="rating">Rating (1-5):</label>
                <select name="rating" required>
                    <option value="5">5 - Excellent</option>
                    <option value="4">4 - Good</option>
                    <option value="3">3 - Fair</option>
                    <option value="2">2 - Poor</option>
                    <option value="1">1 - Very Poor</option>
                </select>

                <label for="comments">Comments:</label>
                <textarea name="comments" rows="4" placeholder="Write your feedback here..." required></textarea>

                <input type="submit" value="Submit Feedback">
            </form>
        </div>

    </body>
</html>

<%
    }
%>
