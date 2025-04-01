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

<!DOCTYPE html>a
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        <%@ include file="/assets/css/style.css" %>
    </style>
</head>
<body>

<div class="container">
    <h1>User Profile System</h1>
    <p class="welcome-message">Welcome to the User Profile System. Please choose an option below to continue.</p>
    
    <a href="${pageContext.request.contextPath}/LoginServlet" class="btn btn-primary">Login</a>
    <a href="${pageContext.request.contextPath}/RegisterServlet" class="btn btn-primary">Register</a>
</div>

</body>
</html>
