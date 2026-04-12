package com.service_hub.controller;

import com.service_hub.service.RegisterService;
import com.service_hub.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch Form data based exactly on Figma layout
            String fullName = request.getParameter("full_name");
            String email = request.getParameter("email");
            String number = request.getParameter("number");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm_password");

            // Validate that passwords match before proceeding
            if (password == null || !password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match!");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            // Populate the UserModel
            UserModel user = new UserModel();
            user.setFullName(fullName);
            user.setEmail(email);
            user.setNumber(number);
            user.setPassword(password);
            user.setRole("USER"); // Default role

            // Call service to add user
            RegisterService service = new RegisterService();
            service.addUser(user);
            
            // Redirect to login page after successful registration 
            response.sendRedirect(request.getContextPath() + "/login?success=true");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }
}