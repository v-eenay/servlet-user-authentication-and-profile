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
        
        .btn-danger {
            background-color: #d85050;
            color: white;
            margin-top: var(--spacing-md);
        }
        
        .btn-danger:hover {
            background-color: #c04545;
        }
        
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        
        .modal-content {
            background-color: var(--background);
            margin: 15% auto;
            padding: var(--spacing-lg);
            border: 1px solid var(--border-color);
            width: 80%;
            max-width: 500px;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .modal-title {
            margin-top: 0;
            color: var(--error-color);
            font-family: var(--font-serif);
        }
        
        .modal-actions {
            margin-top: var(--spacing-md);
            display: flex;
            justify-content: flex-end;
            gap: var(--spacing-sm);
        }
        
        .close {
            color: var(--light-text);
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .close:hover {
            color: var(--text-color);
        }
        
        @media (max-width: 600px) {
            .profile-grid {
                grid-template-columns: 1fr;
            }
            
            .modal-content {
                width: 95%;
                margin: 10% auto;
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
        <button id="deleteAccountBtn" class="btn btn-danger">Delete Account</button>
    </div>
</div>

<!-- Delete Account Password Confirmation Modal -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3 class="modal-title">Confirm Account Deletion</h3>
        <p>Please enter your password to proceed to the account deletion page:</p>
        
        <form id="passwordForm" action="${pageContext.request.contextPath}/DeleteAccountServlet" method="get">
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="modal-actions">
                <button type="button" class="btn btn-secondary" id="cancelDelete">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmDelete">Continue</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Get the modal
    const modal = document.getElementById("deleteModal");
    
    // Get the button that opens the modal
    const btn = document.getElementById("deleteAccountBtn");
    
    // Get the <span> element that closes the modal
    const span = document.getElementsByClassName("close")[0];
    
    // Get the cancel button
    const cancelBtn = document.getElementById("cancelDelete");
    
    // Get the confirm button
    const confirmBtn = document.getElementById("confirmDelete");
    
    // Get the password input and form
    const passwordInput = document.getElementById("password");
    const passwordForm = document.getElementById("passwordForm");
    
    // When the user clicks the button, open the modal 
    btn.onclick = function() {
        modal.style.display = "block";
    }
    
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
        passwordInput.value = ""; // Clear password field
    }
    
    // When the user clicks on cancel, close the modal
    cancelBtn.onclick = function() {
        modal.style.display = "none";
        passwordInput.value = ""; // Clear password field
    }
    
    // When the user clicks on confirm, verify password and proceed
    confirmBtn.onclick = function() {
        // Check if password is entered
        if (passwordInput.value.trim() === "") {
            alert("Please enter your password to continue.");
            return;
        }
        
        // Verify password (this is just a frontend check, the actual verification happens in the servlet)
        const enteredPassword = passwordInput.value;
        
        // In a real application, you would verify the password on the server side
        // Here we just submit the form to proceed to the delete account page
        window.location.href = "${pageContext.request.contextPath}/DeleteAccountServlet";
    }
    
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
            passwordInput.value = ""; // Clear password field
        }
    }
</script>

</body>
</html>
