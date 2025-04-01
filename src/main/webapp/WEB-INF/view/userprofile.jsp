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
    
    // Get the first letter of the user's name for the avatar
    String firstLetter = "";
    if (user.getFullName() != null && !user.getFullName().isEmpty()) {
        firstLetter = user.getFullName().substring(0, 1).toUpperCase();
    }
    
    // Format date of birth if available
    String dob = "";
    if (user.getDateOfBirth() != null) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM d, yyyy");
        dob = sdf.format(user.getDateOfBirth());
    }
    
    // Check for success message
    String message = (String) session.getAttribute("message");
    if (message != null) {
        // Remove message from session after retrieving it
        session.removeAttribute("message");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile | <%= user.getFullName() %></title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .profile-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-md);
        }
        
        .profile-item {
            padding: var(--spacing-sm);
            border: 1px solid var(--border-color);
            background-color: var(--background);
        }
        
        .item-label {
            font-weight: 500;
            color: var(--light-text);
            margin-bottom: var(--spacing-xs);
            font-size: 0.9rem;
        }
        
        .item-value {
            font-size: 1.1rem;
        }
        
        @media (max-width: 600px) {
            .profile-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<div class="container profile-container">
    <div class="profile-header">
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/" class="subtle-link">&larr; Back to Home</a>
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
        
        <% if (message != null) { %>
        <div class="alert alert-success">
            <%= message %>
        </div>
        <% } %>
    </div>
    
    <div class="profile-sections">
        <div class="profile-section">
            <h2 class="section-title">Account Information</h2>
            <div class="profile-grid">
                <div class="profile-item">
                    <div class="item-label">Username</div>
                    <div class="item-value"><%= user.getUsername() %></div>
                </div>
                <div class="profile-item">
                    <div class="item-label">Email</div>
                    <div class="item-value"><%= user.getEmail() %></div>
                </div>
            </div>
        </div>
        
        <div class="profile-section">
            <h2 class="section-title">Personal Information</h2>
            <div class="profile-grid">
                <div class="profile-item">
                    <div class="item-label">Full Name</div>
                    <div class="item-value"><%= user.getFullName() != null ? user.getFullName() : "Not provided" %></div>
                </div>
                <div class="profile-item">
                    <div class="item-label">Date of Birth</div>
                    <div class="item-value"><%= dob.isEmpty() ? "Not provided" : dob %></div>
                </div>
                <div class="profile-item">
                    <div class="item-label">Gender</div>
                    <div class="item-value"><%= user.getGender() != null ? user.getGender() : "Not provided" %></div>
                </div>
            </div>
        </div>
        
        <div class="profile-section">
            <h2 class="section-title">Contact Information</h2>
            <div class="profile-grid">
                <div class="profile-item">
                    <div class="item-label">Phone</div>
                    <div class="item-value"><%= user.getPhone() != null && !user.getPhone().isEmpty() ? user.getPhone() : "Not provided" %></div>
                </div>
                <div class="profile-item">
                    <div class="item-label">Address</div>
                    <div class="item-value"><%= user.getAddress() != null && !user.getAddress().isEmpty() ? user.getAddress() : "Not provided" %></div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="profile-actions">
        <a href="${pageContext.request.contextPath}/UpdateProfileServlet" class="btn btn-primary">Edit Profile</a>
        <a href="${pageContext.request.contextPath}/ResetPasswordServlet" class="btn btn-secondary">Reset Password</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-outline">Logout</a>
    </div>
</div>

</body>
</html>
