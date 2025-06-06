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
    <title>Login | User Profile System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div class="container">
    <h1>System Access</h1>
    <p class="welcome-message">Authenticate with your credentials to access the secure environment</p>
    
    <!-- Display success message if present -->
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success">
        <%= request.getAttribute("success") %>
    </div>
    <% } %>
    <!-- Display success message if present -->
    <% if (request.getAttribute("registrationSuccess") != null) { %>
    <div class="alert alert-success">
        <%= request.getAttribute("registrationSuccess") %>
    </div>
    <% } %>
    
    <!-- Display error message if present -->                   
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/LoginServlet" method="post" class="form">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group remember-me-group">
            <label class="remember-me-label">
                <input type="checkbox" id="rememberMe" name="rememberMe">
                <span class="checkmark"></span>
                <span class="remember-text">Remember me</span>
            </label>
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>
    
    <p class="form-footer">Don't have an account? <a href="${pageContext.request.contextPath}/RegisterServlet">Register</a></p>
</div>

</body>
</html>
