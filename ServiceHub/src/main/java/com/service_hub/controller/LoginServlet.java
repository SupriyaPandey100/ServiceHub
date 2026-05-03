package com.service_hub.controller;

import java.io.IOException;
import com.service_hub.service.LoginService;
import com.service_hub.model.UserModel;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // Show login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
        dispatcher.forward(request, response);
    }

    // Handle login form
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Changed from username to email based on Figma design
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        LoginService service = new LoginService();
        UserModel loggedInUser = null;

        try {
            loggedInUser = service.authenticate(email, password);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "System error occurred.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if (loggedInUser != null) {
            // Set session upon successful login
            HttpSession session = request.getSession();
            session.setAttribute("userSession", loggedInUser);
            
            // Redirect based on role
            if ("ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}