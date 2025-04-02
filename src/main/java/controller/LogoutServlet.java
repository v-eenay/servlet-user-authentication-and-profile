package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Remove user attribute
            session.removeAttribute("user");
            session.removeAttribute("loggedIn");
            
            // Invalidate the session
            session.invalidate();
        }
        
        // Add a message to be displayed on the login page
        request.getSession().setAttribute("success", "You have been successfully logged out.");
        
        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Call doGet to handle post requests as well
        doGet(request, response);
    }
}