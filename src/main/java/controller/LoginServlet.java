package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import model.UserDAO;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if there's a success message
        String registrationSuccess = (String) request.getSession().getAttribute("registrationSuccess");
        System.out.println(registrationSuccess);
        if (registrationSuccess != null) {
            request.setAttribute("registrationSuccess", registrationSuccess);
            // Remove the session attribute to prevent showing the message again
            request.getSession().removeAttribute("registrationSuccess");
        }

        // Redirect to the login.jsp page in WEB-INF/view directory
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        User user = UserDAO.getUserByEmailOrUsername(username, password);
        
        if (user != null) {
            // Authentication successful
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("loggedIn", true);
            
            // Redirect to homepage instead of user profile
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Authentication failed
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
}