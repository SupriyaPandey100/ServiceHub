package com.service_hub.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.service_hub.dao.LoginDAO;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginDAO loginDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        loginDAO = new LoginDAO();
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return password;
        }
    }
    
    // Show login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set no-cache headers to prevent showing logged-in state after logout
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("isLoggedIn") != null && (Boolean) session.getAttribute("isLoggedIn")) {
            String role = (String) session.getAttribute("role");
            if ("admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/User");
            }
            return;
        }
        
        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set no-cache headers
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect");
        
        // Validation
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both email and password");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }
        
        String hashedPassword = hashPassword(password);
        
        // Authenticate using DAO
        Map<String, Object> userData = loginDAO.authenticateUser(email, hashedPassword);
        
        if (userData != null) {
            // IMPORTANT: Invalidate any existing session first
            HttpSession existingSession = request.getSession(false);
            if (existingSession != null) {
                existingSession.invalidate();
            }
            
            // Create a brand new session
            HttpSession session = request.getSession(true);
            
            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(30 * 60);
            
            // Set session attributes
            session.setAttribute("userId", userData.get("userId"));
            session.setAttribute("fullName", userData.get("fullName"));
            session.setAttribute("username", userData.get("fullName"));
            session.setAttribute("email", userData.get("email"));
            session.setAttribute("phone", userData.get("phone"));
            session.setAttribute("address", userData.get("address"));
            session.setAttribute("city", userData.get("city"));
            session.setAttribute("role", userData.get("role"));
            session.setAttribute("isLoggedIn", true);
            
            // Update last login time using DAO
            int userId = (int) userData.get("userId");
            loginDAO.updateLastLogin(userId);
            
            String role = (String) userData.get("role");
            
            // Check if this is a booking redirect after login
            if ("booking".equals(redirect)) {
                String serviceName = request.getParameter("serviceName");
                String servicePrice = request.getParameter("servicePrice");
                String serviceCategory = request.getParameter("serviceCategory");
                
                session.setAttribute("showBookingPopup", true);
                session.setAttribute("popupServiceName", serviceName);
                session.setAttribute("popupServicePrice", servicePrice);
                session.setAttribute("popupServiceCategory", serviceCategory);
                
                response.sendRedirect(request.getContextPath() + "/services");
            } else {
                // Redirect based on role
                if ("admin".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/admin");
                } else {
                    response.sendRedirect(request.getContextPath() + "/services");
                }
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}