package com.service_hub.model;

/**
 * Model class representing a User in the Service Hub system.
 * This class acts as a Data Transfer Object (DTO) mapping to the 3NF 'users' table.
 */
public class UserModel {
    
    private int userId; 
    private String fullName;
    private String email;
    private String number;
    private String address;
    private String password;
    private String role; // Role-based access: "ADMIN" or "USER"

    // Default constructor required for JavaBeans
    public UserModel() {}

    // --- Getters and Setters ---

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}