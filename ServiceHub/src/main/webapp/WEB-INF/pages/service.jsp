<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/service.css">
     
</head>
<body>

<!-- HEADER -->
<header class="main-header">
    <div class="header-flex">
        <div class="logo">
            <i class="fas fa-wrench"></i> ServiceHub
        </div>
   <nav class="navbar">
    <!--<div class="logo">🔧 ServiceHub</div>-->
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/services">Services</a>
        <a href="${pageContext.request.contextPath}/about">About</a>
         <a href="${pageContext.request.contextPath}/login" class="login-btn">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="register-btn">Register</a>
    </div>
</nav>
        <div class="header-auth">
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>
</header>

<!-- HERO with Filter Form -->
<section class="services-hero">
    <div class="container">
        <h1>Our Services</h1>
        <p>Browse through our wide range of professional home services</p>

        <!-- Search Form -->
        <form action="${pageContext.request.contextPath}/home" method="get" class="search-form">
            <div class="search-container">
                <i class="fas fa-search"></i>
                <input type="text" name="search" placeholder="Search for services..." 
                       value="${searchQuery}" id="searchInput">
            </div>
        </form>

        <!-- Filter Buttons -->
        <div class="filter-tabs">
            <form action="${pageContext.request.contextPath}/home" method="get" id="filterForm">
                <input type="hidden" name="search" value="${searchQuery}" id="filterSearchValue">
                
                <button type="submit" name="category" value="all" 
                        class="filter-btn ${selectedCategory == 'all' ? 'active' : ''}">All</button>
                <button type="submit" name="category" value="Plumbing" 
                        class="filter-btn ${selectedCategory == 'Plumbing' ? 'active' : ''}">Plumbing</button>
                <button type="submit" name="category" value="Electrical" 
                        class="filter-btn ${selectedCategory == 'Electrical' ? 'active' : ''}">Electrical</button>
                <button type="submit" name="category" value="Painting" 
                        class="filter-btn ${selectedCategory == 'Painting' ? 'active' : ''}">Painting</button>
                <button type="submit" name="category" value="Cleaning" 
                        class="filter-btn ${selectedCategory == 'Cleaning' ? 'active' : ''}">Cleaning</button>
                <button type="submit" name="category" value="AC Repair" 
                        class="filter-btn ${selectedCategory == 'AC Repair' ? 'active' : ''}">AC Repair</button>
                <button type="submit" name="category" value="Carpentry" 
                        class="filter-btn ${selectedCategory == 'Carpentry' ? 'active' : ''}">Carpentry</button>
            </form>
        </div>
        
        <!-- Results Count -->
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
                        <!-- Book button triggers modal -->
                        <button type="button" class="book-btn" 
                                onclick="openBookingModal('${service.name}', '${service.price}', '${service.category}')">
                            Book
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty services}">
            <div class="no-results">
                <i class="fas fa-search"></i>
                <h3>No services found</h3>
                <p>Try adjusting your search or filter criteria</p>
                <a href="${pageContext.request.contextPath}/home" class="reset-btn">Reset Filters</a>
            </div>
        </c:if>
    </div>
</section>

<!-- BOOKING MODAL POPUP -->
<div id="bookingModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2><i class="fas fa-calendar-check"></i> Book Service</h2>
            <button class="close-modal" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <div class="service-detail" id="modalServiceDetail">
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
                    <input type="text" name="customerName" id="customerName" placeholder="Enter your full name" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-phone"></i> Phone Number</label>
                    <input type="tel" name="customerPhone" id="customerPhone" placeholder="Enter your phone number" required>
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
                    <textarea name="serviceAddress" id="serviceAddress" placeholder="Enter your complete address (Street, City, Landmark)" required></textarea>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-paperclip"></i> Additional Notes</label>
                    <textarea name="additionalNotes" id="additionalNotes" placeholder="Any special requirements or instructions..."></textarea>
                </div>
                
                <div class="modal-actions">
                    <button type="button" class="cancel-btn" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="confirm-btn">Confirm Booking</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- SUCCESS TOAST MESSAGE -->
<div id="toastMessage" class="toast-message" style="display: none;">
    <i class="fas fa-check-circle"></i> <span id="toastText">Booking confirmed successfully!</span>
</div>

<script>
    // Set minimum date to today for date picker
    const today = new Date().toISOString().split('T')[0];
    if(document.getElementById('preferredDate')) {
        document.getElementById('preferredDate').min = today;
    }
    
    // Function to open booking modal
    function openBookingModal(serviceName, servicePrice, serviceCategory) {
        // Set modal content
        document.getElementById('modalServiceName').textContent = serviceName;
        document.getElementById('modalServiceCategory').textContent = serviceCategory;
        document.getElementById('modalServicePrice').innerHTML = 'NPR ' + servicePrice;
        
        // Set hidden form values
        document.getElementById('hiddenServiceName').value = serviceName;
        document.getElementById('hiddenServicePrice').value = servicePrice;
        document.getElementById('hiddenServiceCategory').value = serviceCategory;
        
        // Clear previous form inputs
        document.getElementById('customerName').value = '';
        document.getElementById('customerPhone').value = '';
        document.getElementById('preferredDate').value = '';
        document.getElementById('preferredTime').value = '';
        document.getElementById('serviceAddress').value = '';
        document.getElementById('additionalNotes').value = '';
        
        // Show modal
        document.getElementById('bookingModal').style.display = 'flex';
    }
    
    // Close modal function
    function closeModal() {
        document.getElementById('bookingModal').style.display = 'none';
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById('bookingModal');
        if (event.target === modal) {
            closeModal();
        }
    }
    
    // Handle form submission
    document.getElementById('bookingForm').addEventListener('submit', function(e) {
        // Validate required fields
        const customerName = document.getElementById('customerName').value;
        const customerPhone = document.getElementById('customerPhone').value;
        const preferredDate = document.getElementById('preferredDate').value;
        const preferredTime = document.getElementById('preferredTime').value;
        const serviceAddress = document.getElementById('serviceAddress').value;
        
        if (!customerName || !customerPhone || !preferredDate || !preferredTime || !serviceAddress) {
            e.preventDefault();
            alert('Please fill in all required fields.');
            return false;
        }
        
        // Validate phone number
        const phoneRegex = /^[\d\s+()-]{8,15}$/;
        if (!phoneRegex.test(customerPhone)) {
            e.preventDefault();
            alert('Please enter a valid phone number.');
            return false;
        }
        
        // Form is valid, will submit to servlet
        showToast('Booking confirmed successfully!');
        // Allow form submission
        return true;
    });
    
    // Show toast message
    function showToast(message) {
        const toast = document.getElementById('toastMessage');
        const toastText = document.getElementById('toastText');
        toastText.textContent = message;
        toast.style.display = 'flex';
        
        setTimeout(function() {
            toast.style.display = 'none';
        }, 3000);
    }
    
    // Check for success message from session
    <c:if test="${not empty sessionScope.bookingSuccess}">
        showToast('${sessionScope.bookingMessage}');
        <c:remove var="bookingSuccess" scope="session"/>
        <c:remove var="bookingMessage" scope="session"/>
    </c:if>
    
    // Auto-open modal if coming from booking page
    <c:if test="${not empty sessionScope.showBookingPopup}">
        window.onload = function() {
            openBookingModal(
                '${sessionScope.popupServiceName}',
                '${sessionScope.popupServicePrice}',
                '${sessionScope.popupServiceCategory}'
            );
        };
        <c:remove var="showBookingPopup" scope="session"/>
        <c:remove var="popupServiceName" scope="session"/>
        <c:remove var="popupServicePrice" scope="session"/>
        <c:remove var="popupServiceCategory" scope="session"/>
    </c:if>
    
    // Sync search input with filter form
    const searchInput = document.getElementById('searchInput');
    if(searchInput) {
        searchInput.addEventListener('input', function() {
            document.getElementById('filterSearchValue').value = this.value;
            document.getElementById('filterForm').submit();
        });
    }
</script>

<!-- FOOTER -->
<footer class="main-footer">
    <div class="footer-grid">
        <div class="footer-brand">
            <div class="logo">
                <i class="fas fa-wrench"></i> ServiceHub
            </div>
            <p>Your trusted home service platform for quality and reliable services.</p>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
        
        <div class="footer-links">
            <h4>Quick Links</h4>
            <p><a href="#">About Us</a></p>
            <p><a href="#">How It Works</a></p>
            <p><a href="#">Why Choose Us</a></p>
            <p><a href="#">FAQs</a></p>
        </div>
        
        <div class="footer-services">
            <h4>Services</h4>
            <p><a href="#">Plumbing</a></p>
            <p><a href="#">Electrical</a></p>
            <p><a href="#">Cleaning</a></p>
            <p><a href="#">Carpentry</a></p>
        </div>
        
        <div class="footer-contact">
            <h4>Contact Info</h4>
            <p><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</p>
            <p><i class="fas fa-phone"></i> +977 9841234567</p>
            <p><i class="fas fa-envelope"></i> info@servicehub.com</p>
        </div>
    </div>
    
    <div class="footer-bottom">
        <p>&copy; 2025 ServiceHub. All rights reserved.</p>
    </div>
</footer>

</body>
</html>