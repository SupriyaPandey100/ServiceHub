<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ServiceHub | Home Services</title>

    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ho.css">
</head>
<body>

<!-- HEADER -->
<nav class="navbar">
    <div class="logo">
        <i class="fas fa-wrench"></i> ServiceHub
    </div>
    
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
    </ul>
    
    <div class="nav-right">
        <c:choose>
            <c:when test="${sessionScope.isLoggedIn == true}">
                <span class="welcome-text">
                    <i class="fas fa-user-circle"></i> 
                    ${sessionScope.fullName != null ? sessionScope.fullName : sessionScope.username}
                </span>
                <a href="${pageContext.request.contextPath}/User" class="User-btn">
                    <i class="fas fa-tachometer-alt"></i> User Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i> Login
                </a>
                <a href="${pageContext.request.contextPath}/register" class="register-btn">
                    <i class="fas fa-user-plus"></i> Register
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<main>
    <section class="hero">
        <h1>Professional Home Services at Your Doorstep</h1>
        <p>Book trusted professionals for plumbing, electrical, cleaning, and more. Quick, reliable, and affordable services.</p>
        <div class="hero-btns">
            <a href="${pageContext.request.contextPath}/services" class="btn btn-beige">Services</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-beige">Get Started</a>
        </div>
    </section>

    <section class="services-section">
        <div class="section-header">
            <h2>Our Services</h2>
            <p>Professional services for all your home needs</p>
        </div>
        <div class="grid">
            <div class="service-card">
                <i class="fas fa-tools"></i>
                <h3>Plumbing</h3>
                <p>Expert plumbing services for all your needs including leaks, clogs, and pipes.</p>
                <a href="#">Learn More →</a>
            </div>
            <div class="service-card">
                <i class="fas fa-bolt"></i>
                <h3>Electrical</h3>
                <p>Licensed electricians for safe installations, wiring, and appliance repair.</p>
                <a href="#">Learn More →</a>
            </div>
            <div class="service-card">
                <i class="fas fa-paint-roller"></i>
                <h3>Painting</h3>
                <p>Professional interior and exterior painting and decoration services.</p>
                <a href="#">Learn More →</a>
            </div>
            <div class="service-card">
                <i class="fas fa-broom"></i>
                <h3>Cleaning</h3>
                <p>Deep cleaning and maintenance services for your entire home.</p>
                <a href="#">Learn More →</a>
            </div>
            <div class="service-card">
                <i class="fas fa-fan"></i>
                <h3>AC Repair</h3>
                <p>Air conditioning servicing, repair, and regular maintenance.</p>
                <a href="#">Learn More →</a>
            </div>
            <div class="service-card">
                <i class="fas fa-hammer"></i>
                <h3>Carpentry</h3>
                <p>Custom furniture, woodwork solutions, and general carpentry repairs.</p>
                <a href="#">Learn More →</a>
            </div>
        </div>
    </section>

    <section class="why-us">
        <div class="section-header">
            <h2>Why Choose Us</h2>
            <p>Trusted by thousands of customers</p>
        </div>
        <div class="grid">
            <div class="feature-item">
                <i class="fas fa-user-check"></i>
                <h4>Verified Professionals</h4>
                <p>All service providers are verified and thoroughly background-checked.</p>
            </div>
            <div class="feature-item">
                <i class="fas fa-star"></i>
                <h4>Quality Service</h4>
                <p>Top-rated professionals with excellent customer reviews and ratings.</p>
            </div>
            <div class="feature-item">
                <i class="fas fa-th-large"></i>
                <h4>Wide Range</h4>
                <p>Access to various home service categories all in one single platform.</p>
            </div>
        </div>
    </section>

    <section class="cta-section">
        <div class="cta-box">
            <h2>Ready to Get Started?</h2>
            <p>Join thousands of satisfied customers who trust our platform.</p>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-beige">Create Account</a>
        </div>
    </section>
</main>

<footer>
    <div class="footer-grid">
        <div class="footer-col">
            <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
            <p style="max-width: 300px;">Your trusted platform for quality home services. Book professional service providers with ease.</p>
        </div>
        <div class="footer-col">
            <h3>Quick Links</h3>
            <a href="#">Services</a>
            <a href="#">About Us</a>
            <a href="#">Contact</a>
        </div>
        <div class="footer-col">
            <h3>Contact Info</h3>
            <p><i class="far fa-envelope"></i> info@servicehub.com</p>
            <p><i class="fas fa-phone-alt"></i> +977 9841234567</p>
            <p><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</p>
        </div>
    </div>
    <div class="copyright">
        &copy; 2026 ServiceHub. All rights reserved.
    </div>
</footer>

</body>
</html>