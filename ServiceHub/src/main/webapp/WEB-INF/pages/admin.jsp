<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard | ServiceHub</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>

<style>
:root {
    --brown: #49301E;
    --green: #2C362B;
    --beige: #F8F2E4;
    --text-gray: #666666;
    --white: #ffffff;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background-color: var(--beige);
    color: var(--brown);
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.2rem 5%;
    background-color: var(--brown);
}

.logo {
    font-weight: 800;
    font-size: 1.5rem;
    color: var(--white);
    display: flex;
    align-items: center;
    gap: 8px;
}

.nav-links {
    list-style: none;
    display: flex;
    gap: 2rem;
}x

.nav-links a {
    text-decoration: none;
    color: var(--white);
}

.nav-right {
    display: flex;
    align-items: center;
    gap: 15px;
    color: var(--white);
}

.logout-btn {
    background: var(--green);
    color: var(--white);
    padding: 6px 14px;
    border-radius: 6px;
    text-decoration: none;
}

/* FOOTER */
footer {
    background: var(--brown);
    color: var(--white);
    padding: 4rem 10% 2rem;
    margin-top: 40px;
}

.footer-grid {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    gap: 3rem;
    border-bottom: 1px solid rgba(255,255,255,0.15);
    padding-bottom: 2rem;
    margin-bottom: 2rem;
}

.footer-grid h3 {
    color: var(--beige);
    margin-bottom: 1rem;
}

.footer-grid p {
    color: rgba(248, 242, 228, 0.75);
}

.copyright {
    text-align: center;
    color: rgba(248, 242, 228, 0.6);
}
</style>

<body>

<jsp:include page="/components/header.jsp" />

<!-- MAIN -->
<div class="container">

    <div class="header">
        <h1>Admin Dashboard</h1>
        <p>Manage your home service platform</p>
    </div>

    <!-- STATS -->
    <div class="stats-grid">

        <div class="card brown">
            <i class="fas fa-wrench"></i>
            <h2>${services}</h2>
            <p>Total Services</p>
        </div>

        <div class="card green">
            <i class="fas fa-users"></i>
            <h2>${technicians}</h2>
            <p>Technician</p>
        </div>

        <div class="card beige">
            <i class="fas fa-calendar"></i>
            <h2>${bookings}</h2>
            <p>Total Bookings</p>
        </div>

        <div class="card brown">
            <i class="fas fa-chart-line"></i>
            <h2>${pending}</h2>
            <p>Pending Bookings</p>
        </div>

    </div>

    <!-- CHART -->
    <div class="chart-grid">
        <div class="chart-box">
            <h3>Services by Category</h3>
        </div>

        <div class="chart-box">
            <h3>Booking Status Distribution</h3>
        </div>
    </div>

    <!-- ACTIONS -->
    <div class="quick-actions">
        <h3>Quick Actions</h3>

        <div class="action-grid">

            <a href="${pageContext.request.contextPath}/managetechnician" class="action-item">
                <i class="fas fa-users"></i>
                <p>Manage Technician</p>
            </a>

            <a href="${pageContext.request.contextPath}/managebooking" class="action-item">
                <i class="fas fa-calendar"></i>
                <p>Manage Bookings</p>
            </a>

            <a href="${pageContext.request.contextPath}/manageuser" class="action-item">
                <i class="fas fa-user"></i>
                <p>Manage Users</p>
            </a>

        </div>
    </div>

</div>

<!-- FOOTER -->
<footer>
    <div class="footer-grid">

        <div>
            <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
            <p>Your trusted platform for quality home services.</p>
        </div>

        <div>
            <h3>Quick Links</h3>
            <p>Services</p>
            <p>About Us</p>
            <p>Contact</p>
        </div>

        <div>
            <h3>Contact Info</h3>
            <p>info@ServiceHub.com</p>
            <p>+977 9841234567</p>
            <p>Kathmandu, Nepal</p>
        </div>

    </div>

    <div class="copyright">
        © 2026 ServiceHub. All rights reserved.
    </div>
</footer>

</body>
</html>