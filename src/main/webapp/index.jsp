<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        // User not logged in, redirect to LoginServlet
        response.sendRedirect("LoginServlet");
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
    <title>Dashboard | User Profile System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        <%@ include file="/assets/css/style.css" %>
    </style>
</head>
<body>

<div class="container">
    <% if (user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
    <div class="profile-image">
        <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(user.getProfilePicture()) %>" alt="Profile Picture" class="profile-pic">
    </div>
    <% } else { %>
    <div class="avatar">
        <%= firstLetter %>
    </div>
    <% } %>
    
    <h1>Dashboard | <%= user.getFullName() %></h1>
    <p class="welcome-message">Access granted to secure environment. Navigate through your personalized interface to manage system configurations and user parameters.</p>
    
    <div class="dashboard-actions">
        <a href="${pageContext.request.contextPath}/UserProfileServlet" class="btn btn-primary">System Profile</a>
        <a href="${pageContext.request.contextPath}/UpdateProfileServlet" class="btn btn-primary">Configure Settings</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-danger">Terminate Session</a>
    </div>
</div>

</body>
</html>
