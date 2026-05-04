<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | ServiceHub</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin.css">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/admin" class="logo">
        <i class="fas fa-wrench"></i> ServiceHub Admin
    </a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/admin" class="active">Dashboard</a></li>
        
         <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
        
    </ul>
    <div class="nav-right">
        <span class="welcome-text">
            <i class="fas fa-user-shield"></i> ${sessionScope.fullName}
        </span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</nav>

<div class="admin-container">
    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h3><i class="fas fa-filter"></i> Filters</h3>
        <ul class="filter-list">
            <li>
                <a href="${pageContext.request.contextPath}/admin?filter=all" class="${currentFilter == 'all' ? 'active' : ''}">
                    All Bookings <span class="count">${statusCounts.all}</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin?filter=pending" class="${currentFilter == 'pending' ? 'active' : ''}">
                    Pending <span class="count">${statusCounts.pending}</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin?filter=confirmed" class="${currentFilter == 'confirmed' ? 'active' : ''}">
                    Confirmed <span class="count">${statusCounts.confirmed}</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin?filter=completed" class="${currentFilter == 'completed' ? 'active' : ''}">
                    Completed <span class="count">${statusCounts.completed}</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin?filter=cancelled" class="${currentFilter == 'cancelled' ? 'active' : ''}">
                    Cancelled <span class="count">${statusCounts.cancelled}</span>
                </a>
            </li>
        </ul>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main-content">
        <div class="header">
            <h1>Admin Dashboard</h1>
            <p>Manage bookings, services, and technicians</p>
        </div>

        <!-- STATISTICS CARDS -->
        <div class="stats-grid">
            <div class="stat-card">
                <i class="fas fa-wrench"></i>
                <h2>${totalServices}</h2>
                <p>Total Services</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-users"></i>
                <h2>${totalTechnicians}</h2>
                <p>Technicians</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-calendar-check"></i>
                <h2>${totalBookings}</h2>
                <p>Total Bookings</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-clock"></i>
                <h2>${pendingBookings}</h2>
                <p>Pending Bookings</p>
            </div>
        </div>

        <!-- BOOKINGS SECTION -->
        <div class="bookings-section">
            <h3 class="section-title">
                <i class="fas fa-list"></i> Booking List
            </h3>

            <c:choose>
                <c:when test="${not empty bookings}">
                    <div class="bookings-grid">
                        <c:forEach items="${bookings}" var="booking">
                            <div class="booking-card">
                                <div class="booking-header">
                                    <span class="booking-title">
                                        <i class="fas fa-tools"></i> ${booking.serviceName}
                                    </span>
                                    <span class="booking-status status-${booking.status}">
                                        <i class="fas ${booking.status == 'pending' ? 'fa-clock' : (booking.status == 'confirmed' ? 'fa-check-circle' : (booking.status == 'completed' ? 'fa-check-double' : 'fa-times-circle'))}"></i>
                                        ${booking.status}
                                    </span>
                                </div>
                                <div class="booking-body">
                                    <div class="booking-details">
                                        <div class="detail-item">
                                            <i class="fas fa-user"></i>
                                            <span><strong>Customer:</strong> ${booking.customerName}</span>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fas fa-phone"></i>
                                            <span><strong>Phone:</strong> ${booking.customerPhone}</span>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fas fa-calendar"></i>
                                            <span><strong>Date:</strong> ${booking.preferredDate}</span>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fas fa-clock"></i>
                                            <span><strong>Time:</strong> ${booking.preferredTime}</span>
                                        </div>
                                        <div class="detail-item">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span><strong>Address:</strong> ${booking.serviceAddress}</span>
                                        </div>
                                        <c:if test="${not empty booking.additionalNotes}">
                                            <div class="detail-item">
                                                <i class="fas fa-sticky-note"></i>
                                                <span><strong>Notes:</strong> ${booking.additionalNotes}</span>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="booking-footer">
                                        <span class="booking-price">
                                            <i class="fas fa-rupee-sign"></i> ${booking.servicePrice}
                                        </span>
                                        <div class="action-buttons">
                                            <c:choose>
                                                <c:when test="${booking.status == 'pending'}">
                                                    <button onclick="updateStatus(${booking.bookingId}, 'confirmed')" class="btn-confirm">
                                                        <i class="fas fa-check"></i> Confirm
                                                    </button>
                                                    <button onclick="updateStatus(${booking.bookingId}, 'cancelled')" class="btn-cancel">
                                                        <i class="fas fa-times"></i> Cancel
                                                    </button>
                                                </c:when>
                                                <c:when test="${booking.status == 'confirmed'}">
                                                    <button onclick="updateStatus(${booking.bookingId}, 'completed')" class="btn-complete">
                                                        <i class="fas fa-check-double"></i> Complete
                                                    </button>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-inbox empty-icon"></i>
                        <h3>No Bookings Found</h3>
                        <p>There are no bookings in this category.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<!-- STATUS UPDATE MODAL -->
<div id="statusModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="modalTitle">Update Booking Status</h3>
        </div>
        <div class="modal-body">
            <p id="modalMessage">Are you sure you want to update this booking status?</p>
        </div>
        <div class="modal-actions">
            <button class="modal-btn-cancel" onclick="closeModal()">Cancel</button>
            <button class="modal-btn-confirm" id="confirmUpdateBtn">Confirm</button>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer>
    <div class="footer-grid">
        <div>
            <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
            <p>Your trusted platform for quality home services. Book professional service providers with ease.</p>
        </div>
        <div>
            <h3>Quick Links</h3>
            <p>Services</p>
            <p>About Us</p>
            <p>Contact</p>
        </div>
        <div>
            <h3>Contact Info</h3>
            <p>info@servicehub.com</p>
            <p>+977 9841234567</p>
            <p>Kathmandu, Nepal</p>
        </div>
    </div>
    <div class="copyright">
        &copy; 2026 ServiceHub. All rights reserved.
    </div>
</footer>

<script>
    let currentBookingId = null;
    let newStatus = null;

    function updateStatus(bookingId, status) {
        currentBookingId = bookingId;
        newStatus = status;
        
        let title = "", message = "";
        
        if (status === 'confirmed') {
            title = "Confirm Booking";
            message = "Are you sure you want to confirm this booking?";
        } else if (status === 'cancelled') {
            title = "Cancel Booking";
            message = "Are you sure you want to cancel this booking?";
        } else if (status === 'completed') {
            title = "Complete Booking";
            message = "Are you sure you want to mark this booking as completed?";
        }
        
        document.getElementById('modalTitle').textContent = title;
        document.getElementById('modalMessage').textContent = message;
        document.getElementById('statusModal').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('statusModal').style.display = 'none';
        currentBookingId = null;
        newStatus = null;
    }

    document.getElementById('confirmUpdateBtn').addEventListener('click', function() {
        if (currentBookingId && newStatus) {
            fetch('${pageContext.request.contextPath}/admin', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=updateStatus&bookingId=' + currentBookingId + '&status=' + newStatus
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showToast(data.message);
                    setTimeout(() => location.reload(), 1500);
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred. Please try again.');
            });
        }
        closeModal();
    });

    function showToast(message) {
        const toast = document.createElement('div');
        toast.className = 'toast-message';
        toast.innerHTML = '<i class="fas fa-check-circle"></i> ' + message;
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 3000);
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById('statusModal');
        if (event.target === modal) closeModal();
    }
</script>

</body>
</html>