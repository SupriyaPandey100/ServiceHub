<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>ServiceHub | Create Account</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
    <div class="auth-card">
        <h2 class="auth-title">Create Account</h2>
        <p class="auth-subtitle">Join our platform today</p>
        
        <c:if test="${not empty error}">
            <p style="color: #d9534f; font-size: 13px; margin-bottom: 15px;"><i class="fas fa-exclamation-circle"></i> ${error}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="input-group">
                <label>Full Name</label>
                <div style="position: relative;">
                    <i class="far fa-user" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="text" name="full_name" placeholder="Enter your full name" style="padding-left: 40px;" required>
                </div>
            </div>
            <div class="input-group">
                <label>Email Address</label>
                <div style="position: relative;">
                    <i class="far fa-envelope" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="email" name="email" placeholder="Enter your email" style="padding-left: 40px;" required>
                </div>
            </div>
            <div class="input-group">
                <label>Phone Number</label>
                <div style="position: relative;">
                    <i class="fas fa-phone-alt" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="text" name="number" placeholder="10-digit phone number" style="padding-left: 40px;" required>
                </div>
            </div>
            <div class="input-group">
                <label>Password</label>
                <div style="position: relative;">
                    <i class="fas fa-lock" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="password" name="password" placeholder="Minimum 8 characters" style="padding-left: 40px;" required>
                </div>
            </div>
            <div class="input-group">
                <label>Confirm Password</label>
                <div style="position: relative;">
                    <i class="fas fa-lock" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="password" name="confirm_password" placeholder="Re-enter password" style="padding-left: 40px;" required>
                </div>
            </div>
            <button type="submit" class="auth-btn">Create Account</button>
        </form>
        <p class="auth-footer">Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
    </div>
</body>
</html>