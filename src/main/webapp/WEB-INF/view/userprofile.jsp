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
    
    // Format date of birth
    String dobString = "";
    if (user.getDateOfBirth() != null) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM dd, yyyy");
        dobString = sdf.format(user.getDateOfBirth());
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
</head>
<body>

<div class="container profile-container">
    <div class="profile-header">
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/LoginServlet" class="subtle-link">&larr; Back to Home</a>
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
    
    <!-- Display success message if present -->
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success">
        <%= request.getAttribute("success") %>
    </div>
    <% } %>
    
    <!-- Display error message if present -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    
    <div class="profile-sections">
        <div class="profile-section">
            <h2 class="section-title">Account Information</h2>
            
            <div class="profile-detail">
                <div class="detail-label">Username</div>
                <div class="detail-value"><%= user.getUsername() %></div>
            </div>
            
            <div class="profile-detail">
                <div class="detail-label">Email</div>
                <div class="detail-value"><%= user.getEmail() %></div>
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
                <div class="detail-value"><%= !dobString.isEmpty() ? dobString : "Not provided" %></div>
            </div>
            
            <div class="profile-detail">
                <div class="detail-label">Gender</div>
                <div class="detail-value"><%= user.getGender() != null && !user.getGender().isEmpty() ? user.getGender() : "Not provided" %></div>
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
        <a href="${pageContext.request.contextPath}/ResetPasswordServlet" class="btn btn-secondary">Change Password</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-outline">Logout</a>
        <button id="deleteAccountBtn" class="btn btn-danger">Delete Account</button>
    </div>
</div>

<!-- Delete Account Modal -->
<div id="deleteAccountModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2 class="modal-title">Verify Password</h2>
        <p>Please enter your password to proceed to account deletion.</p>
        
        <form action="${pageContext.request.contextPath}/DeleteAccountServlet" method="post" class="form">
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="modal-actions">
                <button type="button" class="btn btn-secondary" id="cancelDelete">Cancel</button>
                <button type="submit" class="btn btn-danger">Continue</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Get the modal
    const modal = document.getElementById("deleteAccountModal");
    
    // Get the button that opens the modal
    const btn = document.getElementById("deleteAccountBtn");
    
    // Get the <span> element that closes the modal
    const span = document.getElementsByClassName("close")[0];
    
    // Get the cancel button
    const cancelBtn = document.getElementById("cancelDelete");
    
    // When the user clicks the button, open the modal 
    btn.onclick = function() {
        modal.style.display = "block";
    }
    
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }
    
    // When the user clicks on cancel, close the modal
    cancelBtn.onclick = function() {
        modal.style.display = "none";
    }
    
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>

</body>
</html>
