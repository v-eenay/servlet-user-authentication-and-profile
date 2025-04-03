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
    
    // Format date of birth for input field
    String dobString = "";
    if (user.getDateOfBirth() != null) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        dobString = sdf.format(user.getDateOfBirth());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify User Parameters | <%= user.getFullName() %></title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="container profile-container">
    <div class="profile-header">
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/UserProfileServlet" class="subtle-link">&larr; Return to System Data</a>
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
        
        <h1 class="profile-name">Configure User Parameters</h1>
        <p class="profile-username">@<%= user.getUsername() %></p>
    </div>
    
    <!-- Display error message if present -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="post" class="form" enctype="multipart/form-data">
        <div class="form-section">
            <div class="form-section-title">System Access Parameters</div>
            
            <div class="form-group">
                <label for="username">System ID</label>
                <input type="text" id="username" name="username" value="<%= user.getUsername() %>" disabled>
                <p class="form-help">System ID is immutable</p>
            </div>
            
            <div class="form-group">
                <label for="email">Primary Contact</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" disabled>
                <p class="form-help">Primary contact is immutable</p>
            </div>
        </div>
        
        <div class="form-section">
            <div class="form-section-title">Core Identity Data</div>
            
            <div class="form-group">
                <label for="fullName">Identity String*</label>
                <input type="text" id="fullName" name="fullName" value="<%= user.getFullName() != null ? user.getFullName() : "" %>" required>
            </div>
            
            <div class="form-group">
                <label for="dateOfBirth">Creation Date</label>
                <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= dobString %>">
            </div>
            
            <div class="form-group">
                <label for="gender">Entity Type</label>
                <select id="gender" name="gender">
                    <option value="" <%= user.getGender() == null || user.getGender().isEmpty() ? "selected" : "" %>>Select Entity Type</option>
                    <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
                    <option value="Prefer not to say" <%= "Prefer not to say".equals(user.getGender()) ? "selected" : "" %>>Prefer not to say</option>
                </select>
            </div>
        </div>
        
        <div class="form-section">
            <div class="form-section-title">Communication Endpoints</div>
            
            <div class="form-group">
                <label for="phone">Secondary Contact</label>
                <input type="tel" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
            </div>
            
            <div class="form-group">
                <label for="address">Location Data</label>
                <input type="text" id="address" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
            </div>
        </div>
        
        <div class="form-section">
            <div class="form-section-title">Visual Identifier</div>
            
            <% if (user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
            <div class="current-image">
                <p>Current Profile Picture:</p>
                <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(user.getProfilePicture()) %>" alt="Current Profile Picture">
            </div>
            <% } %>
            
            <!-- New Image Preview -->
            <div id="imagePreview" class="image-preview">
                <img id="previewImg" src="#" alt="New Profile Picture Preview">
            </div>
            
            <div class="form-group">
                <label for="profilePicture">Upload New Profile Picture</label>
                <div class="file-upload">
                    <input type="file" id="profilePicture" name="profilePicture" accept="image/*" onchange="previewImage(this)">
                    <p>Click to select a file or drag and drop</p>
                    <p class="form-help">Recommended size: 300x300 pixels. Max size: 5MB.</p>
                </div>
            </div>
        </div>
        
        <div class="form-section">
            <div class="form-section-title">Confirm Changes</div>
            
            <div class="form-group">
                <label for="password">Enter Password to Save Changes*</label>
                <input type="password" id="password" name="password" required>
                <p class="form-help">Your current password is required to save changes</p>
            </div>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="${pageContext.request.contextPath}/UserProfileServlet" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>

<script>
    function previewImage(input) {
        const preview = document.getElementById('imagePreview');
        const previewImg = document.getElementById('previewImg');
        
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                previewImg.src = e.target.result;
                preview.style.display = 'block';
            }
            
            reader.readAsDataURL(input.files[0]);
        } else {
            previewImg.src = '#';
            preview.style.display = 'none';
        }
    }
</script>

</body>
</html>
