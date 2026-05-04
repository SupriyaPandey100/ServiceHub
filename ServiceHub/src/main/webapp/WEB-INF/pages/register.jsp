<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ServiceHub | Create Account</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css">
    
    <style>
        .error-message {
            color: #d9534f;
            font-size: 13px;
            margin-bottom: 15px;
            padding: 10px;
            background: #f8d7da;
            border-radius: 6px;
            text-align: center;
        }
        
        .success-message {
            color: #5cb85c;
            font-size: 13px;
            margin-bottom: 15px;
            padding: 10px;
            background: #d4edda;
            border-radius: 6px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <h2 class="auth-title">Create Account</h2>
        <p class="auth-subtitle">Join our platform today</p>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="input-group">
                <label>Full Name</label>
                <div class="input-wrapper" style="position: relative;">
                    <i class="far fa-user" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="text" name="fullName" placeholder="Enter your full name" style="padding-left: 40px;" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Email Address</label>
                <div class="input-wrapper" style="position: relative;">
                    <i class="far fa-envelope" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="email" name="email" placeholder="Enter your email" style="padding-left: 40px;" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Phone Number</label>
                <div class="input-wrapper" style="position: relative;">
                    <i class="fas fa-phone-alt" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="text" name="phone" placeholder="10-digit phone number" style="padding-left: 40px;" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Address</label>
                <div class="input-wrapper" style="position: relative;">
                    <i class="fas fa-map-marker-alt" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="text" name="address" placeholder="Your address" style="padding-left: 40px;" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>City</label>
                <div class="input-wrapper" style="position: relative;">
                    <i class="fas fa-city" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="text" name="city" placeholder="Your city" style="padding-left: 40px;" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Password</label>
                <div class="input-wrapper" style="position: relative;">
                    <i class="fas fa-lock" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="password" name="password" placeholder="Minimum 6 characters" style="padding-left: 40px;" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Confirm Password</label>
                <div class="input-wrapper" style="position: relative;">
                    <i class="fas fa-lock" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="password" name="confirmPassword" placeholder="Re-enter password" style="padding-left: 40px;" required>
                </div>
            </div>
            
            <button type="submit" class="auth-btn">Create Account</button>
        </form>
        
        <p class="auth-footer">Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
    </div>
</body>
</html>