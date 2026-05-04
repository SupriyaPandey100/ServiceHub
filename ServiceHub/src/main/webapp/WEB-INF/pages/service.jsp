<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>ServiceHub | Home Services</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/service.css">
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
        <%-- Check if user is logged in --%>
        <c:choose>
            <c:when test="${sessionScope.isLoggedIn == true and not empty sessionScope.userId}">
                <span class="welcome-text">
                    <i class="fas fa-user-circle"></i> 
                    ${sessionScope.fullName}
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

<!-- HERO SECTION -->
<section class="services-hero">
    <div class="container">
        <h1>Our Services</h1>
        <p>Browse through our wide range of professional home services</p>
        
        <form action="${pageContext.request.contextPath}/services" method="get" class="search-form">
            <div class="search-container">
                <i class="fas fa-search"></i>
                <input type="text" name="search" placeholder="Search for services..." value="${searchQuery}">
            </div>
        </form>
        
        <div class="filter-tabs">
            <form action="${pageContext.request.contextPath}/services" method="get" id="filterForm">
                <input type="hidden" name="search" value="${searchQuery}">
                <button type="submit" name="category" value="all" class="filter-btn ${selectedCategory == 'all' ? 'active' : ''}">All</button>
                <button type="submit" name="category" value="Plumbing" class="filter-btn ${selectedCategory == 'Plumbing' ? 'active' : ''}">Plumbing</button>
                <button type="submit" name="category" value="Electrical" class="filter-btn ${selectedCategory == 'Electrical' ? 'active' : ''}">Electrical</button>
                <button type="submit" name="category" value="Painting" class="filter-btn ${selectedCategory == 'Painting' ? 'active' : ''}">Painting</button>
                <button type="submit" name="category" value="Cleaning" class="filter-btn ${selectedCategory == 'Cleaning' ? 'active' : ''}">Cleaning</button>
                <button type="submit" name="category" value="AC Repair" class="filter-btn ${selectedCategory == 'AC Repair' ? 'active' : ''}">AC Repair</button>
                <button type="submit" name="category" value="Carpentry" class="filter-btn ${selectedCategory == 'Carpentry' ? 'active' : ''}">Carpentry</button>
            </form>
        </div>
        <p class="results-count">Found ${services.size()} service(s)</p>
    </div>
</section>

<!-- SERVICES GRID -->
<section class="services-section">
    <div class="grid">
        <c:forEach items="${services}" var="service">
            <div class="service-card">
                <div class="card-img" style="background-image:url('${pageContext.request.contextPath}/${service.imageUrl}')"></div>
                <div class="card-content">
                    <span class="badge">${service.category}</span>
                    <h3>${service.name}</h3>
                    <p>${service.description}</p>
                    <div class="card-meta">
                        <span>⭐ ${service.rating} (${service.reviews})</span>
                        <span>⏱ ${service.duration}</span>
                    </div>
                    <div class="card-footer">
                        <span class="price">NPR ${service.price}</span>
                        <c:choose>
                            <c:when test="${sessionScope.isLoggedIn != true or empty sessionScope.userId}">
                                <form action="${pageContext.request.contextPath}/services" method="get" class="book-form">
                                    <input type="hidden" name="showLoginPopup" value="true">
                                    <input type="hidden" name="serviceName" value="${service.name}">
                                    <input type="hidden" name="servicePrice" value="${service.price}">
                                    <input type="hidden" name="serviceCategory" value="${service.category}">
                                    <button type="submit" class="book-btn">Book</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="book-btn" onclick="openBookingModal('${service.name}', '${service.price}', '${service.category}')">Book</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty services}">
            <div class="no-results">
                <i class="fas fa-search"></i>
                <h3>No services found</h3>
                <p>Try adjusting your search or filter criteria</p>
                <a href="${pageContext.request.contextPath}/services" class="reset-btn">Reset Filters</a>
            </div>
        </c:if>
    </div>
</section>

<!-- LOGIN POPUP MODAL -->
<c:if test="${param.showLoginPopup == 'true'}">
    <div id="loginPopupModal" class="modal" style="display: flex;">
        <div class="modal-content popup-modal">
            <div class="modal-header">
                <h2><i class="fas fa-exclamation-circle"></i> Login Required</h2>
                <a href="${pageContext.request.contextPath}/services" class="close-modal-link">&times;</a>
            </div>
            <div class="modal-body">
                <div class="login-warning">
                    <i class="fas fa-lock warning-icon"></i>
                    <p>Please login first to book this service</p>
                </div>
                <div class="service-info-preview">
                    <h4>Service Details:</h4>
                    <p><strong>${param.serviceName}</strong></p>
                    <p>Category: ${param.serviceCategory}</p>
                    <p>Price: NPR ${param.servicePrice}</p>
                </div>
                <div class="popup-actions">
                    <a href="${pageContext.request.contextPath}/services" class="cancel-popup-btn">Cancel</a>
                    <a href="${pageContext.request.contextPath}/login?redirect=booking&serviceName=${param.serviceName}&servicePrice=${param.servicePrice}&serviceCategory=${param.serviceCategory}" class="login-popup-btn">Login Now</a>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- BOOKING MODAL -->
<div id="bookingModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2><i class="fas fa-calendar-check"></i> Book Service</h2>
            <button class="close-modal" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <div class="service-detail">
                <h3 id="modalServiceName">Service Name</h3>
                <p id="modalServiceCategory">Category</p>
                <span class="service-price" id="modalServicePrice">NPR 0</span>
            </div>
            <form id="bookingForm" action="${pageContext.request.contextPath}/booking" method="post">
                <input type="hidden" name="serviceName" id="hiddenServiceName">
                <input type="hidden" name="servicePrice" id="hiddenServicePrice">
                <input type="hidden" name="serviceCategory" id="hiddenServiceCategory">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Customer Name</label>
                    <input type="text" name="customerName" id="customerName" value="${sessionScope.fullName}" required>
                </div>
                <div class="form-group">
                    <label><i class="fas fa-phone"></i> Phone Number</label>
                    <input type="tel" name="customerPhone" id="customerPhone" value="${sessionScope.phone}" required>
                </div>
                <div class="row-2">
                    <div class="form-group">
                        <label><i class="fas fa-calendar"></i> Preferred Date</label>
                        <input type="date" name="preferredDate" id="preferredDate" required>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-clock"></i> Preferred Time</label>
                        <select name="preferredTime" id="preferredTime" required>
                            <option value="">Select Time</option>
                            <option value="09:00 AM">09:00 AM - 11:00 AM</option>
                            <option value="11:00 AM">11:00 AM - 01:00 PM</option>
                            <option value="01:00 PM">01:00 PM - 03:00 PM</option>
                            <option value="03:00 PM">03:00 PM - 05:00 PM</option>
                            <option value="05:00 PM">05:00 PM - 07:00 PM</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label><i class="fas fa-map-marker-alt"></i> Service Address</label>
                    <textarea name="serviceAddress" id="serviceAddress" required>${sessionScope.address}</textarea>
                </div>
                <div class="form-group">
                    <label><i class="fas fa-paperclip"></i> Additional Notes</label>
                    <textarea name="additionalNotes" id="additionalNotes" placeholder="Any special requirements..."></textarea>
                </div>
                <div class="modal-actions">
                    <button type="button" class="cancel-btn" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="confirm-btn">Confirm Booking</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function openBookingModal(serviceName, servicePrice, serviceCategory) {
    document.getElementById('modalServiceName').textContent = serviceName;
    document.getElementById('modalServiceCategory').textContent = serviceCategory;
    document.getElementById('modalServicePrice').innerHTML = 'NPR ' + servicePrice;
    document.getElementById('hiddenServiceName').value = serviceName;
    document.getElementById('hiddenServicePrice').value = servicePrice;
    document.getElementById('hiddenServiceCategory').value = serviceCategory;
    document.getElementById('bookingModal').style.display = 'flex';
}
function closeModal() {
    document.getElementById('bookingModal').style.display = 'none';
}
window.onclick = function(event) {
    if (event.target === document.getElementById('bookingModal')) closeModal();
}
document.getElementById('bookingForm').addEventListener('submit', function(e) {
    if (!document.getElementById('customerName').value || !document.getElementById('customerPhone').value || 
        !document.getElementById('preferredDate').value || !document.getElementById('preferredTime').value || 
        !document.getElementById('serviceAddress').value) {
        e.preventDefault();
        alert('Please fill in all required fields.');
    }
});
</script>

<!-- FOOTER -->
<footer class="main-footer">
    <div class="footer-grid">
        <div class="footer-brand">
            <div class="logo"><i class="fas fa-wrench"></i> ServiceHub</div>
            <p>Your trusted home service platform for quality and reliable services.</p>
        </div>
        <div class="footer-links">
            <h4>Quick Links</h4>
            <p><a href="${pageContext.request.contextPath}/home">Home</a></p>
            <p><a href="${pageContext.request.contextPath}/services">Services</a></p>
            <p><a href="${pageContext.request.contextPath}/about">About Us</a></p>
        </div>
        <div class="footer-services">
            <h4>Services</h4>
            <p><a href="${pageContext.request.contextPath}/services?category=Plumbing">Plumbing</a></p>
            <p><a href="${pageContext.request.contextPath}/services?category=Electrical">Electrical</a></p>
            <p><a href="${pageContext.request.contextPath}/services?category=Cleaning">Cleaning</a></p>
        </div>
        <div class="footer-contact">
            <h4>Contact Info</h4>
            <p><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</p>
            <p><i class="fas fa-phone"></i> +977 9841234567</p>
            <p><i class="fas fa-envelope"></i> info@servicehub.com</p>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2026 ServiceHub. All rights reserved.</p>
    </div>
</footer>
</body>
</html>