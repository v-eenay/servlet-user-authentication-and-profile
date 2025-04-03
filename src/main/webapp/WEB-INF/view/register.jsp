<%--
  Created by IntelliJ IDEA.
  User: koira
  Date: 4/1/2025
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | User Profile System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/validation.css">
</head>
<body>

<div class="container">
    <h1>Create Account</h1>
    <p class="welcome-message">Please fill in your details to register</p>
    
    <!-- Display error message if present -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" class="form" enctype="multipart/form-data">
        <!-- Account Information Section -->
        <div class="form-section">
            <div class="form-section-title">Account Information</div>
            <div class="form-group">
                <label for="username">Username*</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="email">Email Address*</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password*</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password*</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
        </div>
        
        <!-- Personal Information Section -->
        <div class="form-section">
            <div class="form-section-title">Personal Information</div>
            <div class="form-group">
                <label for="fullName">Full Name*</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            <div class="form-group">
                <label for="dateOfBirth">Date of Birth*</label>
                <input type="date" id="dateOfBirth" name="dateOfBirth" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender*</label>
                <select id="gender" name="gender" required>
                    <option value="" disabled selected>Select gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
        </div>
        
        <!-- Contact Information Section -->
        <div class="form-section">
            <div class="form-section-title">Contact Information</div>
            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone">
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address">
            </div>
        </div>
        
        <!-- Profile Picture Section -->
        <div class="form-section">
            <div class="form-section-title">Profile Picture</div>
            
            <!-- Image Preview -->
            <div id="imagePreview" class="image-preview">
                <img id="previewImg" src="#" alt="Profile Picture Preview">
            </div>
            
            <div class="form-group">
                <label>Upload Profile Picture</label>
                <div class="file-upload">
                    <label class="file-upload-label">
                        <div class="file-upload-icon">📷</div>
                        <div class="file-upload-text">Click to select a profile picture</div>
                        <div class="file-upload-text">(JPG, PNG, or GIF)</div>
                        <input type="file" id="profilePicture" name="profilePicture" accept="image/*" onchange="previewImage(this)">
                    </label>
                </div>
            </div>
        </div>
        
        <button type="submit" class="btn btn-primary">Register</button>
    </form>
    
    <p class="form-footer">Already have an account? <a href="${pageContext.request.contextPath}/LoginServlet">Login</a></p>
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

<script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>
</body>
</html>
