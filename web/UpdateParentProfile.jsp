
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*, java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    // Get the current session email (logged-in user)
    String pemail = (String) session.getAttribute("parent_email");
    if (pemail == null) {
        response.sendRedirect("ParentLogin.jsp");
        return;
    }

    // Directory to save uploaded files
    String uploadPath = application.getRealPath("/") + "UploadedPhotos";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdir();

    String name = "", gender = "", mobile = "", address = "", profilePhotoPath = "";
    int age = 0;

    try {
        // Create factory and upload handler
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        // Parse the request
        List<FileItem> formItems = upload.parseRequest(request);

        for (FileItem item : formItems) {
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String value = item.getString("UTF-8");

                switch (fieldName) {
                    case "pname": name = value; break;
                    case "page": age = Integer.parseInt(value); break;
                    case "pgender": gender = value; break;
                    case "pmobile": mobile = value; break;
                    case "paddress": address = value; break;
                }
            } else {
                // File upload
                String fileName = new File(item.getName()).getName();
                if (fileName != null && !fileName.isEmpty()) {
                    String filePath = uploadPath + File.separator + fileName;
                    File storeFile = new File(filePath);
                    item.write(storeFile);
                    profilePhotoPath = "UploadedPhotos/" + fileName;
                }
            }
        }

        // Connect to database and update parent details
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cvms", "root", "");

        String updateQuery;
        if (profilePhotoPath.isEmpty()) {
            updateQuery = "UPDATE parent_details SET pname=?, page=?, pgender=?, pmobile=?, paddress=? WHERE pemail=?";
        } else {
            updateQuery = "UPDATE parent_details SET pname=?, page=?, pgender=?, pmobile=?, paddress=?, profile_photo=? WHERE pemail=?";
        }

        PreparedStatement ps = conn.prepareStatement(updateQuery);
        ps.setString(1, name);
        ps.setInt(2, age);
        ps.setString(3, gender);
        ps.setString(4, mobile);
        ps.setString(5, address);
        if (profilePhotoPath.isEmpty()) {
            ps.setString(6, pemail);
        } else {
            ps.setString(6, profilePhotoPath);
            ps.setString(7, pemail);
        }

        int rows = ps.executeUpdate();
        conn.close();

        if (rows > 0) {
            out.println("<script>alert('Profile updated successfully!'); window.location='ParentDashboard.jsp';</script>");
        } else {
            out.println("<script>alert('Update failed!'); window.location='ParentprofileEdit.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred!'); window.location='ParentprofileEdit.jsp';</script>");
    }
%>
