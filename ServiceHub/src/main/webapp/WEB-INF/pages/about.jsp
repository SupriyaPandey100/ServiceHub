<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About ServiceHub</title>
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Main CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
</head>
<body>

    <!-- NAVBAR -->
   <!-- NAVBAR -->
<nav class="navbar">
    <div class="logo">🔧 ServiceHub</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/services">Services</a>
        <a href="${pageContext.request.contextPath}/about">About</a>
         <a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="register-btn">Register</a>
    </div>
</nav>
    <!-- HERO SECTION -->
    <header class="hero">
        <div class="hero-overlay">
            <div class="hero-icon"><i class="fas fa-wrench"></i></div>
            <h1>About ServiceHub</h1>
            <p>Your trusted platform for connecting with professional home service providers</p>
        </div>
    </header>

    <!-- MISSION SECTION (Overlapping) -->
    <section class="mission-container">
        <div class="mission-box">
            <h2>Our Mission</h2>
            <p>
                HomeService was founded with a simple mission: to make finding and booking reliable 
                home service professionals as easy as possible. We understand that your home is your 
                most valuable asset, and you deserve the best care for it.
            </p>
            <p>
                We carefully vet all our service providers to ensure they meet our high standards of 
                professionalism, quality, and reliability. Our platform brings together skilled professionals 
                and homeowners, creating a seamless experience for all your home service needs.
            </p>
        </div>
    </section>

    <!-- STATS SECTION -->
    <section class="stats">
        <div class="stat-item">
            <h2>10,000+</h2>
            <p>Happy Customers</p>
        </div>
        <div class="stat-item">
            <h2>500+</h2>
            <p>Verified Professionals</p>
        </div>
        <div class="stat-item">
            <h2>50+</h2>
            <p>Service Categories</p>
        </div>
        <div class="stat-item">
            <h2>4.9/5</h2>
            <p>Average Rating</p>
        </div>
    </section>

    <!-- JOIN BOX -->
    <section class="join-container">
       <div class="join-box">
    <h2>Join Thousands of Satisfied Customers</h2>
    <p>Experience the convenience of professional home services at your fingertips</p>

    <!-- Change: Added ?action=browse to the URL -->
    <form action="${pageContext.request.contextPath}/about" method="get">
        <button type="submit" name="action" value="browse" class="btn-browse">
            Browse Services
        </button>
    </form>
</div>
    </section>

    <!-- CORE VALUES -->
    <section class="values-section">
        <h2 class="section-title">Our Core Values</h2>
        <div class="values-grid">
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-check-circle"></i></div>
                <h3>Quality Service</h3>
                <p>We ensure all our service providers deliver top-quality work with professional standards.</p>
            </div>
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-shield-alt"></i></div>
                <h3>Trust & Safety</h3>
                <p>All professionals are verified, background-checked, and insured for your peace of mind.</p>
            </div>
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-users"></i></div>
                <h3>Customer First</h3>
                <p>Your satisfaction is our priority. We're committed to providing excellent customer service.</p>
            </div>
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-medal"></i></div>
                <h3>Excellence</h3>
                <p>We strive for excellence in every service, ensuring consistent quality and reliability.</p>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <footer class="footer">
        <div class="footer-grid">
            <div class="footer-about">
                <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
                <p>Your trusted platform for quality home services. Book professional service providers with ease.</p>
            </div>
            <div class="footer-links">
                <h4>Quick Links</h4>
                <a href="#">Services</a>
                <a href="#">About Us</a>
                <a href="#">Contact</a>
            </div>
            <div class="footer-contact">
                <h4>Contact Info</h4>
                <p>Email: info@homeservice.com</p>
                <p>Phone: +977 9841234567</p>
                <p>Address: Kathmandu, Nepal</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2026 HomeService. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>