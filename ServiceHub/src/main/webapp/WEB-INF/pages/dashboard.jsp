<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ServiceHub | Admin Dashboard</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shared.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo"><i class="fas fa-wrench"></i> ServiceHub</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/services">Services</a>
            <a href="#">About</a>
            <a href="#">Contact</a>
        </div>
        <div class="auth-links" style="display: flex; align-items: center; gap: 20px;">
            <i class="fas fa-search" style="color: white; cursor: pointer;"></i>
            <i class="far fa-bell" style="color: white; cursor: pointer;"></i>
            <span style="color: white;"><i class="far fa-user"></i> ${userSession.fullName}</span>
            <a href="${pageContext.request.contextPath}/login" class="nav-btn" style="text-decoration: none;"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="dashboard-header">
        <h1>Admin Dashboard</h1>
        <p>Manage your home service platform</p>
    </div>

    <div class="stats-grid">
        <div class="stat-card brown">
            <span><i class="fas fa-wrench"></i> Total Services</span>
            <h2>8</h2>
        </div>
        <div class="stat-card dark-green">
            <span><i class="fas fa-users-cog"></i> Technician</span>
            <h2>4</h2>
        </div>
        <div class="stat-card beige">
            <span><i class="far fa-calendar-alt"></i> Total Bookings</span>
            <h2>0</h2>
        </div>
        <div class="stat-card deep-brown">
            <span><i class="fas fa-chart-line"></i> Pending Bookings</span>
            <h2>0</h2>
        </div>
    </div>

    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; padding: 0 40px 30px;">
        <div style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.05);">
            <h3 style="color: #49301E; margin-bottom: 15px;">Services by Category</h3>
            <div style="height: 200px; background: #fafafa; border: 1px dashed #ccc; display: flex; align-items: flex-end; justify-content: space-around; padding: 10px;">
                <div style="width: 40px; height: 100%; background: #49301E;"></div>
                <div style="width: 40px; height: 100%; background: #49301E;"></div>
                <div style="width: 40px; height: 50%; background: #49301E;"></div>
                <div style="width: 40px; height: 50%; background: #49301E;"></div>
            </div>
        </div>
        <div style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.05);">
            <h3 style="color: #49301E; margin-bottom: 15px;">Booking Status Distribution</h3>
            <div style="height: 200px; display: flex; align-items: center; justify-content: center; color: #888;">
                [Chart Area]
            </div>
        </div>
    </div>

    <div class="quick-actions">
        <h3>Quick Actions</h3>
        <div class="action-grid">
            <div class="action-item"><i class="fas fa-wrench" style="display:block; font-size: 24px; margin-bottom: 10px;"></i> Manage Services</div>
            <div class="action-item"><i class="fas fa-users" style="display:block; font-size: 24px; margin-bottom: 10px;"></i> Manage Technician</div>
            <div class="action-item"><i class="far fa-calendar-check" style="display:block; font-size: 24px; margin-bottom: 10px;"></i> Manage Bookings</div>
            <div class="action-item"><i class="fas fa-user-friends" style="display:block; font-size: 24px; margin-bottom: 10px;"></i> Manage Users</div>
        </div>
    </div>
</body>
</html>