<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get user from session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // User not logged in, redirect to LoginServlet
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
    
    // Format date of birth for input field
    String dob = "";
    if (user.getDateOfBirth() != null) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        dob = sdf.format(user.getDateOfBirth());
    }
    
    // Get the first letter of the user's name for the avatar
    String firstLetter = "";
    if (user.getFullName() != null && !user.getFullName().isEmpty()) {
        firstLetter = user.getFullName().substring(0, 1).toUpperCase();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile | <%= user.getFullName() %></title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        <%@ include file="/assets/css/style.css" %>
    </style>
</head>
<body>

<div class="container profile-container">
    <div class="profile-header">
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/UserProfileServlet" class="subtle-link">&larr; Back to Profile</a>
        </div>
        
        <% if (user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
        <div class="profile-image large">
            <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(user.getProfilePicture()) %>" alt="Profile Picture" class="profile-pic">
        </div>
        <% } else { %>
        <div class="avatar large">
            <%= firstLetter %>
        </div>
        <% } %>
        
        <h1 class="profile-name">Edit Your Profile</h1>
        <p class="profile-username">@<%= user.getUsername() %></p>
    </div>
    
    <!-- Display error message if present -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="post" class="form" enctype="multipart/form-data">
        <!-- Personal Information Section -->
        <div class="form-section">
            <div class="form-section-title">Personal Information</div>
            <div class="form-group">
                <label for="fullName">Full Name*</label>
                <input type="text" id="fullName" name="fullName" value="<%= user.getFullName() != null ? user.getFullName() : "" %>" required>
            </div>
            <div class="form-group">
                <label for="dateOfBirth">Date of Birth*</label>
                <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= dob %>" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender*</label>
                <select id="gender" name="gender" required>
                    <option value="" disabled>Select gender</option>
                    <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
                </select>
            </div>
        </div>
        
        <!-- Contact Information Section -->
        <div class="form-section">
            <div class="form-section-title">Contact Information</div>
            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
            </div>
        </div>
        
        <!-- Profile Picture Section -->
        <div class="form-section">
            <div class="form-section-title">Profile Picture</div>
            <div class="form-group">
                <label>Upload New Profile Picture</label>
                <div class="file-upload">
                    <label class="file-upload-label">
                        <div class="file-upload-icon">📷</div>
                        <div class="file-upload-text">Click to select a new profile picture</div>
                        <div class="file-upload-text">(JPG, PNG, or GIF)</div>
                        <input type="file" id="profilePicture" name="profilePicture" accept="image/*">
                    </label>
                </div>
                <p class="form-help">Leave empty to keep current profile picture</p>
            </div>
        </div>
        
        <!-- Account Information Section (Read-only) -->
        <div class="form-section">
            <div class="form-section-title">Account Information (Cannot be changed)</div>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" value="<%= user.getUsername() %>" disabled>
            </div>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" value="<%= user.getEmail() %>" disabled>
            </div>
        </div>
        
        <!-- Password Confirmation Section -->
        <div class="form-section">
            <div class="form-section-title">Confirm Changes</div>
            <div class="form-group">
                <label for="password">Enter Your Password to Confirm Changes*</label>
                <input type="password" id="password" name="password" required>
                <p class="form-help">You must enter your current password to save changes</p>
            </div>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="${pageContext.request.contextPath}/UserProfileServlet" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>
