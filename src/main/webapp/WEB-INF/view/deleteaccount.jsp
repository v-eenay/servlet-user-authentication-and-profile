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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Account | <%= user.getFullName() %></title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
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
        
        <h1 class="profile-name">Delete Account</h1>
        <p class="profile-username">@<%= user.getUsername() %></p>
    </div>
    
    <!-- Display error message if present -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    
    <div class="delete-warning">
        <h3>Warning: This Action Cannot Be Undone</h3>
        <p>Deleting your account will:</p>
        <ul>
            <li>Permanently remove all your personal information</li>
            <li>Delete your profile picture and settings</li>
            <li>Remove your account from our system</li>
            <li>Log you out immediately</li>
        </ul>
        <p>If you're sure you want to proceed, please provide your password and a reason for leaving.</p>
    </div>
    
    <form action="${pageContext.request.contextPath}/DeleteAccountServlet" method="post" class="form">
        <div class="form-section">
            <div class="form-section-title">Reason for Leaving</div>
            
            <div class="form-group">
                <label for="reason">Please tell us why you're leaving (optional)</label>
                <textarea id="reason" name="reason" rows="4"></textarea>
            </div>
        </div>
        
        <div class="form-section">
            <div class="form-section-title">Confirm Deletion</div>
            
            <div class="form-group">
                <label for="password">Enter Your Password*</label>
                <input type="password" id="password" name="password" required>
                <p class="form-help">Your password is required to confirm account deletion</p>
            </div>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-danger">Delete My Account</button>
            <a href="${pageContext.request.contextPath}/UserProfileServlet" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>
