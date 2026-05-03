<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <div class="input-wrapper">
                    <i class="far fa-user"></i>
                    <input type="text" name="full_name" placeholder="Enter your full name" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Email Address</label>
                <div class="input-wrapper">
                    <i class="far fa-envelope"></i>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Phone Number</label>
                <div class="input-wrapper">
                    <i class="fas fa-phone-alt"></i>
                    <input type="text" name="number" placeholder="10-digit phone number" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Password</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" placeholder="Minimum 8 characters" required>
                </div>
            </div>
            
            <div class="input-group">
                <label>Confirm Password</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="confirm_password" placeholder="Re-enter password" required>
                </div>
            </div>
            
            <button type="submit" class="auth-btn">Create Account</button>
        </form>
        
        <p class="auth-footer">Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
    </div>
</body>
</html>