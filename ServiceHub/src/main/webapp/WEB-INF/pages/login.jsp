<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>ServiceHub | Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <div class="auth-card">
        <h2 class="auth-title">Welcome Back</h2>
        <p class="auth-subtitle">Sign in to your account</p>
        
        <c:if test="${not empty error}">
            <p style="color: #d9534f; font-size: 13px; margin-bottom: 15px;"><i class="fas fa-exclamation-circle"></i> ${error}</p>
        </c:if>
        <c:if test="${param.success == 'true'}">
            <p style="color: #5cb85c; font-size: 13px; margin-bottom: 15px;"><i class="fas fa-check-circle"></i> Registration Successful! Please Login.</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group">
                <label>Email Address</label>
                <div style="position: relative;">
                    <i class="far fa-envelope" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="email" name="email" placeholder="Enter your email" style="padding-left: 40px;" required>
                </div>
            </div>
            <div class="input-group">
                <label>Password</label>
                <div style="position: relative;">
                    <i class="fas fa-lock" style="position: absolute; left: 15px; top: 15px; color: #888;"></i>
                    <input type="password" name="password" placeholder="Enter your password" style="padding-left: 40px;" required>
                </div>
            </div>
            <button type="submit" class="auth-btn">Sign In</button>
        </form>
        <p class="auth-footer">Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
    </div>
</body>
</html>