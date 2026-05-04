package com.service_hub.service;

import com.service_hub.dao.UserDAO;
import com.service_hub.model.UserModel;
import com.service_hub.utils.PasswordUtil;

public class LoginService {
    private UserDAO dao;

    public LoginService() {
        this.dao = new UserDAO();
    }
 // In LoginService.java
    public UserModel authenticate1(String email, String password) throws Exception {
        // Fetch user from database including the role
        UserDAO userDAO = new UserDAO();
        UserModel user = userDAO.findByEmail(email);
        
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            return user;  // Includes role information
        }
        return null;
    }
    /**
     * Validates user credentials for the LoginServlet.
     * @return UserModel if authenticated, null if invalid.
     */
    public UserModel authenticate(String email, String password) throws Exception {
        // Fetch the user record from the database based on email
        UserModel user = dao.getUserByEmail(email);

        // If user exists, verify the input password against the stored BCrypt hash
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            return user; // Authentication passed
        }
        
        return null; // Authentication failed
    }
}