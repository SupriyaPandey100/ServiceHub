<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | My Bookings</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --brown: #49301E; --green: #2C362B; --beige: #F8F2E4; --white: #ffffff; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }
        body { background-color: var(--beige); color: var(--brown); }
        .navbar { background: var(--brown); padding: 1rem 5%; display: flex; justify-content: space-between; align-items: center; color: white; }
        .logo { font-weight: 700; font-size: 1.4rem; display: flex; align-items: center; gap: 10px; color: white; text-decoration: none; }
        .nav-links { list-style: none; display: flex; gap: 25px; }
        .nav-links a { color: rgba(255,255,255,0.8); text-decoration: none; }
        .nav-links a.active { color: white; border-bottom: 2px solid white; padding-bottom: 5px; }
        .nav-right { display: flex; align-items: center; gap: 20px; }
        .logout-btn { background: var(--green); color: white; padding: 8px 18px; border-radius: 6px; text-decoration: none; display: flex; align-items: center; gap: 8px; }
        .container { padding: 40px 5%; max-width: 1200px; margin: 0 auto; }
        .header h1 { font-size: 2rem; font-weight: 700; }
        .header p { color: #666; margin-top: 5px; }
        .tabs { display: flex; gap: 10px; margin: 30px 0; flex-wrap: wrap; }
        .tab { padding: 10px 20px; border-radius: 8px; border: 1px solid #ddd; background: white; text-decoration: none; color: var(--brown); font-weight: 500; transition: all 0.3s; }
        .tab:hover { background: var(--brown); color: white; border-color: var(--brown); }
        .tab.active { background: var(--brown); color: white; border-color: var(--brown); }
        .tab .count { background: rgba(0,0,0,0.1); padding: 2px 6px; border-radius: 12px; font-size: 0.8rem; margin-left: 5px; }
        .booking-card { background: white; border-radius: 12px; border: 1px solid #eee; margin-bottom: 20px; overflow: hidden; }
        .booking-header { background: var(--brown); color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; }
        .booking-status { padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .status-pending { background: #f59e0b; }
        .status-confirmed { background: #10b981; }
        .status-completed { background: #3b82f6; }
        .status-cancelled { background: #ef4444; }
        .booking-body { padding: 20px; }
        .booking-details { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin-bottom: 20px; }
        .detail-item { display: flex; align-items: center; gap: 10px; color: #666; font-size: 0.9rem; }
        .detail-item i { width: 20px; color: var(--brown); }
        .booking-footer { display: flex; justify-content: space-between; align-items: center; padding-top: 15px; border-top: 1px solid #eee; flex-wrap: wrap; }
        .booking-price { font-size: 1.3rem; font-weight: 700; color: var(--brown); }
        .btn-cancel { background: #ef4444; color: white; padding: 8px 16px; border-radius: 6px; border: none; cursor: pointer; }
        .empty-state { background: white; border-radius: 12px; padding: 80px 20px; text-align: center; }
        .empty-icon { font-size: 4rem; color: var(--brown); margin-bottom: 20px; opacity: 0.5; }
        .btn-browse { background: var(--brown); color: white; padding: 12px 30px; border-radius: 6px; text-decoration: none; display: inline-block; margin-top: 20px; }
        footer { background: var(--brown); color: white; padding: 60px 5% 30px; margin-top: 60px; }
        .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 40px; }
        @media (max-width: 768px) { .footer-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="logo"><i class="fas fa-wrench"></i> ServiceHub</a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
        <li><a href="#" class="active">Dashboard</a></li>
    </ul>
    <div class="nav-right">
        <span><i class="far fa-user"></i> ${sessionScope.fullName}</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<div class="container">
    <div class="header">
        <h1>My Bookings</h1>
        <p>Track and manage your service bookings</p>
    </div>
    
    <div class="tabs">
        <a href="${pageContext.request.contextPath}/User?filter=all" class="tab ${param.filter == 'all' or empty param.filter ? 'active' : ''}">All <span class="count">(${statusCounts.all})</span></a>
        <a href="${pageContext.request.contextPath}/User?filter=pending" class="tab ${param.filter == 'pending' ? 'active' : ''}">Pending <span class="count">(${statusCounts.pending})</span></a>
        <a href="${pageContext.request.contextPath}/User?filter=confirmed" class="tab ${param.filter == 'confirmed' ? 'active' : ''}">Confirmed <span class="count">(${statusCounts.confirmed})</span></a>
        <a href="${pageContext.request.contextPath}/User?filter=completed" class="tab ${param.filter == 'completed' ? 'active' : ''}">Completed <span class="count">(${statusCounts.completed})</span></a>
        <a href="${pageContext.request.contextPath}/User?filter=cancelled" class="tab ${param.filter == 'cancelled' ? 'active' : ''}">Cancelled <span class="count">(${statusCounts.cancelled})</span></a>
    </div>
    
    <c:choose>
        <c:when test="${not empty bookings}">
            <c:forEach items="${bookings}" var="booking">
                <div class="booking-card">
                    <div class="booking-header">
                        <span><i class="fas fa-tools"></i> ${booking.serviceName}</span>
                        <span class="booking-status status-${booking.status}">${booking.status.toUpperCase()}</span>
                    </div>
                    <div class="booking-body">
                        <div class="booking-details">
                            <div class="detail-item"><i class="fas fa-calendar"></i> <span><strong>Date:</strong> ${booking.preferredDate}</span></div>
                            <div class="detail-item"><i class="fas fa-clock"></i> <span><strong>Time:</strong> ${booking.preferredTime}</span></div>
                            <div class="detail-item"><i class="fas fa-user"></i> <span><strong>Name:</strong> ${booking.customerName}</span></div>
                            <div class="detail-item"><i class="fas fa-phone"></i> <span><strong>Phone:</strong> ${booking.customerPhone}</span></div>
                            <div class="detail-item"><i class="fas fa-map-marker-alt"></i> <span><strong>Address:</strong> ${booking.serviceAddress}</span></div>
                            <%--<c:if test="${not empty booking.technicianName}">
                                <div class="detail-item"><i class="fas fa-user-cog"></i> <span><strong>Technician:</strong> ${booking.technicianName}</span></div>
                            </c:if>--%>
                        </div>
                        <div class="booking-footer">
                            <span class="booking-price">NPR ${booking.servicePrice}</span>
                            <c:if test="${booking.status == 'pending'}">
                                <button onclick="cancelBooking(${booking.bookingId})" class="btn-cancel"><i class="fas fa-times"></i> Cancel</button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="far fa-calendar-alt empty-icon"></i>
                <h3>No bookings found</h3>
                <p>You haven't booked any services yet.</p>
                <a href="${pageContext.request.contextPath}/services" class="btn-browse"><i class="fas fa-search"></i> Browse Services</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer>
    <div class="footer-grid">
        <div><h3><i class="fas fa-wrench"></i> ServiceHub</h3><p>Your trusted platform for quality home services.</p></div>
        <div><h3>Quick Links</h3><p>Services</p><p>About Us</p><p>Contact</p></div>
        <div><h3>Contact Info</h3><p>info@servicehub.com</p><p>+977 9841234567</p><p>Kathmandu, Nepal</p></div>
    </div>
    <div class="copyright" style="text-align: center; padding-top: 30px;">&copy; 2026 ServiceHub. All rights reserved.</div>
</footer>

<script>
function cancelBooking(bookingId) {
    if(confirm('Are you sure you want to cancel this booking?')) {
        fetch('${pageContext.request.contextPath}/cancel-booking', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'bookingId=' + bookingId
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) { alert(data.message); location.reload(); }
            else { alert(data.message); }
        })
        .catch(error => alert('Error cancelling booking'));
    }
}
</script>
</body>
</html>