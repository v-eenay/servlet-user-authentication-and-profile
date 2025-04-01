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
    <title>Welcome | User Profile System</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="container">
    <div class="avatar">
        <%= firstLetter %>
    </div>
    <h1>Welcome, <%= user.getFullName() %>!</h1>
    <p class="welcome-message">You've successfully logged into your account.</p>
    
    <a href="UserProfileServlet" class="btn btn-primary">View Your Profile</a>
    <a href="LogoutServlet" class="btn btn-danger">Logout</a>
</div>

</body>
</html>
