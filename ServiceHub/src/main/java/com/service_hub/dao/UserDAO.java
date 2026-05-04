package com.service_hub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.service_hub.model.UserModel;
import com.service_hub.utils.DBconfig;

public class UserDAO {

    /**
     * Validation Check: Prevents duplicate accounts by checking 
     * if the email or phone number is already registered.
     */
    public boolean isUserExists(String email, String number) throws Exception {
        boolean exists = false;
        String sql = "SELECT user_id FROM users WHERE email = ? OR number = ?";
        
        // Using try-with-resources to ensure database connections close automatically
        try (Connection con = DBconfig.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            pst.setString(1, email);
            pst.setString(2, number);
            
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Database error while checking user existence: " + e.getMessage());
        }
        return exists;
    }

    /**
     * Registration: Inserts a new user into the database.
     * Maps exactly to your 3NF database schema.
     */
    public void insertUser(UserModel user) throws Exception {
        String sql = "INSERT INTO users (full_name, email, number, address, password, role) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection con = DBconfig.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            pst.setString(1, user.getFullName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getNumber());
            // Since address isn't on the Figma form, we pass a default or handle it if it's null
            pst.setString(4, user.getAddress() != null ? user.getAddress() : "Kathmandu, Nepal"); 
            pst.setString(5, user.getPassword()); // This will be the BCrypt hashed password
            pst.setString(6, user.getRole());

            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Database error during user registration: " + e.getMessage());
        }
    }

    /**
     * Authentication: Retrieves a user's record by email to verify their password
     * and check their role (ADMIN vs USER) for dashboard routing.
     */
    public UserModel getUserByEmail(String email) throws Exception {
        UserModel user = null;
        String sql = "SELECT * FROM users WHERE email = ?";
        
        try (Connection con = DBconfig.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            pst.setString(1, email);
            
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    user = new UserModel();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setNumber(rs.getString("number"));
                    user.setAddress(rs.getString("address"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Database error during authentication: " + e.getMessage());
        }
        return user;
    }

	public UserModel findByEmail(String email) {
		// TODO Auto-generated method stub
		return null;
	}
}