<%--
  Created by IntelliJ IDEA.
  User: koira
  Date: 4/1/2025
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
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

    // Format date of birth if available
    String dob = "";
    if (user.getDateOfBirth() != null) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM d, yyyy");
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
    <title><%= user.getFullName() %> | Profile</title>
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
            <a href="${pageContext.request.contextPath}/" class="subtle-link">&larr; Back to Dashboard</a>
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
        
        <h1 class="profile-name"><%= user.getFullName() %></h1>
        <p class="profile-username">@<%= user.getUsername() %></p>
    </div>
    
    <div class="profile-sections">
        <div class="profile-section">
            <h2 class="section-title">Account Information</h2>
            <div class="profile-detail">
                <div class="detail-label">Email</div>
                <div class="detail-value"><%= user.getEmail() != null ? user.getEmail() : "Not provided" %></div>
            </div>
            <div class="profile-detail">
                <div class="detail-label">Username</div>
                <div class="detail-value"><%= user.getUsername() %></div>
            </div>
        </div>
        
        <div class="profile-section">
            <h2 class="section-title">Personal Information</h2>
            <div class="profile-detail">
                <div class="detail-label">Full Name</div>
                <div class="detail-value"><%= user.getFullName() != null ? user.getFullName() : "Not provided" %></div>
            </div>
            <div class="profile-detail">
                <div class="detail-label">Date of Birth</div>
                <div class="detail-value"><%= dob.isEmpty() ? "Not provided" : dob %></div>
            </div>
            <div class="profile-detail">
                <div class="detail-label">Gender</div>
                <div class="detail-value"><%= user.getGender() != null ? user.getGender() : "Not provided" %></div>
            </div>
        </div>
        
        <div class="profile-section">
            <h2 class="section-title">Contact Information</h2>
            <div class="profile-detail">
                <div class="detail-label">Phone Number</div>
                <div class="detail-value"><%= user.getPhone() != null && !user.getPhone().isEmpty() ? user.getPhone() : "Not provided" %></div>
            </div>
            <div class="profile-detail">
                <div class="detail-label">Address</div>
                <div class="detail-value"><%= user.getAddress() != null && !user.getAddress().isEmpty() ? user.getAddress() : "Not provided" %></div>
            </div>
        </div>
    </div>
    
    <div class="profile-actions">
        <a href="${pageContext.request.contextPath}/UpdateProfileServlet" class="btn btn-primary">Edit Profile</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>

</body>
</html>
