<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ServiceHub | Login</title>
    
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>

<body>

    <!-- ===== NAVBAR ===== -->
    <nav class="navbar">
        <div class="container">
            <div class="nav-wrapper">
                
                <div class="logo">🔧 ServiceHub</div>

                <div class="nav-links">
                    <a href="${pageContext.request.contextPath}/home">Home</a>
                    <a href="${pageContext.request.contextPath}/services">Services</a>
                    <a href="${pageContext.request.contextPath}/about">About</a>
                    
                 
                    <a href="${pageContext.request.contextPath}/register" class="register-btn">Register</a>
                </div>

            </div>
        </div>
    </nav>

    <!-- ===== MAIN CONTENT ===== -->
    <main class="main-content">
        <div class="container">
            <div class="content-container">

                <div class="auth-card">
                    
                    <h2 class="auth-title">Welcome Back</h2>
                    <p class="auth-subtitle">Sign in to your account</p>

                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="alert-error">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>

                    <!-- Success Message -->
                    <c:if test="${not empty sessionScope.registerSuccess}">
                        <div class="alert-success">
                            <i class="fas fa-check-circle"></i> ${sessionScope.registerSuccess}
                        </div>
                        <% session.removeAttribute("registerSuccess"); %>
                    </c:if>

                    <!-- Login Form -->
                    <form action="${pageContext.request.contextPath}/login" method="post">

                        <div class="input-group">
                            <label>Email Address</label>
                            <div class="input-wrapper">
                                <i class="far fa-envelope"></i>
                                <input type="email" name="email" placeholder="Enter your email" required>
                            </div>
                        </div>

                        <div class="input-group">
                            <label>Password</label>
                            <div class="input-wrapper">
                                <i class="fas fa-lock"></i>
                                <input type="password" name="password" placeholder="Enter your password" required>
                            </div>
                        </div>

                        <button type="submit" class="auth-btn">Sign In</button>
                    </form>

                    <p class="auth-footer">
                        Don't have an account?
                        <a href="${pageContext.request.contextPath}/register">Register here</a>
                    </p>

                </div>

            </div>
        </div>
    </main>

    <!-- ===== FOOTER ===== -->
    <footer class="footer">
        <div class="container">
            <div class="footer-wrapper">

                <div class="footer-content">

                    <div class="footer-section">
                        <h3>ServiceHub</h3>
                        <p>Your trusted platform for quality home services. Book professionals with ease.</p>
                    </div>

                    <div class="footer-section">
                        <h3>Quick Links</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                            <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                        </ul>
                    </div>

                    <div class="footer-section">
                        <h3>Contact Info</h3>
                        <ul class="contact-info">
                            <li><i class="far fa-envelope"></i> info@ServiceHub.com</li>
                            <li><i class="fas fa-phone-alt"></i> +977 9841234567</li>
                            <li><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</li>
                        </ul>
                    </div>

                </div>

                <div class="footer-bottom">
                    <p>&copy; 2026 ServiceHub. All rights reserved.</p>
                </div>

            </div>
        </div>
    </footer>

</body>
</html>